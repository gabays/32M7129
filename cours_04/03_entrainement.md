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
  f9.jpg    f9.xml
  f11.jpg   f11.xml
  ...       (20 pages en tout)
```

## 2. Séparer entraînement et validation

> Toutes les commandes de cette séance se lancent depuis le dossier `cours_04`, avec l'environnement `env` activé.

Kraken lit des **manifestes** : de simples listes de fichiers.

```bash
ls data/*.xml | head -n 16 > train.lst
ls data/*.xml | tail -n 4 > val.lst
```

Les 20 pages sont réparties en 16 pour l'entraînement et 4 pour la validation. `ls` trie les noms par ordre alphabétique : `f9.xml` arrive en dernier (après `f88.xml`) et se retrouve donc dans la validation.

- `train.lst` : les pages sur lesquelles le modèle **apprend** ;
- `val.lst` : des pages **jamais vues**, pour juger s'il progresse réellement.

On n'évalue jamais sur ce qui a servi à apprendre.

## 3. Affiner un modèle existant (*fine-tuning*)

Avec peu de données, on part d'un modèle déjà entraîné :

```bash
ketos -d cpu train --load catmus-print-fondue-large.mlmodel --resize union \
  -f xml -t train.lst -e val.lst \
  -o checkpoints -q fixed -N 5 -B 2 -u NFD
```

| Option | Rôle |
|---|---|
| `--load` | point de départ : les poids du modèle existant |
| `--resize union` | ajoute au modèle les caractères nouveaux présents dans nos données |
| `-f xml` | données au format ALTO / PageXML |
| `-t` / `-e` | manifeste d'entraînement / de validation |
| `-o` | dossier où sont écrits les résultats |
| `-d cpu` | calcul sur le processeur (option globale, avant `train`) |
| `-q fixed -N 5` | exactement 5 époques |
| `-B 2` | 2 lignes par lot : évite de saturer la mémoire |
| `-u NFD` | normalise l'Unicode des transcriptions (voir partie 5) |

### Depuis zéro

Sans `--load`, le modèle part de rien : il faut **beaucoup** plus de données.

```bash
ketos train -f xml -t train.lst -e val.lst -o checkpoints
```

Par défaut, l'entraînement s'arrête tout seul quand la validation ne progresse plus (*early stopping*).

> Ce petit modèle (5,7 M de paramètres) s'entraîne sur un simple processeur : environ 45 secondes par époque sur un Mac récent. `-B 2` est important : sans lui, Kraken prend un lot par défaut très gros qui sature la mémoire.

> ⚠️ N'utilisez pas `-d mps` (puce graphique du Mac) avec ce modèle : l'entraînement et `ketos test` peuvent se figer. Sur une machine NVIDIA, `-d cuda:0` accélère. Les avertissements `alphabet mismatch` et `mode L / mode 1` au démarrage sont normaux.

> ⚠️ L'entraînement écrit beaucoup sur le disque (quelques dizaines de Mo par checkpoint) : prévoyez plusieurs Go libres.

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
ketos -d cpu test -m checkpoints/<meilleur>.safetensors -f xml -e val.lst -u NFD
```

Le rapport donne le taux d'erreur par caractère et par mot, ainsi que les **confusions** (quel caractère est pris pour quel autre).

L'option `-u NFD` est importante : un « é » peut être écrit comme un seul caractère, ou comme un « e » suivi d'un accent. Sans normalisation, ces deux écritures comptent comme des erreurs alors qu'elles s'affichent pareil. Pour comparer avant et après l'entraînement, testez aussi le modèle de départ avec la même option :

```bash
ketos -d cpu test -m catmus-print-fondue-large.mlmodel -f xml -e val.lst -u NFD
```

Résultat attendu sur nos 4 pages de validation (2762 caractères) : le modèle de départ atteint environ **93,8 %** de précision caractère, avec surtout des confusions « ſ » (s long) lu « s » (81 erreurs) et des apostrophes. Après 5 époques : environ **98,6 %** (le chiffre varie légèrement d'un entraînement à l'autre), et les erreurs sur le « ſ » ont presque disparu.

## 6. Réutiliser le modèle

```bash
kraken -a -i data/f9.jpg page_v2.xml segment -bl ocr -m checkpoints/<meilleur>.safetensors
```

On compare avec la sortie du cours précédent : les erreurs notées ont-elles disparu ?

## 7. Ranger l'expérience dans un fichier YAML

Pour ne pas retaper des commandes à rallonge, les options peuvent être placées dans un fichier `experiment.yml` :

```yaml
device: cpu
train:
  training_data: [train.lst]
  evaluation_data: [val.lst]
  format_type: xml
  load: catmus-print-fondue-large.mlmodel
  resize: union
  checkpoint_path: checkpoints
  quit: fixed
  epochs: 5
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
| entraînement très lent ou mémoire saturée | `-B 2` oublié, ou pas de GPU : moins de pages ou moins d'époques |
| score de validation absurde | pages de validation présentes aussi dans `train.lst` |
| entraînement ou test figé sur Mac | éviter `-d mps` : utiliser `-d cpu` |
| `No space left on device` | disque plein : libérer de l'espace avant d'entraîner |
| confusions entre « é » et « é » | normalisation Unicode différente : ajouter `-u NFD` |

## Exercice

1. Créer `train.lst` et `val.lst`.
2. Lancer le fine-tuning (5 époques).
3. Évaluer avec `ketos test`.
4. Refaire l'OCR de la page d'essai avec le nouveau modèle.
5. Comparer avec la sortie initiale : **qu'est-ce qui a changé ?**

## Pour aller plus loin

- `ketos compile` : transformer les données en un format binaire plus rapide à lire ;
- `--freeze-backbone` : limiter la dérive du modèle quand le corpus est très petit ;
- [documentation de Kraken](https://github.com/mittagessen/kraken/tree/main/docs/user_guide).
