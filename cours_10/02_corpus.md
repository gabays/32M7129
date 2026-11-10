# SuperStyl 2 : préparer le corpus

**Objectif** : transformer les romans en un tableau que la machine peut lire, avec `load_corpus.py`.

## 1. Le principe

Un ordinateur ne lit pas un roman : il compare des **nombres**. On va donc :

1. **découper** chaque roman en **échantillons** de même longueur (par exemple 2000 mots) : on aura ainsi beaucoup d'exemples par auteur, tous comparables ;
2. **compter**, dans chaque échantillon, la fréquence de certains **traits** : les mots les plus fréquents du corpus, ou des suites de trois caractères.

Les mots les plus fréquents sont surtout des mots grammaticaux (*de*, *la*, *et*, *il*...). On les emploie sans y penser, et chaque auteur a ses habitudes : c'est une **signature** difficile à imiter, indépendante du sujet du roman.

## 2. Le corpus

```bash
ls corpus/romans_20s/txt
ls corpus/romans_20s/txt | cut -d_ -f1 | sort | uniq -c
```

Chaque fichier s'appelle `Auteur_date_titre.txt`. SuperStyl prend **tout ce qui est avant le premier `_`** comme nom de la classe à reconnaître : ici l'auteur. La seconde commande compte les romans par auteur.

## 3. Extraire les traits

```bash
python SuperStyl/load_corpus.py -s corpus/romans_20s/txt/*.txt -t words -n 1 -k 100 --sampling --sample_size 2000 -o mots
```

| Option | Signification |
|---|---|
| `-s corpus/romans_20s/txt/*.txt` | les textes à lire |
| `-t words -n 1` | les traits sont des mots isolés (`-t chars -n 3` : des suites de trois caractères) |
| `-k 100` | on garde les 100 traits les plus fréquents du corpus |
| `--sampling --sample_size 2000` | on découpe en échantillons de 2000 mots |
| `-o mots` | nom des fichiers produits |

Comptez une vingtaine de secondes. Deux fichiers apparaissent :

- `mots.csv` : le tableau, une ligne par échantillon ;
- `mots_feats.json` : la liste des 100 mots retenus, avec leur fréquence dans le corpus.

## 4. Regarder le tableau

```bash
wc -l mots.csv
head -n 2 mots.csv | cut -d, -f1-8
cut -d, -f2 mots.csv | sort | uniq -c
```

- 1200 lignes : un en-tête et 1199 échantillons ;
- chaque ligne commence par le nom de l'échantillon (`roman.txt_0-2000` : les mots 0 à 2000 du roman), l'auteur, une colonne `lang` vide, puis les fréquences : *de* représente 4,6 % des mots du premier échantillon ;
- la dernière commande compte les échantillons par auteur : environ 300 chacun. Les classes sont **à peu près équilibrées**, même si les auteurs n'ont pas le même nombre de romans.

> Par défaut, SuperStyl met tout en minuscules, retire la ponctuation et **supprime les accents** (*été* devient *ete*) : regardez les premiers mots de `mots_feats.json` avec `head -n 40 mots_feats.json`.

## Exercice

1. Produire `mots.csv`.
2. Produire un second tableau avec les **trigrammes de caractères** : `-t chars -n 3 -k 1000`, toujours en échantillons de 2000 mots, nommé `chars3` (comptez environ trois minutes).
3. Combien de colonnes a `chars3.csv` ? (Indice : `head -n 1 chars3.csv | tr ',' '\n' | wc -l`.) Quels sont les dix premiers trigrammes de `chars3_feats.json` ?

Étape suivante : [03_entrainer.md](03_entrainer.md)
