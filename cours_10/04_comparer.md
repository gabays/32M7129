# SuperStyl 4 : comparer des configurations

**Objectif** : tester plusieurs réglages automatiquement, avec un script bash, et choisir le meilleur en connaissance de cause.

Jusqu'ici, nous avons fait des choix un peu au hasard : des mots ou des caractères ? 100 traits ou 1000 ? Des échantillons de 2000 mots ? En recherche, on ne choisit pas : on **compare**, et on justifie.

## 1. Lancer le benchmark

```bash
bash benchmark.sh
```

Le script prend **15 à 20 minutes** : l'extraction des trigrammes de caractères est lente. Pendant ce temps, lisez-le :

```bash
less benchmark.sh
```

Il définit deux **fonctions** :

- `extraire <nom> <options>` lance `load_corpus.py` avec ces options, sauf si le tableau existe déjà (on peut donc relancer le script sans tout recalculer) ;
- `entrainer <nom> <options>` lance `train_svm.py` en `group-k-fold`, puis récupère dans l'affichage la ligne `accuracy` et la ligne `macro avg` avec `grep` et `awk`, et les ajoute au tableau `benchmark/resultats.tsv`.

Il teste trois questions :

| Question | Configurations comparées |
|---|---|
| Quels traits ? | trigrammes de caractères, affixes, 100 mots, 300 mots (échantillons de 2000 mots) |
| Quelle taille d'échantillon ? | 500, 1000, 2000, 5000 mots (trigrammes) |
| Quelles options d'entraînement ? | pondération des classes, sous-échantillonnage, réduction de dimension (PCA), noyau `rbf` |

## 2. Lire les résultats

```bash
column -t -s $'\t' benchmark/resultats.tsv
```

Pour classer les configurations de la meilleure à la moins bonne :

```bash
tail -n +2 benchmark/resultats.tsv | sort -t$'\t' -k3 -rn | column -t -s $'\t'
```

`tail -n +2` : tout sauf la première ligne (l'en-tête) ; `-t$'\t'` : les colonnes sont séparées par des tabulations ; `-k3` : trier sur la 3e colonne (l'exactitude) ; `-rn` : numériquement, du plus grand au plus petit.

## 3. Interpréter

Un bon score ne suffit pas : il faut savoir **ce qu'il mesure** et **à quel prix**.

- **La taille des échantillons** : plus un échantillon est long, plus les fréquences sont stables, et plus l'attribution est sûre. Mais en pratique, on veut souvent attribuer un texte court (une lettre, un article, un poème) : un modèle excellent sur 5000 mots ne dit rien de ce qu'il vaut sur 500.
- **Le nombre d'échantillons** : 5000 mots par échantillon, c'est aussi quatre fois moins d'exemples qu'avec 2000 mots (472 au lieu de 1199). Avec un plus petit corpus, cela deviendrait un problème.
- **Les options d'équilibrage** (`--class_weights`, `--balance`) servent quand un auteur a beaucoup plus d'échantillons que les autres. Ici, les classes sont à peu près équilibrées : l'effet est faible.
- **La PCA** résume les 1000 traits en quelques dimensions : on perd l'essentiel de l'information.

## Exercice

1. Lancer le benchmark et classer les résultats. Quelle est la meilleure configuration ? Est-ce celle que vous recommanderiez pour attribuer un poème anonyme ?
2. Ajouter une configuration au script : des **bigrammes de mots** (`-t words -n 2 -k 300`) en échantillons de 2000 mots. Il faut une ligne `extraire` et une ligne `entrainer`. Relancer : seule la nouvelle extraction est calculée.
3. *Pour aller plus loin* : faire tourner le script sur le corpus `corpus/romans_40s/txt` (25 romans de Daudet, Maupassant, Huysmans, Mirbeau et Zola). Il suffit de changer deux lignes en haut du script : `CORPUS` et `DOSSIER` (par exemple `benchmark_40s`, pour ne pas mélanger les résultats). Les conclusions sont-elles les mêmes ?

Le [corrigé](corrige.md) est à consulter après avoir essayé.
