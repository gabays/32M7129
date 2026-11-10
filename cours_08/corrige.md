# Séance 08 : corrigé des exercices

À consulter **après** avoir essayé. Les chiffres viennent d'un essai complet du script ; ils peuvent varier très légèrement d'une machine à l'autre.

## 01 : installation

```bash
cd 32M7129/cours_08
python3 -m venv env
source env/bin/activate
pip install --upgrade pip
pip install flair==0.15.1
python -c "import flair; print(flair.__version__)"   # 0.15.1
mkdir -p model && cd model
curl -L -O https://github.com/gabays/32M7129/releases/download/0.1/model-v6.pt.part_aa
curl -L -O https://github.com/gabays/32M7129/releases/download/0.1/model-v6.pt.part_ab
cat model-v6.pt.part_aa model-v6.pt.part_ab > model-v6.pt
rm model-v6.pt.part_aa model-v6.pt.part_ab
ls -lh                                               # model-v6.pt, environ 2,2G
cd ..
python annoter.py --help
```

Options du script : `-m` (chemin du modèle, par défaut `model/model-v6.pt`) et `-o` (dossier de sortie, par défaut `resultats`).

## 02 : annoter

```bash
sed 's/¬ //g' data/faux_visage.txt > faux_visage_propre.txt
grep -o '¬' faux_visage_propre.txt | wc -l     # 1
grep -n '¬' faux_visage_propre.txt
python annoter.py faux_visage_propre.txt
```

Le `¬` restant (ligne 106, *tyrãnique¬*) est **en fin de ligne** : il n'est pas suivi d'une espace, donc le motif `¬ ` ne le trouve pas. C'est un mot coupé entre deux paragraphes du TEI : il faudrait recoller les deux lignes à la main.

Résultat : 251 phrases, environ 6 800 mots annotés, 125 entités au niveau `coarse`, environ 2 minutes d'annotation.

Erreurs typiques de parties du discours :

- *qu’* étiqueté `Nc` (nom commun) au lieu de `Cs` ou `Pr` ;
- *pas* étiqueté `Nc` au lieu d'adverbe de négation ;
- en tête de texte, *DE* de *DE VALOYS* étiqueté `Np` (nom propre) : les majuscules trompent le modèle.

Entités les moins sûres : *duc de Guiſe* (0.84, phrase 33), *Roy d’Eſpagne* (0.87), *Rocheſtre* (0.88), *VALOYS* (0.89). Exemples d'entités mal découpées : *Ieſabel d’*, *Ieſus-Chriſt Charle-maigne* (deux personnes réunies en une).

## 03 : exploiter

1. Verbes conjugués :

```bash
awk -F'\t' '$3 == "Vvc"' faux_visage_propre.pos.tsv | cut -f2 | sort | uniq -c | sort -rn | head
```

En tête : *peut*, *faict*, *doit* (4 fois chacun), puis *veut*, *reſte*, *laiſſe*, *fit*, *faiſoit*, *dit*, *direz* (3 fois). Les auxiliaires (*a*, *eſt*) ont leur propre étiquette, `Vuc`.

2. Lieux :

```bash
awk -F'\t' '$2 == "coarse" && $4 == "loc"' faux_visage_propre.entites.tsv | cut -f3 | sort | uniq -c | sort -rn
```

14 formes différentes : *France* (26), *Paris* (3), *ville de Paris* (2), *Calais* (2), *Angleterre* (2), *ville de PARIS*, *villace de Poitiers*, *Rochelle*, *Poytiers*, *Poiſſy*, *Paleſtine*, *Mets*, *Europe*, *Allemagne*. Une fois les variantes regroupées (les trois *Paris*, les deux *Poitiers*), il reste **11 lieux**. Il faudrait y ajouter les *Frãce* classés comme personnes.

3. Exemple d'erreur : *P Aris* (personne, alors que c'est la ville de Paris).

```bash
grep "P Aris" faux_visage_propre.entites.tsv            # phrase 232
awk -F'\t' '$1 == "232"' faux_visage_propre.pos.tsv | cut -f2 | tr '\n' ' '
```

Phrase : *P Aris , n’ honore plus Henry plain , de feintiſe ,* L'erreur vient de la **transcription** : la lettrine *P* a été séparée du reste du mot dans le TEI (cours 05). Le modèle, qui voit « P Aris » en majuscules, en fait un nom de personne. Même cause pour *S Vs*, *M Ais* et *ENRY DE VALLOYS* (lettrine *H* perdue).

**À retenir** : la qualité de l'annotation dépend de toute la chaîne (OCR, transcription, nettoyage). Avant d'accuser le modèle, on regarde ce qu'on lui a donné.
