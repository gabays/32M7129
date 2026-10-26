# Git 4 : bilan et GitLab

## 1. Aide-mémoire

| Je veux… | GitHub Desktop | Terminal |
|---|---|---|
| récupérer un projet | `File > Clone repository…` | `git clone <url>` |
| voir ce qui a changé | onglet `Changes` | `git status`, `git diff` |
| enregistrer une version | `Commit to <branche>` | `git add <fichier>` puis `git commit -m "…"` |
| envoyer | `Push origin` | `git push` |
| récupérer | `Fetch origin` puis `Pull origin` | `git pull` |
| voir l'historique | onglet `History` | `git log --oneline` |
| créer une branche | `Current Branch > New Branch` | `git switch -c <nom>` |
| changer de branche | `Current Branch` | `git switch <nom>` |
| fusionner | `Branch > Merge into current branch…` | `git merge <nom>` |
| annuler une modification non enregistrée | clic droit > `Discard changes…` | `git restore <fichier>` |
| annuler le dernier commit (pas encore envoyé) | clic droit sur le commit > `Undo Commit…` | `git reset --soft HEAD~1` |

Le cycle de travail habituel : **pull → modifier → commit → push**.

## 2. GitHub et GitLab

Les deux sites font la même chose avec un vocabulaire un peu différent :

| GitHub | GitLab |
|---|---|
| repository | project |
| pull request | merge request |
| Issues | Issues |
| Fork | Fork |
| GitHub Pages | GitLab Pages |
| GitHub Desktop | pas d'application officielle équivalente |

Points à connaître :

- Plusieurs instances GitLab existent : [gitlab.unige.ch](https://gitlab.unige.ch), [gitlab.huma-num.fr](https://gitlab.huma-num.fr) (Huma-Num) et [gitlab.inf.unibe.ch](https://gitlab.inf.unibe.ch) (Berne).
- L'université de Genève héberge sa propre instance, **[gitlab.unige.ch](https://gitlab.unige.ch/)** : on y sait où sont les données, on ne dépend pas de Microsoft (propriétaire de GitHub), et on garde la maîtrise de ses dépôts, ce qui compte depuis que des IA collectent le contenu des dépôts publics. Les notions de cette séance s'y appliquent telles quelles (*project*, *merge request*).
- **GitLab** peut être installé sur un serveur d'institution (Huma-Num, universités, instituts de recherche). C'est un argument pour y héberger des données de recherche.
- **GitHub Desktop** peut cloner n'importe quel dépôt git avec son URL (`File > Clone repository > URL`). Pour pousser vers GitLab, il faut un **jeton d'accès** (`Preferences > Access Tokens`, droit `write_repository`), saisi comme mot de passe.
- Clients graphiques qui gèrent bien GitLab : [GitKraken](https://www.gitkraken.com/), [Sourcetree](https://www.sourcetreeapp.com/), VS Code.

## 3. Pour un projet de recherche : trois fichiers à ajouter

- **`README.md`** : de quoi parle le projet, comment le lire, qui l'a fait.
- **`.gitignore`** : ce que git doit ignorer (`.DS_Store`, environnements `env/`, gros fichiers). GitHub Desktop en propose un à la création du dépôt.
- **`LICENSE`** : sans licence, personne n'a le droit de réutiliser votre travail (`CC BY-SA` pour des textes, `MIT` pour du code).

**Publier un site** : un dépôt GitHub peut servir de serveur web avec [GitHub Pages](https://pages.github.com) (dépôt nommé `NomDuDepot.github.io`, page d'accueil `index.html`). Pour distinguer votre personne de vos projets, vous pouvez aussi créer une **organisation**.

À ne **jamais** versionner : mots de passe, jetons, données personnelles. Un secret poussé une fois reste dans l'historique, même supprimé ensuite.

## Exercice

Rangez le dépôt `edition-poeme` : ajoutez un `.gitignore` et une licence (sur GitHub : `Add file > Create new file`, nom `LICENSE`, qui propose des modèles), faites-en un commit et publiez-le.

---

## Pour aller plus loin (facultatif)

Rien de tout cela n'est nécessaire pour la séance.

![Le modèle Git Flow : branches master, hotfix, release, develop et feature](images/dev.png)

- **Un flux de travail à plusieurs branches** : `main` reste stable, une branche `dev` reçoit les modifications, et chaque nouvelle fonctionnalité (*feature*) a sa propre branche, fusionnée dans `dev`, puis dans `main` quand tout fonctionne. En cas d'urgence, une branche dédiée corrige le problème sans toucher au reste.
- **Les releases** : une version du dépôt marquée par une étiquette (*tag*) : `0.1`, `1.0`… Sur GitHub, `Releases > Draft a new release`. C'est utile pour citer une version précise d'un corpus ou d'un programme.
- **Les issues** : un forum pour signaler un problème ou proposer une modification ; un commit dont le message contient « Corrige #3 » ferme l'issue n° 3.
- **Citer son dépôt** : un fichier `CITATION.cff` à la racine, et l'archivage du dépôt sur [Zenodo](https://zenodo.org/), qui donne un DOI.
- **Publier un site** avec GitHub Pages, ou, pour un site plus travaillé, avec [MkDocs](https://www.mkdocs.org) (demande l'usage de la ligne de commande).
- **Aller plus loin avec git** : le livre [Pro Git](https://git-scm.com/book/fr/v2) (en français, gratuit) et la [documentation de GitHub Desktop](https://docs.github.com/fr/desktop).
