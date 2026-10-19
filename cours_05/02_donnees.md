# LADAS2TEI 2 : explorer les données

**Objectif** : comprendre ce qu'on va convertir, et placer les fichiers là où le programme les attend.

## 1. Les trois ingrédients

```
images  →  OCR  →  ALTO  →  (LADAS2TEI)  →  TEI
```

- les **images** : les pages numérisées ;
- les fichiers **ALTO** : le résultat de l'OCR, avec le texte, sa position sur la page et un **label** (LADaS) qui dit si un bloc est un titre, un paragraphe, une note… ;
- le fichier **`metadata.csv`** : titre, auteur, date… du document, qui alimentera l'en-tête TEI.

Le programme lit les ALTO ; les images ne servent pas à la conversion, mais elles restent dans le dossier du document.

## 2. L'arborescence attendue

Quand on convertit plusieurs documents d'un coup, le programme attend ceci :

```
corpus/
  faux_visage_ONB_10790D2D/
    alto/
      page_001.xml
      page_002.xml
    images/
metadata.csv
```

Copiez dans votre dossier de travail les données fournies pour la séance :

```bash
cd ~/LADAS2TEI
cp -r <chemin>/corpus .
cp <chemin>/metadata.csv .
```

## 3. Explorer

```bash
ls corpus
ls corpus/faux_visage_ONB_10790D2D
ls corpus/faux_visage_ONB_10790D2D/alto | head
ls corpus/faux_visage_ONB_10790D2D/alto | wc -l
head -n 30 corpus/faux_visage_ONB_10790D2D/alto/<premier_fichier>.xml
```

Questions à se poser : combien de pages ? comment les fichiers sont-ils nommés ? à quoi ressemble une ligne de texte dans l'ALTO (`String`, `CONTENT`) ?

## 4. Lire les métadonnées

```bash
cat metadata.csv
head -n 1 metadata.csv
```

Les colonnes utiles pour LADAS2TEI sont `title`, `author`, `encoder`, `publisher`, `date`, `publication` et `source`. Vérifiez que la ligne du document correspond bien au **nom du dossier** `faux_visage_ONB_10790D2D` : c'est ainsi que le programme sait quelles métadonnées appliquer à quel document.

## Exercice

1. Compter les pages du document.
2. Trouver, avec `grep`, combien de fois un mot de votre choix apparaît dans l'ALTO de la première page.
3. Afficher les en-têtes de colonnes de `metadata.csv` et repérer celles qui sont remplies.

Étape suivante : [03_conversion.md](03_conversion.md)
