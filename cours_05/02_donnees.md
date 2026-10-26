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

Quand on convertit plusieurs documents d'un coup, le programme attend un dossier **parent** (`corpus`), avec un sous-dossier par document, et dans chacun un dossier `alto/` :

```
corpus/
  faux_visage_ONB_10790D2D/
    alto/
      p_001.xml
      p_002.xml
      ...
    images/
      p_001.png
      ...
metadata.csv
```

Les données fournies pour la séance ne sont **pas** rangées ainsi : dans `cours_05/faux_visage_ONB_10790D2D/`, les images (`.png`), les ALTO (`.xml`) et un fichier `METS.xml` sont mélangés au même niveau. On va donc les réorganiser, ce qui est un bon exercice de ligne de commande.

> ⚠️ `METS.xml` décrit le document, ce n'est pas une page. S'il restait avec les ALTO, le programme essaierait de le lire comme une page : on le laisse de côté.

Depuis le dossier `LADAS2TEI`, en remplaçant `<cours_05>` par le chemin du dossier `cours_05` sur votre machine (par exemple `~/32M7129/cours_05`) :

```bash
cd ~/LADAS2TEI
mkdir -p corpus/faux_visage_ONB_10790D2D/alto corpus/faux_visage_ONB_10790D2D/images
cp <cours_05>/faux_visage_ONB_10790D2D/p_*.xml corpus/faux_visage_ONB_10790D2D/alto/
cp <cours_05>/faux_visage_ONB_10790D2D/p_*.png corpus/faux_visage_ONB_10790D2D/images/
cp <cours_05>/metadata.csv .
```

Le motif `p_*.xml` désigne tous les fichiers qui commencent par `p_` et finissent par `.xml` : `METS.xml` n'en fait pas partie.

## 3. Explorer

```bash
ls corpus
ls corpus/faux_visage_ONB_10790D2D
ls corpus/faux_visage_ONB_10790D2D/alto | head
ls corpus/faux_visage_ONB_10790D2D/alto | wc -l
head -n 30 corpus/faux_visage_ONB_10790D2D/alto/p_001.xml
```

Questions à se poser : combien de pages ? comment les fichiers sont-ils nommés ? à quoi ressemble une ligne de texte dans l'ALTO (`String`, `CONTENT`) ?

## 4. Lire les métadonnées

```bash
cat metadata.csv
head -n 1 metadata.csv
```

Le fichier fourni contient les colonnes `file_name`, `number`, `title`, `date`, `author` et `publisher`. LADAS2TEI peut aussi utiliser `encoder`, `publication` et `source` : vous pouvez les ajouter.

La colonne `file_name` (ici `corpus/faux_visage_ONB_10790D2D`) doit correspondre au **chemin du dossier** du document : c'est ainsi que le programme sait quelles métadonnées appliquer à quel document.

## Exercice

1. Compter les pages du document.
2. Trouver, avec `grep`, combien de fois un mot de votre choix apparaît dans l'ALTO de la première page.
3. Afficher les en-têtes de colonnes de `metadata.csv` et repérer celles qui sont remplies.
4. Vérifier que le dossier `alto/` contient bien 24 fichiers, et pas `METS.xml`.

Étape suivante : [03_conversion.md](03_conversion.md)
