# 04 - Bilan

> Durée : 5 minutes.

## Aide-mémoire

### Se repérer et ranger

| Commande | Rôle |
|---|---|
| `pwd` | Afficher le dossier courant |
| `ls`, `ls -l`, `ls -a` | Lister (avec détails, avec fichiers cachés) |
| `cd dossier`, `cd ..`, `cd ~` | Entrer dans un dossier, remonter, retourner chez soi |
| `mkdir dossier`, `mkdir -p a/b/c` | Créer un dossier (et ses parents) |
| `touch fichier` | Créer un fichier vide |
| `cp source destination` | Copier (`-r` pour un dossier) |
| `mv source destination` | Déplacer ou renommer |
| `rm fichier`, `rm -r dossier` | Supprimer (**sans corbeille**) |
| `echo "texte"` | Afficher un texte |

### Lire et fouiller

| Commande | Rôle |
|---|---|
| `cat fichier` | Afficher tout le fichier |
| `head -n 20 fichier`, `tail -n 20 fichier` | Début, fin d'un fichier |
| `less fichier` | Lire page par page (`q` pour quitter) |
| `wc -l`, `wc -w` | Compter les lignes, les mots |
| `grep mot fichier` | Chercher les lignes qui contiennent un mot |
| `grep -i`, `-n`, `-c`, `-o`, `-C 1` | Sans casse, numéros de ligne, comptage, occurrences seules, contexte |
| `sort`, `sort -f`, `sort -rn` | Trier (alphabétique, sans casse, numérique décroissant) |
| `uniq -c` | Regrouper les lignes identiques et les compter |

### Assembler

| Symbole | Rôle |
|---|---|
| <code>&#124;</code> (pipe) | Envoyer le résultat d'une commande à la suivante |
| `>` | Écrire le résultat dans un fichier (écrase) |
| `>>` | Ajouter le résultat à la fin d'un fichier |
| `*` | Joker : `*.txt` désigne tous les fichiers `.txt` |

### Scripts

| Élément | Rôle |
|---|---|
| `#!/bin/bash` | Première ligne d'un script bash |
| `$1`, `$2` | Premier, deuxième argument du script |
| `variable="valeur"` puis `$variable` | Définir et utiliser une variable |
| `for x in liste; do ... done` | Répéter des commandes pour chaque élément |
| `chmod +x script.sh` puis `./script.sh` | Rendre exécutable, puis lancer |

### Réflexes

- **Tab** pour compléter, **↑** pour rappeler, **Ctrl + C** pour interrompre.
- Avant de valider une commande avec `rm`, relisez-la.
- Avec Claude : contexte, objectif, données, consigne. Puis comprendre, tester, vérifier.

## Ce que vous avez appris à faire

Vous êtes parti·e de zéro et vous savez désormais interroger un texte entier en une ligne, et faire écrire un petit script à une IA en sachant le lire, le tester et le corriger. Ces outils s'appliquent à n'importe quel texte : votre propre corpus, des archives numérisées, des transcriptions d'entretiens…

## Pour continuer

- Refaites les exercices sur **d'autres textes** : ceux de vos cours, de vos recherches, ou d'autres livres du [Projet Gutenberg](https://www.gutenberg.org/).
- Explorez d'autres commandes avec Claude : `find` (chercher des fichiers), `sed` (remplacer du texte), `cut` (extraire des colonnes), `diff` (comparer deux fichiers).
- Deux ressources d'apprentissage en ligne : la leçon *The Unix Shell* de Software Carpentry, et la leçon *Introduction to the Bash Command Line* du *Programming Historian*, pensée pour les humanités.
- Pour aller plus loin dans l'organisation de votre travail : découvrez `git` et GitHub, que vous avez déjà utilisés sans le savoir pour récupérer ce cours.
