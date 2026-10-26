# Git 2 : le premier dépôt

**Objectif** : créer un dépôt, enregistrer plusieurs versions d'un texte, les envoyer sur GitHub et lire l'historique.

Le fil rouge : l'édition d'un court poème du domaine public, que nous allons corriger en plusieurs étapes.

## 1. Créer le dépôt

**Avec GitHub Desktop**

1. `File > New repository…`
2. *Name* : `edition-poeme`. *Local path* : un dossier de votre choix (par exemple `Documents/github`).
3. Cochez **Initialize this repository with a README**.
4. Cliquez sur **Create repository**.

**Dans le terminal**

```bash
mkdir edition-poeme
cd edition-poeme
git init
echo "# Édition d'un poème" > README.md
git add README.md
git commit -m "Premier commit : README"
```

`git init` transforme le dossier en dépôt (il crée un dossier caché `.git` qui contient l'historique : ne le touchez jamais à la main).

## 2. Créer un fichier et faire un premier commit

Créez dans le dossier un fichier `poeme.txt` avec ce texte (une transcription avec une faute volontaire) :

```text
Sensation
Par les soirs bleus d'été, j'irai dans les sentiers,
Picoté par les blès, fouler l'herbe menue :
Rêveur, j'en sentirai la fraîcheur à mes pieds.
Je laisserai le vent baigner ma tête nue.
```

**Avec GitHub Desktop**, l'onglet `Changes` liste `poeme.txt` en vert (fichier ajouté). En bas à gauche, écrivez un message de commit (*Summary*) : `Ajout de la transcription brute`, puis cliquez sur **Commit to main**.

**Dans le terminal**

```bash
git status
git add poeme.txt
git commit -m "Ajout de la transcription brute"
```

> **Un bon message** dit *ce qui a changé et pourquoi*, au présent ou à l'infinitif, en une ligne : « Corrige l'orthographe de la strophe 1 », pas « modif » ni « truc ».

## 3. Modifier, regarder la différence, recommencer

Corrigez dans `poeme.txt` la faute de la deuxième ligne : « blès » doit être **« blés »**. Sauvegardez, puis observez :

**Avec GitHub Desktop** : la ligne modifiée apparaît en **rouge** (supprimée) et en **vert** (ajoutée). Vous pouvez décocher des lignes pour ne les inclure dans le commit qu'en partie.

**Dans le terminal**

```bash
git diff
```

Si la modification est bonne, faites un commit : `Corrige l'accent de « blés »`. Sinon, annulez-la :

- **GitHub Desktop** : clic droit sur le fichier > `Discard changes…`
- **Terminal** : `git restore poeme.txt`

## 4. Envoyer sur GitHub

Pour l'instant, tout reste sur votre ordinateur.

**Avec GitHub Desktop** : cliquez sur **Publish repository**. Décochez *Keep this code private* si vous voulez un dépôt public, puis **Publish repository**.

**Dans le terminal** : créez d'abord un dépôt vide sur github.com (`+ > New repository`, sans README), puis :

```bash
git remote add origin https://github.com/<votre-nom>/edition-poeme.git
git push -u origin main
```

> Le premier `push` en ligne de commande demande de vous authentifier. GitHub n'accepte plus le mot de passe de compte : utilisez GitHub Desktop (il enregistre la connexion), ou un **jeton d'accès personnel** (`Settings > Developer settings > Personal access tokens`) saisi à la place du mot de passe, ou l'outil `gh auth login`.

Actualisez la page de votre dépôt sur github.com : vos fichiers et vos commits y sont.

## 5. Lire l'historique

- **GitHub Desktop** : onglet `History`, cliquez sur un commit pour voir ce qui a changé.
- **GitHub** : bouton `Commits` sur la page du dépôt.
- **Terminal** :

```bash
git log --oneline
git log -p poeme.txt        # chaque commit avec ses différences
```

Cet historique est une trace de recherche : on sait ce qui a été corrigé, quand, et pourquoi.

## 5. Synchroniser : fetch, pull, push

Imaginez que vous modifiez un fichier **directement sur github.com** (icône crayon, puis `Commit changes`). Le dépôt en ligne est maintenant en avance sur votre ordinateur.

- **GitHub Desktop** : le bouton affiche `Fetch origin`, puis `Pull origin` quand il y a des nouveautés. Cliquez dessus.
- **Terminal** : `git pull`.

La règle d'or : **`pull` avant de commencer à travailler, `push` quand on a fini**.

## Exercice

1. Créez `edition-poeme` et publiez-le sur GitHub.
2. Faites au moins **deux commits** distincts sur `poeme.txt` (par exemple : correction de « blés », ajout du nom de l'auteur, ajout de la date de composition).
3. Retrouvez dans l'historique le commit qui a ajouté le nom de l'auteur.
4. Modifiez le fichier en ligne sur github.com, puis récupérez le changement sur votre ordinateur.

Étape suivante : [03-collaborer.md](03-collaborer.md)
