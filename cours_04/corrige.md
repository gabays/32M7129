# Séance 04 : corrigé des exercices

À consulter **après** avoir essayé. Les chiffres peuvent varier légèrement d'une machine à l'autre.

## 02 : OCR

```bash
kraken -i data/f9.jpg page.txt segment -bl ocr -m catmus-print-fondue-large.mlmodel
kraken -a -i data/f9.jpg page.xml segment -bl ocr -m catmus-print-fondue-large.mlmodel
head -n 5 page.txt
```

Début attendu de `page.txt` : « LE TOMBEAV DES DELICES des Celestins… » (le titre de la page). Erreurs typiques à repérer : le « ſ » (s long) lu « s », des apostrophes, des espaces en trop ou manquantes.

## 03 : entraînement

```bash
ls data/*.xml | head -n 16 > train.lst
ls data/*.xml | tail -n 4 > val.lst
wc -l train.lst val.lst        # 16 et 4
ketos -d cpu train --load catmus-print-fondue-large.mlmodel --resize union \
  -f xml -t train.lst -e val.lst -o checkpoints -q fixed -N 5 -B 2 -u NFD
ketos -d cpu test -m checkpoints/best_<score>.safetensors -f xml -e val.lst -u NFD
```

| | Précision caractère | Erreurs (sur 2762 caractères) |
|---|---|---|
| modèle de départ | environ 93,8 % | environ 171, dont environ 81 « ſ » lus « s » |
| après 5 époques | environ 98,6 % | environ 35 à 40, presque plus de « ſ » |

**Ce qui a changé** : le modèle a appris l'usage du « ſ » et des apostrophes propres à ces imprimés. Les erreurs restantes sont surtout des espaces.

**Pièges** : lancer les commandes hors de `cours_04` (listes vides), oublier `-B 2` (mémoire saturée), utiliser `-d mps` (blocage).
