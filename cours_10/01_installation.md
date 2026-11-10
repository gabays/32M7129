# SuperStyl 1 : installation

**Objectif** : avoir SuperStyl dans le dossier du cours, et un environnement Python où il fonctionne.

## 1. Vérifier la version de Python

```bash
python3 --version
```

SuperStyl demande **Python 3.10 à 3.12**. Si vous avez 3.13, installez une version 3.12 depuis [python.org](https://www.python.org/downloads) et utilisez `python3.12` à la place de `python3` ci-dessous.

## 2. Récupérer SuperStyl

SuperStyl n'est pas sur PyPI : on le récupère directement depuis GitHub (voir le cours 06).

```bash
cd 32M7129/cours_10
git clone https://github.com/SupervisedStylometry/SuperStyl.git
ls SuperStyl
```

On y trouve deux scripts qui nous intéressent :

- `load_corpus.py` : transforme les textes en tableau de fréquences ;
- `train_svm.py` : entraîne et évalue un modèle sur ce tableau.

## 3. Environnement virtuel et dépendances

```bash
python3 -m venv env
source env/bin/activate
pip install --upgrade pip
pip install -r SuperStyl/requirements.txt
```

`pip install -r` installe **toutes les bibliothèques listées** dans le fichier `requirements.txt` (scikit-learn, pandas, nltk...). Cela prend quelques minutes.

Vérification :

```bash
python SuperStyl/load_corpus.py --help
python SuperStyl/train_svm.py --help
```

Les deux commandes doivent afficher la liste de leurs options.

> Si `pip` échoue en compilant `scipy`, c'est presque toujours que Python est trop récent (3.13) : recréez l'environnement avec `python3.12 -m venv env`.

## Exercice

1. Installer SuperStyl et afficher l'aide des deux scripts.
2. Dans l'aide de `load_corpus.py`, trouver l'option qui choisit le **type de traits** (`-t`) : quelles valeurs accepte-t-elle ?
3. Dans l'aide de `train_svm.py`, quelles sont les trois façons de faire une **validation croisée** ?

Étape suivante : [02_corpus.md](02_corpus.md)
