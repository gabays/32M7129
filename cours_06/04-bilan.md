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

- L'université de Genève héberge sa propre instance, **[gitlab.unige.ch](https://gitlab.unige.ch/)** : on y sait où sont les données, on ne dépend pas de Microsoft (propriétaire de GitHub), et on garde la maîtrise de ses dépôts, ce qui compte depuis que des IA collectent le contenu des dépôts publics. Les notions de cette séance s'y appliquent telles quelles (*project*, *merge request*).
- **GitLab** peut être installé sur un serveur d'institution (Huma-Num, universités, instituts de recherche). C'est un argument pour y héberger des données de recherche.
- **GitHub Desktop** peut cloner n'importe quel dépôt git avec son URL (`File > Clone repository > URL`). Pour pousser vers GitLab, il faut un **jeton d'accès** (`Preferences > Access Tokens`, droit `write_repository`), saisi comme mot de passe.
- Clients graphiques qui gèrent bien GitLab : [GitKraken](https://www.gitkraken.com/), [Sourcetree](https://www.sourcetreeapp.com/), VS Code.

## 3. Pour un projet de recherche : trois fichiers à ajouter

- **`README.md`** : de quoi parle le projet, comment le lire, qui l'a fait.
- **`.gitignore`** : ce que git doit ignorer (`.DS_Store`, environnements `env/`, gros fichiers). GitHub Desktop en propose un à la création du dépôt.
- **`LICENSE`** : sans licence, personne n'a le droit de réutiliser votre travail (`CC BY-SA` pour des textes, `MIT` pour du code).

À ne **jamais** versionner : mots de passe, jetons, données personnelles. Un secret poussé une fois reste dans l'historique, même supprimé ensuite.

## Exercice

Rangez le dépôt `edition-poeme` : ajoutez un `.gitignore` et une licence (sur GitHub : `Add file > Create new file`, nom `LICENSE`, qui propose des modèles), faites-en un commit et publiez-le.
