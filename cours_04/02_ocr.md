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

Le modèle est installé dans `~/.local/share/kraken` : on peut ensuite l'appeler par son nom de fichier (`.safetensors`).

Vous pouvez aussi consulter la liste officielle [sur Zenodo](https://zenodo.org/communities/ocr_models).

## 3. La commande d'OCR

```bash
kraken -i data/f104.jpg page.txt segment -bl ocr -m medium.safetensors
```

| Morceau | Rôle |
|---|---|
| `-i page.jpg page.txt` | fichier d'entrée, fichier de sortie |
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
kraken -a -i data/f104.jpg page.xml segment -bl ocr -m medium.safetensors
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
kraken -I "data/*.jpg" -o .txt segment -bl ocr -m modele.safetensors
```

`-I` désigne tous les fichiers correspondant au motif, `-o` le suffixe ajouté au nom de sortie (`page1.jpg.txt`).

## 6. Aller plus vite

Option globale, à placer avant `segment` :

```bash
kraken --device mps    -i page.jpg page.txt segment -bl ocr -m modele.safetensors   # Mac Apple Silicon
kraken --device cuda:0 -i page.jpg page.txt segment -bl ocr -m modele.safetensors   # carte NVIDIA
```

Sans option, le calcul se fait sur le processeur (CPU) : plus lent, mais suffisant pour quelques pages.

## Exercice

1. Récupérer un modèle adapté à la page d'essai fournie.
2. OCRiser la page en **texte**, puis en **ALTO**.
3. Relire le résultat et **noter trois erreurs typiques** : on les comparera avec le modèle entraîné au cours suivant.

Étape suivante : [03_entrainement.md](03_entrainement.md)
