# Annoter un texte avec Flair : parties du discours et entités nommées

Une séance pratique pour **faire annoter automatiquement un texte ancien**, puis exploiter le résultat, entièrement depuis le terminal. On reprend le texte de *Faux visage* (1589) préparé au cours 05.

Un modèle déjà entraîné lit le texte et fait deux choses :

- il donne à chaque mot sa **partie du discours** (nom, verbe, préposition...) ;
- il repère les **entités nommées** : personnes, lieux, dates, fonctions...

On ne programme pas : un petit script Python (`annoter.py`) est fourni. On le lance, on lit ce qu'il produit, et on interroge ses résultats avec les commandes du terminal (`cut`, `sort`, `uniq`, `grep`).

## Objectifs

À la fin de la séance, vous saurez :

- installer **Flair** dans un environnement virtuel ;
- lancer un modèle d'annotation sur un fichier texte ;
- lire un fichier **TSV** (tableau dont les colonnes sont séparées par des tabulations) ;
- compter, trier et filtrer des annotations avec `cut`, `sort`, `uniq`, `grep` et `awk` ;
- repérer les erreurs du modèle et en comprendre l'origine.

## Prérequis

- Avoir suivi les cours 02 (ligne de commande) et 04 (environnement virtuel, `pip`).
- Un terminal de type bash ou zsh : **Linux**, **macOS** ou **Windows avec WSL**.
- Environ **5 Go d'espace disque** (Flair et le modèle) et **8 Go de mémoire vive** (le script en utilise environ 6).

## Déroulé

| Durée | Partie | Contenu |
|---|---|---|
| 0-25 min | [01 - Installation](01_installation.md) | Environnement virtuel, installation de Flair, récupération du modèle |
| 25-55 min | [02 - Annoter](02_annoter.md) | Préparer le texte, lancer `annoter.py`, lire les résultats |
| 55-90 min | [03 - Exploiter](03_exploiter.md) | Compter, trier, filtrer les annotations en ligne de commande |

Chaque partie se termine par un **exercice**. Le [corrigé](corrige.md) est à consulter après avoir essayé. Le notebook [cours_08.ipynb](cours_08.ipynb) reprend la séance en Python, avec des tableaux, des graphiques et les entités colorées dans le texte.

## Contenu du dossier

```text
.
├── README.md
├── 01_installation.md
├── 02_annoter.md
├── 03_exploiter.md
├── corrige.md
├── annoter.py            # le script d'annotation (fourni)
├── cours_08.ipynb        # le notebook de la séance
├── data/
│   └── faux_visage.txt   # le texte du cours 05, un paragraphe ou un vers par ligne
└── model/                # à créer : on y range le modèle (non versionné, 2,3 Go)
```

## Conventions

Les blocs de code contiennent ce que vous devez taper dans le terminal :

```bash
python annoter.py --help
```

Les éléments entre chevrons (`<fichier>`) sont à remplacer par votre propre valeur. Toutes les commandes se lancent **depuis le dossier `cours_08`**, environnement activé.

## Pour aller plus loin

- La [documentation de Flair](https://flairnlp.github.io/docs/intro) présente les autres tâches possibles (classification de textes, entraînement de ses propres modèles).
- Sur les entités nommées dans les textes anciens : Ehrmann *et al.*, « Named Entity Recognition and Classification in Historical Documents: A Survey », *ACM Computing Surveys* 56/2 (2023), https://doi.org/10.1145/3604931.
