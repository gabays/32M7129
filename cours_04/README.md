# OCRiser et entraîner un modèle avec Kraken

Une séance pratique pour passer de l'image d'une page à un texte, puis à **votre propre modèle de reconnaissance**, entièrement depuis le terminal. Le fil rouge : **on tape tout, on comprend chaque commande**.

Vous allez installer Kraken dans un environnement Python isolé, OCRiser une page avec une seule commande, puis affiner un modèle sur des pages transcrites et mesurer ce que l'entraînement a changé.

## Objectifs

À la fin de la séance, vous saurez :

- créer et activer un **environnement virtuel** Python ;
- installer un logiciel avec **pip** ;
- OCRiser une page en ligne de commande avec `kraken`, en texte ou en ALTO ;
- préparer des données d'entraînement (manifestes train / validation) ;
- lancer un entraînement avec `ketos train` et lire ce qu'il affiche ;
- évaluer un modèle avec `ketos test` et le comparer à l'original.

## Prérequis

- Avoir suivi l'introduction à la ligne de commande (se déplacer dans les dossiers, lancer une commande).
- Un terminal de type bash : **Linux**, **macOS** ou **Windows avec WSL** (déjà installé : on ne le refait pas ici).
- Une connexion à Internet (l'installation de Kraken télécharge plusieurs centaines de Mo).

## Déroulé

| Durée | Partie | Contenu |
|---|---|---|
| 0-25 min | [01 - Installation](01_installation.md) | Python, environnement virtuel, `pip`, installation de Kraken |
| 25-50 min | [02 - OCRiser une page](02_ocr.md) | Segmentation et reconnaissance, `kraken`, formats de sortie |
| 50-90 min | [03 - Entraîner un modèle](03_entrainement.md) | Manifestes, `ketos train`, `ketos test`, réutilisation du modèle |

Chaque partie se termine par un **exercice**. Celui de la partie 02 sert de point de comparaison pour celui de la partie 03 : gardez la sortie de l'OCR initial.

## Contenu du dépôt

```text
.
├── README.md
├── 01_installation.md
├── 02_ocr.md
├── 03_entrainement.md
├── page.jpg              # page d'essai pour l'OCR
└── data/                 # pages transcrites pour l'entraînement
    ├── p001.jpg
    ├── p001.xml
    └── ...
```

## Conventions

Dans les exemples, les blocs de code contiennent ce que vous devez taper dans le terminal :

```bash
kraken --version
```

Les éléments entre chevrons (`<identifiant>`, `<meilleur>.safetensors`) sont à remplacer par votre propre valeur.

Les commandes sont identiques sous Linux, macOS et WSL. Les rares différences (accélération du calcul sur Mac ou carte NVIDIA) sont signalées dans le texte.

## Pour aller plus loin

La [documentation de Kraken](https://github.com/mittagessen/kraken/tree/main/docs/user_guide) détaille toutes les options d'inférence et d'entraînement. Pour produire vos propres données transcrites, voyez [eScriptorium](https://www.escriptorium.fr/).
