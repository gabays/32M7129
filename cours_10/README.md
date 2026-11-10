# Attribuer un texte à son auteur avec SuperStyl

Une séance pratique de **stylométrie supervisée** : on apprend à une machine à reconnaître le style de quatre romanciers du XIXe siècle, puis on mesure si elle y parvient sur des romans qu'elle n'a jamais vus. Tout se fait en ligne de commande avec [SuperStyl](https://github.com/SupervisedStylometry/SuperStyl), puis on compare plusieurs réglages pour trouver le meilleur.

Le corpus `corpus/romans_20s` contient 30 romans :

| Auteur | Romans |
|---|---|
| Gustave Aimard | 8 |
| Henri-Émile Chevalier | 10 |
| Gustave Flaubert | 6 |
| Pierre-Alexis Ponson du Terrail | 6 |

## Objectifs

À la fin de la séance, vous saurez :

- installer un outil depuis GitHub avec `git clone` et `pip install -r` ;
- transformer des textes en **tableaux de fréquences** (mots, caractères) découpés en échantillons ;
- entraîner un classifieur (SVM) et l'évaluer par **validation croisée** ;
- lire un rapport de classification et une matrice de confusion ;
- comparer plusieurs configurations avec un **script bash**, et choisir la meilleure.

## Prérequis

- Les cours 02 (ligne de commande) et 04 (environnement virtuel, `pip`).
- **Python 3.10, 3.11 ou 3.12** : SuperStyl ne s'installe pas encore avec Python 3.13.
- Un terminal de type bash ou zsh : **Linux**, **macOS** ou **Windows avec WSL**.

## Déroulé

| Durée | Partie | Contenu |
|---|---|---|
| 0-15 min | [01 - Installation](01_installation.md) | Cloner SuperStyl, environnement virtuel, dépendances |
| 15-35 min | [02 - Préparer le corpus](02_corpus.md) | Échantillons, traits, `load_corpus.py` |
| 35-60 min | [03 - Entraîner et évaluer](03_entrainer.md) | `train_svm.py`, validation croisée, lire les résultats |
| 60-90 min | [04 - Comparer des configurations](04_comparer.md) | `benchmark.sh` : quelle configuration est la meilleure ? |

Chaque partie se termine par un **exercice**. Le [corrigé](corrige.md) est à consulter après avoir essayé. Le notebook [cours_10.ipynb](cours_10.ipynb) reprend la séance en Python, avec des graphiques.

## Contenu du dossier

```text
.
├── README.md
├── 01_installation.md
├── 02_corpus.md
├── 03_entrainer.md
├── 04_comparer.md
├── corrige.md
├── benchmark.sh          # le script de comparaison (partie 04)
├── cours_10.ipynb        # le notebook de la séance
├── corpus/
│   ├── romans_20s/txt/   # le corpus de la séance
│   ├── romans_40s/       # d'autres corpus, pour aller plus loin
│   └── poesie/
└── SuperStyl/            # à cloner (partie 01), non versionné
```

## Conventions

Toutes les commandes se lancent **depuis le dossier `cours_10`**, environnement activé. Les éléments entre chevrons (`<fichier>`) sont à remplacer par votre propre valeur.

## Pour aller plus loin

- Sur la stylométrie et ses méthodes : Florian Cafiero et Jean-Baptiste Camps, « Why Molière most likely did write his plays », *Science Advances* 5/11 (2019), https://doi.org/10.1126/sciadv.aax5489 (par les auteurs de SuperStyl). Pour citer l’outil lui-même : Jean-Baptiste Camps et Florian Cafiero, *SUPERvised STYLometry (SuperStyl)*, https://doi.org/10.5281/zenodo.14069799.
- La [documentation de SuperStyl](https://github.com/SupervisedStylometry/SuperStyl) : options avancées, attribution de textes anonymes (`--final`), stylométrie « glissante » (`--plot_rolling`).
