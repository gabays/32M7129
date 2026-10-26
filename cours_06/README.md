# Versionner son travail avec Git et GitHub

Une séance pratique pour ne plus jamais nommer un fichier `memoire_final_v3_VRAIMENT_final.docx`. **Git** garde la mémoire de toutes les versions d'un projet ; **GitHub** (ou **GitLab**) héberge ce projet en ligne pour le sauvegarder, le partager et travailler à plusieurs ; **GitHub Desktop** permet de tout faire avec des boutons, sans taper une commande. Le fil rouge : **versionner l'édition d'un petit texte**, comme on le ferait pour une transcription ou un corpus de recherche.

Vous allez créer un dépôt, enregistrer des versions, les envoyer en ligne, explorer l'historique, puis proposer une modification sur une branche par *pull request*. Chaque geste est montré **avec GitHub Desktop**, puis **en ligne de commande**, pour comprendre ce que fait le bouton.

## Objectifs

À la fin de la séance, vous saurez :

- expliquer ce qu'est un dépôt, un *commit*, une branche et un dépôt distant ;
- créer un compte GitHub et installer **GitHub Desktop** ;
- cloner, modifier, *commit*er, envoyer (*push*) et récupérer (*pull*) des modifications ;
- lire l'historique et retrouver qui a changé quoi, et quand ;
- travailler sur une **branche** et la fusionner par une **pull request** ;
- retrouver les mêmes notions sur **GitLab** ;
- ranger un projet : `README`, `.gitignore`, licence.

C'est une **initiation** : on s'arrête à l'essentiel. Le conflit de fusion, le fork et le travail en binôme sont proposés en fin de partie 03 « pour aller plus loin », à faire chez soi.

## Prérequis

- Une adresse e-mail et une connexion à Internet.
- Avoir suivi la séance [cours_02](../cours_02) (terminal) est utile mais pas obligatoire : la plus grande partie se fait avec la souris.
- Les parties en ligne de commande demandent un terminal de type bash (Linux, macOS ou Windows avec WSL).

## Déroulé

| Durée | Partie | Contenu |
|---|---|---|
| 0-15 min | [00 - Préparation](00-preparation.md) | compte GitHub, GitHub Desktop, identité |
| 15-30 min | [01 - Comprendre Git](01-comprendre.md) | dépôt, commit, branche, distant |
| 30-55 min | [02 - Le premier dépôt](02-premier-depot.md) | créer, modifier, commit, push, historique |
| 55-80 min | [03 - Branches et pull requests](03-collaborer.md) | branche, pull request, fusion ; en option : conflit, fork |
| 80-90 min | [04 - Bilan et GitLab](04-bilan.md) | aide-mémoire, équivalences GitLab, bonnes pratiques |

La [préparation](00-preparation.md) (compte et installation) doit idéalement être faite **avant** la séance. Les [corrigés](corrige.md) sont à consulter après avoir essayé.

## Contenu du dépôt

```text
.
├── README.md
├── 00-preparation.md
├── 01-comprendre.md
├── 02-premier-depot.md
├── 03-collaborer.md
├── 04-bilan.md
└── corrige.md
```

## Conventions

- Les blocs de code contiennent ce que vous devez taper dans le terminal.
- Les noms des boutons de **GitHub Desktop** sont donnés en anglais, tels qu'ils s'affichent (`Commit to main`, `Push origin`…).
- Les éléments entre chevrons (`<votre-nom>`) sont à remplacer par votre propre valeur.

## Pour aller plus loin

- [Documentation de GitHub Desktop](https://docs.github.com/fr/desktop)
- [Pro Git](https://git-scm.com/book/fr/v2), le livre de référence (en français, gratuit)
- [GitHub Pages](https://pages.github.com/) pour publier un site depuis un dépôt
