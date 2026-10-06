# Kraken 3 : entraîner un modèle

**Objectif** : affiner un modèle existant sur nos propres pages, mesurer le résultat et le réutiliser.

## 1. Les données

Pour entraîner, il faut une **vérité terrain** : des pages transcrites à la main.

- une image par page ;
- un fichier **ALTO** (ou PageXML) qui contient les lignes **et** leur transcription.

Pour produire ces données : [eScriptorium](https://www.escriptorium.fr/), étroitement intégré à Kraken.

Dossier fourni pour l'exercice :

```
data/
  p001.jpg  p001.xml
  p002.jpg  p002.xml
  ...
```

## 2. Séparer entraînement et validation

Kraken lit des **manifestes** : de simples listes de fichiers.

```bash
ls data/*.xml | head -n 8 > train.lst
ls data/*.xml | tail -n 2 > val.lst
```

- `train.lst` : les pages sur lesquelles le modèle **apprend** ;
- `val.lst` : des pages **jamais vues**, pour juger s'il progresse réellement.

On n'évalue jamais sur ce qui a servi à apprendre.

## 3. Affiner un modèle existant (*fine-tuning*)

Avec peu de données, on part d'un modèle déjà entraîné :

```bash
ketos train --load medium.safetensors --resize union \
  -f xml -t train.lst -e val.lst \
  -o checkpoints -q fixed -N 10
```

| Option | Rôle |
|---|---|
| `--load` | point de départ : les poids du modèle existant |
| `--resize union` | ajoute au modèle les caractères nouveaux présents dans nos données |
| `-f xml` | données au format ALTO / PageXML |
| `-t` / `-e` | manifeste d'entraînement / de validation |
| `-o` | dossier où sont écrits les résultats |
| `-q fixed -N 10` | exactement 10 époques |

### Depuis zéro

Sans `--load`, le modèle part de rien : il faut **beaucoup** plus de données.

```bash
ketos train -f xml -t train.lst -e val.lst -o checkpoints
```

Par défaut, l'entraînement s'arrête tout seul quand la validation ne progresse plus (*early stopping*).

> Sur CPU, l'entraînement est lent : sur un petit corpus c'est faisable, mais on garde peu de pages et peu d'époques pour l'exercice.

## 4. Lire ce qui s'affiche

À chaque époque, Kraken évalue le modèle sur la validation. La **précision caractère** doit **monter**. À la fin, le meilleur modèle est converti en `.safetensors` dans `checkpoints/` :

```bash
ls checkpoints
```

Entraînement interrompu ? On reprend exactement où il s'était arrêté :

```bash
ketos train --resume checkpoints/<fichier>.ckpt
```

## 5. Mesurer : `ketos test`

```bash
ketos test -m checkpoints/<meilleur>.safetensors -f xml -e val.lst
```

Le rapport donne le taux d'erreur par caractère et par mot, ainsi que les **confusions** (quel caractère est pris pour quel autre).

## 6. Réutiliser le modèle

```bash
kraken -a -i page.jpg page_v2.xml segment -bl ocr -m checkpoints/<meilleur>.safetensors
```

On compare avec la sortie du cours précédent : les erreurs notées ont-elles disparu ?

## 7. Ranger l'expérience dans un fichier YAML

Pour ne pas retaper des commandes à rallonge, les options peuvent être placées dans un fichier `experiment.yml` :

```yaml
device: auto
train:
  training_data: [train.lst]
  evaluation_data: [val.lst]
  format_type: xml
  load: modele.safetensors
  resize: union
  checkpoint_path: checkpoints
  quit: fixed
  epochs: 10
```

```bash
ketos --config experiment.yml train
```

Les options globales (`device`…) sont au premier niveau, celles de `train` en dessous.

## 8. Les pièges classiques

| Symptôme | Cause probable |
|---|---|
| `command not found: kraken` | l'environnement n'est pas activé |
| erreur sur des caractères inconnus | `--resize union` oublié |
| entraînement très lent | pas de GPU : moins de pages ou moins d'époques |
| score de validation absurde | pages de validation présentes aussi dans `train.lst` |

## Exercice

1. Créer `train.lst` et `val.lst`.
2. Lancer le fine-tuning (10 époques).
3. Évaluer avec `ketos test`.
4. Refaire l'OCR de la page d'essai avec le nouveau modèle.
5. Comparer avec la sortie initiale : **qu'est-ce qui a changé ?**

## Pour aller plus loin

- `ketos compile` : transformer les données en un format binaire plus rapide à lire ;
- `--freeze-backbone` : limiter la dérive du modèle quand le corpus est très petit ;
- [documentation de Kraken](https://github.com/mittagessen/kraken/tree/main/docs/user_guide).
