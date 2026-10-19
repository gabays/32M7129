# LADAS2TEI 3 : convertir et vérifier

**Objectif** : produire le fichier TEI, puis s'assurer qu'il est correct.

## 1. La commande

Depuis le dossier `LADAS2TEI`, environnement activé :

```bash
python -m ladas2tei.main corpus -o TEI --metadata-csv metadata.csv
```

| Morceau | Rôle |
|---|---|
| `python -m ladas2tei.main` | lance le programme (module `main` du paquet `ladas2tei`) |
| `corpus` | dossier **parent** contenant un sous-dossier par document |
| `-o TEI` | dossier de sortie |
| `--metadata-csv metadata.csv` | fichier de métadonnées (obligatoire dans ce mode) |

Résultat attendu :

```bash
ls TEI
```

→ un fichier `faux_visage_ONB_10790D2D.xml`.

## 2. Convertir un seul document

On peut aussi viser directement le dossier ALTO, en donnant un titre :

```bash
python -m ladas2tei.main corpus/faux_visage_ONB_10790D2D/alto -o faux_visage.xml --title "Faux visage"
```

On peut même désigner quelques pages seulement :

```bash
python -m ladas2tei.main page_001.xml page_002.xml -o extrait.xml --title "Extrait"
```

## 3. Vérifier le résultat

Combien de lignes, quelle taille ?

```bash
wc -l TEI/faux_visage_ONB_10790D2D.xml
ls -lh TEI
```

Le début du fichier (en-tête TEI et métadonnées) :

```bash
head -n 40 TEI/faux_visage_ONB_10790D2D.xml
```

Quels éléments XML ont été produits, et combien de chacun ?

```bash
grep -o "<[a-zA-Z]*" TEI/faux_visage_ONB_10790D2D.xml | sort | uniq -c | sort -rn | head
```

Le fichier est-il du XML bien formé ? (`xmllint` est installé sur macOS ; sous Linux/WSL : `sudo apt install libxml2-utils`)

```bash
xmllint --noout TEI/faux_visage_ONB_10790D2D.xml
```

Aucun message = tout va bien.

## 4. Les modes particuliers

Selon le type de texte, deux options changent la structure produite :

```bash
python -m ladas2tei.main corpus/faux_visage_ONB_10790D2D/alto -o article.xml --title "Article" --article
python -m ladas2tei.main corpus/faux_visage_ONB_10790D2D/alto -o theatre.xml --title "Pièce" --theatre
```

Comparez les deux sorties avec la commande de comptage de la partie 3.

## 5. Les pièges classiques

| Symptôme | Cause probable |
|---|---|
| `No module named ladas2tei` | on n'est pas dans le dossier `LADAS2TEI` |
| `command not found: python` | environnement non activé (utiliser `python3`, ou `source venv/bin/activate`) |
| erreur sur les métadonnées | nom du dossier différent de celui indiqué dans `metadata.csv` |
| aucun fichier produit | dossier `alto/` vide ou mal nommé |
| chemin introuvable | espace dans un nom de dossier : mettre des guillemets |

## Exercice

1. Lancer la conversion du dossier parent avec les métadonnées.
2. Retrouver dans le TEI le titre et l'auteur donnés dans `metadata.csv`.
3. Compter les éléments produits, et dire quel type d'élément est le plus fréquent.
4. Bonus : écrire un script `convertir.sh` qui active l'environnement, lance la conversion et affiche le décompte des éléments.
