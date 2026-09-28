# Découvrir la ligne de commande par les mots

Une introduction de 1h30 au terminal (bash), pensée pour des étudiantes et des étudiants de lettres et de sciences humaines. Le fil rouge : **le texte comme matière première**. Vous allez manipuler de vrais romans du domaine public et poser des questions simples à des textes entiers : combien de mots ? Où apparaît « amour » ? Quels sont les mots les plus fréquents ?

Vous apprendrez aussi à **demander de l'aide à Claude** (une IA) pour écrire de petits scripts, en gardant la main : comprendre ce qu'on exécute, vérifier le résultat, corriger.

## Objectifs

À la fin de la séance, vous saurez :

- vous repérer et vous déplacer dans vos dossiers depuis le terminal ;
- créer, copier, déplacer et supprimer des fichiers ;
- lire un texte et le fouiller avec `head`, `wc`, `grep`, `sort`, `uniq` ;
- enchaîner des commandes avec les pipes (`|`) et enregistrer un résultat (`>`) ;
- rédiger une demande claire à Claude, lire sa réponse d'un œil critique et en tirer un petit script ;
- écrire et lancer un script bash très simple.

Aucune connaissance préalable en informatique n'est nécessaire.

## Déroulé

| Durée | Partie | Contenu |
|---|---|---|
| 0-10 min | [00 - Préparation](00-preparation.md) | Compte Claude, terminal, récupération des fichiers |
| 10-30 min | [01 - Naviguer et ranger](01-naviguer.md) | `pwd`, `ls`, `cd`, `mkdir`, `touch`, `cp`, `mv`, `rm` |
| 30-55 min | [02 - Lire et fouiller un texte](02-texte.md) | `cat`, `head`, `tail`, `less`, `wc`, `grep`, pipes, redirections |
| 55-85 min | [03 - Claude et premiers scripts](03-claude-et-scripts.md) | Bien poser sa question, lire une commande, écrire un script |
| 85-90 min | [04 - Bilan](04-bilan.md) | Aide-mémoire et pistes pour continuer |

**Important :** la [préparation](00-preparation.md) (compte Claude et, sous Windows, installation de WSL) doit idéalement être faite **avant** la séance. L'installation de WSL prend du temps et demande un redémarrage.

## Contenu du dépôt

```text
.
├── README.md
├── 00-preparation.md
├── 01-naviguer.md
├── 02-texte.md
├── 03-claude-et-scripts.md
├── 04-bilan.md
├── corpus/
│   └── telecharger.sh    # télécharge les textes du corpus
└── tresor/               # dossier pour la chasse au trésor (partie 01)
```

## Conventions

Dans les exemples, les blocs de code contiennent ce que vous devez taper dans le terminal :

```bash
pwd
```

Le symbole `$` que vous verrez parfois au début d'une ligne représente l'invite du terminal (le *prompt*) : ne le tapez pas.

Les textes du corpus (*Candide*, *Madame Bovary*, *Germinal*) proviennent du [Projet Gutenberg](https://www.gutenberg.org/) et sont dans le domaine public.
