# SuperStyl 3 : entraîner et évaluer

**Objectif** : entraîner un modèle sur `mots.csv`, mesurer s'il reconnaît les auteurs, et comprendre ses erreurs.

## 1. Le principe de l'évaluation

On ne peut pas juger un modèle sur les textes qui ont servi à l'entraîner : ce serait comme évaluer un étudiant sur les questions dont il a déjà le corrigé. On pratique donc la **validation croisée** :

1. on met de côté une partie des échantillons ;
2. on entraîne le modèle sur le reste ;
3. on lui demande d'attribuer les échantillons mis de côté, et on compte ses réussites ;
4. on recommence jusqu'à ce que chaque échantillon ait été mis de côté une fois.

Avec `group-k-fold`, on met de côté **un roman entier à la fois** : le modèle doit reconnaître l'auteur d'un roman qu'il n'a jamais vu. C'est la situation réelle d'une attribution.

> Pourquoi pas des échantillons pris au hasard ? Parce que des passages d'un même roman se retrouveraient à la fois dans l'entraînement et dans le test : le modèle reconnaîtrait le roman (ses personnages, ses lieux) plutôt que l'auteur, et le score serait trop beau. Le notebook le montre : 97 % au lieu de 92 %.

## 2. Entraîner

```bash
python SuperStyl/train_svm.py mots.csv --cross_validate group-k-fold -o mots
```

Le modèle est un **SVM** (machine à vecteurs de support) : il cherche les frontières qui séparent le mieux les quatre auteurs dans l'espace des fréquences. Le calcul prend quelques secondes.

## 3. Lire le rapport

```text
                          precision    recall  f1-score   support

          Aimard-Gustave       0.93      0.93      0.93       322
       Chevalier-H-Emile       0.86      0.89      0.88       275
        Flaubert-Gustave       0.97      0.95      0.96       313
Ponson-du-Terrail-Pierre       0.95      0.93      0.94       289

                accuracy                           0.93      1199
```

| Mesure | Question | Exemple |
|---|---|---|
| `precision` | Quand le modèle dit « Chevalier », a-t-il raison ? | 86 % des fois |
| `recall` | Parmi les vrais échantillons de Chevalier, combien sont retrouvés ? | 89 % |
| `f1-score` | La moyenne des deux | 0.88 |
| `support` | Le nombre d'échantillons de l'auteur | 275 |
| `accuracy` | La proportion totale de bonnes réponses | 93 % |

## 4. La matrice de confusion et les erreurs

Le script a écrit deux fichiers :

```bash
cat mots_confusion_matrix.csv
```

En ligne l'auteur réel (`true:`), en colonne l'auteur prédit (`pred:`). La diagonale contient les bonnes réponses ; le reste, les confusions.

```bash
head mots_misattributions.csv
```

Une ligne par échantillon mal attribué : son nom, l'auteur réel (`True`), l'auteur prédit (`Pred`). On les regroupe avec les commandes du cours 02 :

```bash
cut -d, -f2,3 mots_misattributions.csv | sort | uniq -c | sort -rn
cut -d, -f1 mots_misattributions.csv | sed 's/.txt_.*//' | sort | uniq -c | sort -rn | head -n 5
```

- La première commande compte les confusions par couple d'auteurs (réel, prédit).
- La seconde compte les erreurs par roman : `sed 's/.txt_.*//'` efface tout ce qui suit le nom du fichier.

## 5. Quels mots distinguent les auteurs ?

```bash
python SuperStyl/train_svm.py mots.csv --cross_validate group-k-fold --get_coefs -o mots
open coefs_Ponson-du-Terrail-Pierre.png
```

(`open` sous macOS ; sous Linux/WSL, ouvrez l'image depuis l'explorateur de fichiers.) Une image par auteur : en bleu, les mots dont la fréquence élevée **pousse vers** cet auteur ; en rouge, ceux qui **éloignent** de lui. Pour Ponson du Terrail, *et*, *le*, *dit*, *etait*, *avait* : une narration au passé, rythmée par les dialogues (*dit*) et les coordinations.

## Exercice

1. Entraîner le modèle sur `mots.csv` et sur `chars3.csv`. Lequel est le meilleur ?
2. Quel couple d'auteurs est le plus souvent confondu ? Ces auteurs ont-ils quelque chose en commun (genre, sujets) ?
3. Quel roman produit le plus d'erreurs ? Regardez son titre et sa date : avez-vous une hypothèse ?

Étape suivante : [04_comparer.md](04_comparer.md)
