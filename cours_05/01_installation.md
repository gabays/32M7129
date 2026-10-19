# LADAS2TEI 1 : récupérer et installer

**Objectif** : avoir le programme sur votre machine, avec ses dépendances, dans un environnement propre.

## 1. Vérifier git

```bash
git --version
```

- **Linux / WSL** : si la commande n'existe pas, `sudo apt update && sudo apt install -y git python3-venv`.
- **macOS** : la première utilisation de `git` propose d'installer les outils de ligne de commande d'Apple. Acceptez, l'installation prend quelques minutes.

## 2. Cloner le dépôt

**git** est un outil de suivi de versions ; **GitHub** est un site qui héberge des projets git. `git clone` télécharge une copie complète d'un projet :

```bash
cd ~
git clone https://github.com/DEFI-COLaF/LADAS2TEI.git
cd LADAS2TEI
ls
```

Un nouveau dossier `LADAS2TEI` est créé : il faut **entrer dedans** avec `cd`. On y trouve :

| Élément | Rôle |
|---|---|
| `README.md` | mode d'emploi du projet |
| `requirements.txt` | liste des bibliothèques Python nécessaires |
| `ladas2tei/` | le code du programme |
| `tests/` | les tests |

Lisez le début du mode d'emploi :

```bash
head -n 30 README.md
```

## 3. Créer l'environnement virtuel

Comme à la séance précédente :

```bash
python3 -m venv venv
source venv/bin/activate
which python
```

Le prompt affiche `(venv)`, et `which python` doit pointer vers le dossier `venv/`.

## 4. Installer les dépendances

```bash
cat requirements.txt
pip install -r requirements.txt
```

`-r` signifie *requirements* : pip lit le fichier et installe, une par une, toutes les bibliothèques listées. C'est la manière habituelle de reproduire l'environnement d'un projet. Vérification :

```bash
pip list
python -m ladas2tei.main --help
```

> ⚠️ `python -m ladas2tei.main` ne fonctionne que **depuis le dossier `LADAS2TEI`**. Si Python répond `No module named ladas2tei`, vérifiez avec `pwd`.

## Exercice

1. Cloner le dépôt et créer l'environnement.
2. Installer les dépendances.
3. Afficher l'aide du programme et repérer l'option qui permet de donner un fichier de métadonnées.

Étape suivante : [02_donnees.md](02_donnees.md)
