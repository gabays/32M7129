# Git 1 : comprendre

**Objectif** : avoir en tête le vocabulaire avant de cliquer.

## 1. Le problème

Vous écrivez un texte. Vous en gardez des copies pour pouvoir revenir en arrière : `texte.txt`, `texte2.txt`, `texte_final.txt`… On ne sait plus quelle version est la bonne, ni ce qui a changé entre les deux, ni qui l'a changé. Et avec plusieurs auteurs, c'est pire.

**Git** résout ce problème : au lieu de copier les fichiers, il **enregistre les différences** à chaque étape que vous décidez de garder, avec un message qui dit pourquoi.

## 2. Le vocabulaire

| Terme | Sens |
|---|---|
| **dépôt** (*repository*, *repo*) | un dossier de projet dont git suit l'historique |
| **commit** | une version enregistrée : un instantané du projet, avec un auteur, une date et un message |
| **historique** | la suite des commits, du plus ancien au plus récent |
| **branche** | une ligne de travail parallèle ; la branche principale s'appelle `main` |
| **dépôt distant** (*remote*) | la copie du dépôt hébergée en ligne (sur GitHub), nommée `origin` |
| **clone** | télécharger une copie complète d'un dépôt |
| **push** | envoyer ses commits vers le dépôt distant |
| **pull** | récupérer les commits du dépôt distant |
| **pull request** | demande de fusion d'une branche dans une autre, avec discussion et relecture |
| **conflit** | deux modifications incompatibles du même endroit : il faut choisir |

## 3. Git, GitHub, GitHub Desktop : ne pas confondre

| | Rôle |
|---|---|
| **Git** | le logiciel de suivi de versions, qui fonctionne **en local**, sans Internet |
| **GitHub** / **GitLab** | des sites qui **hébergent** des dépôts git et ajoutent des outils (pull requests, tickets, pages web) |
| **GitHub Desktop** | une application qui pilote git avec des boutons |

## 4. Les trois zones d'un dépôt

```text
 dossier de travail  ──(choisir)──▶  zone de préparation  ──(commit)──▶  historique
 (vos fichiers)                       (staging)                          (le dépôt)
```

1. Vous **modifiez** vos fichiers normalement.
2. Vous **choisissez** quelles modifications vont dans la prochaine version.
3. Vous faites un **commit** : la version est enregistrée.

Dans GitHub Desktop, les cases à cocher de l'onglet `Changes` jouent le rôle de la zone de préparation.

## 5. Ce que git suit bien, et mal

- **Bien** : les fichiers **texte** (`.txt`, `.md`, `.xml`, `.tei`, `.csv`, code). On voit ligne à ligne ce qui a changé.
- **Mal** : les fichiers binaires (`.docx`, `.pdf`, images, gros modèles). Git les stocke, mais ne peut pas montrer ce qui a changé, et le dépôt grossit vite.

Pour la recherche en humanités numériques, git convient très bien aux transcriptions, éditions XML-TEI, données tabulaires et scripts, soit tout ce que nous avons produit dans les séances précédentes.

## Exercice

1. Quelle différence y a-t-il entre `git` et `GitHub` ?
2. Citez deux fichiers de votre travail qu'il serait pertinent de versionner, et un qui ne l'est pas.
3. Dans la phrase « j'ai fait un commit puis un push », que s'est-il passé, et où ?

Étape suivante : [02-premier-depot.md](02-premier-depot.md)
