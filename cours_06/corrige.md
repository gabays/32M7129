# Séance 06 : corrigé des exercices

À consulter **après** avoir essayé. Les commandes ont été vérifiées en ligne de commande ; les chemins dans GitHub Desktop peuvent varier un peu selon la version de l'application.

## 01 : comprendre

1. **Git** est le logiciel de suivi de versions, qui fonctionne en local. **GitHub** est un site qui héberge des dépôts git et ajoute des outils pour collaborer.
2. À versionner : une transcription `.txt`, une édition `.xml`, un corpus `.csv`, des scripts. À ne pas versionner : un `.docx` ou un `.pdf` qui change souvent, un gros modèle d'OCR, un mot de passe.
3. Le *commit* a enregistré une version **sur votre ordinateur** ; le *push* l'a envoyée vers le dépôt distant, **sur GitHub**.

## 02 : le premier dépôt

```bash
git log --oneline          # liste des commits, le plus récent en haut
git log -p poeme.txt       # avec les différences
git blame poeme.txt        # facultatif : auteur de chaque ligne
```

Pour retrouver le commit qui a ajouté le nom de l'auteur : `git log -S"Rimbaud" --oneline` (il affiche le commit où le mot apparaît), ou l'onglet `History` de GitHub Desktop.

Pour la synchronisation après une modification en ligne : `git pull` (ou `Fetch origin` puis `Pull origin`).

## 03 : branches et pull requests

Cycle complet : branche, commit, `push`, pull request, fusion, suppression de la branche, puis `git switch main && git pull` : `notes.md` apparaît.

### Facultatif

1. Conflit : après `git merge version-b`, le fichier contient `<<<<<<< HEAD`, `=======` et `>>>>>>> version-b`. On garde par exemple `Sensation (Rimbaud, 1870)`, on **supprime les trois lignes de marqueurs**, puis :

   ```bash
   git add poeme.txt
   git commit -m "Fusionne version-a et version-b"
   ```

   En cas de doute : `git merge --abort`.
2. En binôme, tant que vous modifiez des **lignes différentes**, la fusion de la deuxième pull request se fait sans conflit.
3. Après le fork et le clone : branche, modification, commit, push, puis `Compare & pull request` vers le dépôt d'origine.

## 04 : bilan

Un dépôt bien rangé contient au minimum :

```text
README.md      # présentation, usage, citation
.gitignore     # ce que git ignore (.DS_Store, env/, …)
LICENSE        # par exemple CC BY-SA 4.0 pour des textes, MIT pour du code
```

Le premier README peut tenir en 5 lignes : titre, une phrase de description, contenu du dépôt, licence, comment citer.
