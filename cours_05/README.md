# Convertir de l'ALTO en TEI avec LADAS2TEI

Une séance pratique pour récupérer un programme sur GitHub, l'installer, puis l'utiliser sur un vrai document numérisé : transformer des fichiers **ALTO** (le résultat d'une OCR) en un fichier **TEI** (le format de l'édition numérique), le tout depuis le terminal. Le fil rouge reste le même : **on tape tout, on comprend chaque commande**.

Vous allez cloner le dépôt [LADAS2TEI](https://github.com/DEFI-COLaF/LADAS2TEI/), installer ses dépendances, explorer le document à convertir, lancer la conversion avec ses métadonnées, puis vérifier le fichier obtenu avec les commandes de traitement de texte déjà vues.

## Objectifs

À la fin de la séance, vous saurez :

- récupérer un projet avec **`git clone`** ;
- installer ses dépendances avec **`pip install -r requirements.txt`** dans un environnement virtuel ;
- lire le README d'un projet pour trouver la bonne commande ;
- organiser un dossier de données (ALTO, images, métadonnées) ;
- lancer un programme Python avec `python -m` et ses options ;
- vérifier un fichier XML avec `head`, `grep`, `sort` et `uniq`.

## Prérequis

- Avoir suivi la séance précédente ([cours_04](../cours_04)) : environnement virtuel, `pip`, ligne de commande.
- Un terminal de type bash : **Linux**, **macOS** ou **Windows avec WSL**.
- **git** installé (voir la partie 01).
- Une connexion à Internet.

## Déroulé

| Durée | Partie | Contenu |
|---|---|---|
| 0-25 min | [01 - Récupérer et installer](01_installation.md) | `git clone`, environnement virtuel, `pip install -r requirements.txt` |
| 25-45 min | [02 - Explorer les données](02_donnees.md) | ALTO, images, `metadata.csv`, arborescence attendue |
| 45-90 min | [03 - Convertir et vérifier](03_conversion.md) | `python -m ladas2tei.main`, options, contrôle du TEI |

Chaque partie se termine par un **exercice**.

## Contenu du dépôt

```text
.
├── README.md
├── 01_installation.md
├── 02_donnees.md
├── 03_conversion.md
├── corpus/
│   └── faux_visage_ONB_10790D2D/
│       ├── alto/          # une page = un fichier XML
│       └── images/        # les images des pages
└── metadata.csv           # métadonnées du document
```

## Conventions

Les blocs de code contiennent ce que vous devez taper dans le terminal :

```bash
git --version
```

Les éléments entre chevrons (`<dossier>`) sont à remplacer par votre propre valeur. Les commandes sont identiques sous Linux, macOS et WSL.

## Pour aller plus loin

Le [README de LADAS2TEI](https://github.com/DEFI-COLaF/LADAS2TEI/) décrit aussi les modes `--article` et `--theatre`, ainsi que l'organisation du code (`alto.py`, `ordering.py`, `tei.py`…).
