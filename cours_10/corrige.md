# Séance 10 : corrigé des exercices

À consulter **après** avoir essayé. Les chiffres viennent d'un essai complet ; ils peuvent varier très légèrement d'une machine à l'autre.

## 01 : installation

```bash
cd 32M7129/cours_10
git clone https://github.com/SupervisedStylometry/SuperStyl.git
python3 -m venv env          # ou python3.12 si python3 est en 3.13
source env/bin/activate
pip install -r SuperStyl/requirements.txt
python SuperStyl/load_corpus.py --help
```

- Types de traits (`-t`) : `words`, `chars`, `affixes`, `pos`, `lemma`, `met_line`, `met_syll` (les quatre derniers seulement pour des fichiers TEI annotés).
- Validation croisée (`--cross_validate`) : `leave-one-out`, `k-fold`, `group-k-fold`.

## 02 : préparer le corpus

```bash
python SuperStyl/load_corpus.py -s corpus/romans_20s/txt/*.txt -t words -n 1 -k 100 --sampling --sample_size 2000 -o mots
python SuperStyl/load_corpus.py -s corpus/romans_20s/txt/*.txt -t chars -n 3 -k 1000 --sampling --sample_size 2000 -o chars3
head -n 1 chars3.csv | tr ',' '\n' | wc -l
head -n 40 chars3_feats.json
```

`chars3.csv` a **1003 colonnes** : le nom de l'échantillon, `author`, `lang`, et les 1000 trigrammes. Les dix premiers : `es_`, `_de`, `le_`, `_le`, `nt_`, `it_`, `de_`, `_et`, `ent`, `re_`. Le `_` représente une espace : `es_` est une fin de mot (*les*, *des*, *ces*...), `_de` un début de mot.

## 03 : entraîner et évaluer

```bash
python SuperStyl/train_svm.py mots.csv --cross_validate group-k-fold -o mots
python SuperStyl/train_svm.py chars3.csv --cross_validate group-k-fold -o chars3
```

1. Les trigrammes de caractères font un peu mieux : **95 %** contre **93 %** pour les 100 mots les plus fréquents.
2. Avec les mots, les confusions les plus fréquentes sont entre **Aimard et Chevalier**, dans les deux sens (16 échantillons chacun). Les deux écrivent des romans d'aventures situés en Amérique du Nord (trappeurs, « Peaux-Rouges ») : même genre, mêmes sujets, mêmes scènes. Chevalier est aussi l'auteur vers lequel les autres sont le plus souvent attirés.
3. Le roman le plus mal attribué est *Les Aventures du capitaine La Palisse* de Ponson du Terrail (14 erreurs avec les mots, 10 avec les trigrammes). Or Ponson du Terrail est mort en 1871, et le fichier est daté de 1880 : publication posthume, texte achevé ou remanié par une autre main ? Le modèle ne prouve rien, mais il pose une question au philologue. Viennent ensuite *La première Éducation sentimentale* de Flaubert (1845), œuvre de jeunesse au style moins fixé.

## 04 : comparer des configurations

```bash
bash benchmark.sh
tail -n +2 benchmark/resultats.tsv | sort -t$'\t' -k3 -rn | column -t -s $'\t'
```

| Données | Options | Exactitude | F1 macro |
|---|---|---|---|
| chars3_5000 | | 0.99 | 0.99 |
| chars3_2000 | `--balance downsampling` | 0.96 | 0.96 |
| chars3_2000 | `--class_weights` | 0.95 | 0.95 |
| chars3_2000 | | 0.95 | 0.95 |
| affixes_2000 | | 0.95 | 0.95 |
| chars3_2000 | `--kernel rbf` | 0.94 | 0.94 |
| mots300_2000 | | 0.93 | 0.93 |
| mots100_2000 | | 0.93 | 0.93 |
| chars3_1000 | | 0.92 | 0.92 |
| chars3_500 | | 0.87 | 0.86 |
| chars3_2000 | `--dim_reduc pca` | 0.61 | 0.60 |

1. **Ce qui compte le plus est la taille des échantillons** : de 87 % (500 mots) à 99 % (5000 mots). Les trigrammes de caractères et les affixes font un peu mieux que les mots. Les options d'équilibrage changent peu (les classes sont équilibrées) ; la PCA est à éviter. La « meilleure » configuration (5000 mots) ne convient pas à un poème anonyme : il faut évaluer le modèle sur des échantillons **de la taille du texte à attribuer**, et accepter un score plus bas.
2. Lignes à ajouter (dans les parties 1 du script) :

```bash
extraire bigrammes_2000 -t words -n 2 -k 300 --sampling --sample_size 2000
entrainer bigrammes_2000
```

Résultat : **0.90**, moins bien que les mots isolés. Les bigrammes de mots sont plus rares : leurs fréquences, sur 2000 mots, sont plus instables.

3. Pour `romans_40s`, modifier en haut du script :

```bash
CORPUS="corpus/romans_40s/txt/*.txt"
DOSSIER="benchmark_40s"
```
