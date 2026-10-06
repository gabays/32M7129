# Kraken 1 : environnement virtuel et installation

**Objectif** : avoir un environnement Python propre dans lequel Kraken est installé et fonctionne.

Les commandes sont les mêmes sous **Linux**, **macOS** et **Windows (WSL)** : on travaille toujours dans un terminal de type bash.

## 1. Vérifier Python

```bash
python3 --version
```

Il faut un Python récent (3.10 à 3.12 conseillé). Sous Linux/WSL, si la suite échoue, installer le module manquant :

```bash
sudo apt update && sudo apt install -y python3-venv python3-pip
```

Vous pouvez aussi les installer en récupérant une version [à cette adresse](https://www.python.org/downloads).


## 2. Pourquoi un environnement virtuel ?

Un environnement virtuel est un dossier **isolé** contenant son propre Python et ses propres bibliothèques.

- on n'abîme pas le Python du système ;
- un projet = un environnement, sans conflits de versions ;
- si tout casse, on supprime le dossier et on recommence.

## 3. Créer et activer l'environnement

```bash
cd 32M7129/cours_03
python3 -m venv .venv
source .venv/bin/activate
```

Si vous avez besoin d'une version spécifique de Python, comme 3.10 (que vous devez installer en la récupérant [à cette adresse](https://www.python.org/downloads)):

```bash
virtualenv -p python3.10 env 
```

Le prompt affiche maintenant `(.venv)` : on est **dans** l'environnement. Pour en sortir :

```bash
deactivate
```

> ⚠️ À chaque nouvelle fenêtre de terminal, il faut refaire `source .venv/bin/activate` (depuis le dossier `kraken_cours`).

## 4. pip en deux minutes

`pip` est le gestionnaire de paquets de Python : il télécharge des bibliothèques depuis **PyPI** (le catalogue public) et les installe dans l'environnement actif.

```bash
pip install nom_du_paquet      # installer
pip list                       # voir ce qui est installé
pip install -U nom_du_paquet   # mettre à jour
which pip                      # doit pointer vers .venv/
```

Si `which pip` ne pointe pas vers `.venv`, l'environnement n'est pas activé.

## 5. Installer Kraken

```bash
pip install --upgrade pip
pip install kraken
```

L'installation prend quelques minutes (PyTorch est volumineux). Vérification :

```bash
kraken --version
ketos --help
```

- `kraken` : **utiliser** un modèle (segmentation, reconnaissance)
- `ketos` : **entraîner** et évaluer des modèles

## Exercice

Créer l'environnement, installer Kraken, et afficher la version.

Étape suivante : [02_ocr.md](02_ocr.md)
