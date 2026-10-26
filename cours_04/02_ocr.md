# Kraken 2 : OCRiser une page en ligne de commande

**Objectif** : transformer l'image d'une page en texte (puis en ALTO) avec une seule commande.

## 1. Le principe

```
image  →  segmentation  →  reconnaissance  →  texte / XML
          (où sont les      (que disent
           lignes ?)         les lignes ?)
```

- **segmentation** : un modèle est fourni avec Kraken ;
- **reconnaissance** : il faut **choisir un modèle** adapté à l'écriture ou à l'imprimé.

## 2. Récupérer un modèle de reconnaissance

Les modèles sont partagés en ligne (Zenodo, dépôt de modèles).

```bash
kraken list               # modèles disponibles
kraken get <identifiant>  # télécharger
```

Le modèle est téléchargé dans un dossier propre à l'outil (sur Mac : `~/Library/Application Support/htrmopo/<identifiant>/`) ; `kraken get` affiche ce chemin. Copiez le fichier modèle (`.safetensors` ou `.mlmodel`) dans `cours_04` pour l'appeler simplement par son nom.

Vous pouvez aussi consulter la liste officielle [sur Zenodo](https://zenodo.org/communities/ocr_models).

Pour l'exercice, nous utilisons un modèle d'imprimés anciens, [CATMuS Print (fondue, large)](https://zenodo.org/records/10592716), léger et rapide à entraîner. Téléchargez-le directement ([lien](https://zenodo.org/records/10592716/files/catmus-print-fondue-large.mlmodel?download=1)) ou avec `kraken get 10.5281/zenodo.10592716`, et placez `catmus-print-fondue-large.mlmodel` dans le dossier `cours_04`.

## 3. La commande d'OCR

```bash
kraken -i CHEMIN/VERS/IMAGE SORTIE.txt segment -bl ocr -m MODELE
```

Par exemple:

```bash
kraken -i data/f9.jpg page.txt segment -bl ocr -m catmus-print-fondue-large.mlmodel
```

| Morceau | Rôle |
|---|---|
| `-i data/f9.jpg page.txt` | fichier d'entrée, fichier de sortie |
| `segment -bl` | segmentation en lignes de base (*baselines*) |
| `ocr -m modele.safetensors` | reconnaissance avec ce modèle |

### L'ordre compte

```bash
kraken [options globales] sous-commande [options] sous-commande [options]
```

- ce qui est **avant** `segment` (fichiers, format de sortie, matériel) est global ;
- ce qui est **après** `segment` ou `ocr` ne concerne que cette étape.

## 4. Choisir le format de sortie

```bash
kraken -a -i data/f9.jpg page.xml segment -bl ocr -m catmus-print-fondue-large.mlmodel
```

| Option globale | Format |
|---|---|
| (aucune) | texte brut |
| `-a` | ALTO XML |
| `-x` | PageXML |
| `-h` | hOCR |

L'ALTO conserve la position de chaque ligne : c'est le format dont on a besoin pour **entraîner** (voir le cours suivant).

## 5. Plusieurs pages d'un coup

```bash
kraken -I "data/*.jpg" -o .txt segment -bl ocr -m catmus-print-fondue-large.mlmodel
```

`-I` désigne tous les fichiers correspondant au motif, `-o` l'extension des fichiers de sortie, qui remplace celle de l'image (`f9.jpg` donne `f9.txt`).

## 6. Aller plus vite

Option globale, à placer avant `segment` :

```bash
kraken --device mps    -i data/f9.jpg page.txt segment -bl ocr -m catmus-print-fondue-large.mlmodel   # Mac Apple Silicon (testé pour l'OCR seulement)
kraken --device cuda:0 -i data/f9.jpg page.txt segment -bl ocr -m catmus-print-fondue-large.mlmodel   # carte NVIDIA
```

Sans option, le calcul se fait sur le processeur (CPU) : plus lent, mais suffisant pour quelques pages.

## Exercice

> On prend `f9.jpg` comme page d'essai parce qu'au cours suivant elle fera partie des pages de validation : le modèle entraîné ne l'aura jamais vue.

1. Récupérer un modèle adapté à la page d'essai `data/f9.jpg`.
2. OCRiser la page en **texte**, puis en **ALTO**.
3. Relire le résultat et **noter trois erreurs typiques** : on les comparera avec le modèle entraîné au cours suivant.

Étape suivante : [03_entrainement.md](03_entrainement.md)
