"""Annoter un texte avec le modèle Flair du cours 08.

Usage :
    python annoter.py <texte.txt>
    python annoter.py <texte.txt> -o resultats

Le texte doit contenir un paragraphe (ou un vers) par ligne.
Le script écrit deux fichiers dans le dossier de sortie :
    <nom>.pos.tsv       un mot par ligne et sa partie du discours
    <nom>.entites.tsv   une entité nommée par ligne
"""

import argparse
import re
import sys
import time
from pathlib import Path

import flair
import torch
from flair.data import Sentence
from flair.models import SequenceTagger
from segtok.segmenter import split_single

# Un mot : lettres ou chiffres (y compris accents et tildes), éventuellement reliées par des traits
# d'union (« Ieſus-Chriſt »). Une apostrophe reste collée au mot qui la précède
# (« qu’ » + « il »). Tout autre signe (ponctuation) forme un mot à lui seul.
LETTRE = r"(?:[^\W_]|[\u0300-\u036f])"
MOT = re.compile(rf"{LETTRE}+(?:-{LETTRE}+)*['’]?|\S")


def decouper(ligne):
    """Découpe une ligne en phrases, puis chaque phrase en mots."""
    phrases = []
    for texte in split_single(ligne):
        if not texte.strip():
            continue
        phrase = Sentence(MOT.findall(texte))
        for mot in phrase:
            if mot.text[-1] in "'’":
                mot.whitespace_after = 0  # « d’Eſpagne » et non « d’ Eſpagne »
        phrases.append(phrase)
    return phrases


# Les quatre couches d'entités prédites par le modèle
NIVEAUX = ["coarse", "fine", "finecomp", "nest"]


def charger(chemin):
    """Charge les cinq tâches du modèle en ne gardant qu'une copie du transformer.

    Le modèle contient cinq tâches (une pour les parties du discours, quatre
    pour les entités nommées) qui partagent le même transformer.
    MultitaskModel.load() en créerait cinq copies (plus de 12 Go de mémoire) :
    on charge donc les tâches une à une en leur passant le même transformer.
    """
    etat = torch.load(chemin, map_location="cpu", weights_only=False, mmap=True)
    taches, partage = [], None
    for etat_tache in etat["model_states"].values():
        if partage is not None:
            etat_tache["embeddings"] = partage
        tache = SequenceTagger._init_model_with_state_dict(etat_tache)
        tache.eval()
        partage = tache.embeddings
        taches.append(tache)
    return taches


def main():
    parser = argparse.ArgumentParser(description="Annoter un texte avec Flair.")
    parser.add_argument("texte", help="fichier texte à annoter (.txt)")
    parser.add_argument("-m", "--modele", default="model/model-v6.pt",
                        help="chemin du modèle (défaut : model/model-v6.pt)")
    parser.add_argument("-o", "--sortie", default="resultats",
                        help="dossier de sortie (défaut : resultats)")
    args = parser.parse_args()

    texte = Path(args.texte)
    if not texte.exists():
        sys.exit(f"Fichier introuvable : {texte}")
    if not Path(args.modele).exists():
        sys.exit(f"Modèle introuvable : {args.modele} (voir 01_installation.md)")

    flair.device = torch.device("cpu")
    torch.set_grad_enabled(False)

    print("Chargement du modèle...")
    taches = charger(args.modele)

    # Découper chaque ligne du fichier en phrases, et chaque phrase en mots
    phrases = []
    for ligne in texte.read_text(encoding="utf-8").splitlines():
        phrases.extend(decouper(ligne))
    print(f"{len(phrases)} phrases à annoter...")

    debut = time.time()
    for tache in taches:
        print(f"Tâche {tache.tag_type}...")
        # "cpu" garde en mémoire le calcul du transformer :
        # il n'est fait qu'une fois et resservira aux tâches suivantes.
        tache.predict(phrases, mini_batch_size=8, embedding_storage_mode="cpu",
                      verbose=tache is taches[0])
    print(f"Annotation terminée en {time.time() - debut:.0f} secondes.")

    sortie = Path(args.sortie)
    sortie.mkdir(exist_ok=True)
    fichier_pos = sortie / f"{texte.stem}.pos.tsv"
    fichier_ent = sortie / f"{texte.stem}.entites.tsv"

    with open(fichier_pos, "w", encoding="utf-8") as f:
        f.write("phrase\tmot\tpos\n")
        for n, phrase in enumerate(phrases, start=1):
            for mot in phrase:
                f.write(f"{n}\t{mot.text}\t{mot.get_label('pos').value}\n")

    nb_entites = 0
    with open(fichier_ent, "w", encoding="utf-8") as f:
        f.write("phrase\tniveau\tentite\ttype\tscore\n")
        for n, phrase in enumerate(phrases, start=1):
            for niveau in NIVEAUX:
                for span in phrase.get_spans(niveau):
                    label = span.get_label(niveau)
                    f.write(f"{n}\t{niveau}\t{span.text}\t{label.value}\t{label.score:.2f}\n")
                    nb_entites += niveau == "coarse"

    print(f"{nb_entites} entités (niveau coarse) trouvées.")
    print(f"Résultats : {fichier_pos} et {fichier_ent}")


if __name__ == "__main__":
    main()
