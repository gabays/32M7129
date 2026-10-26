# Séance 05 : corrigé des exercices

À consulter **après** avoir essayé.

## 02 : données

- le document compte **24 pages** (24 fichiers `p_*.xml`, et `METS.xml` n'est pas copié dans `alto/`) ;
- les colonnes de `metadata.csv` sont : `file_name, number, title, date, author, publisher`. Pour le document de l'exercice, toutes sont remplies (titre « Le faux visage descouvert du fin renard de la France », 1589, auteur « Anon », éditeur ÖNB).

## 03 : conversion

```bash
python -m ladas2tei.main corpus -o TEI --metadata-csv metadata.csv
grep -n "Le faux visage" TEI/faux_visage_ONB_10790D2D.xml | head -n 2
grep -oE "<[a-zA-Z]+" TEI/faux_visage_ONB_10790D2D.xml | sort | uniq -c | sort -rn | head
```

Décompte attendu (environ) : `lb` 761 (lignes), `pb` 24 (pages), `milestone` 23, `lg` 15, `p` 12, `fw` 10, `div` 9, `head` 8, `ab` 7. L'élément le plus fréquent est **`<lb>`**, un par ligne du texte.

Bonus, `convertir.sh` :

```bash
#!/bin/bash
source venv/bin/activate
python -m ladas2tei.main corpus -o TEI --metadata-csv metadata.csv
grep -oE "<[a-zA-Z]+" TEI/*.xml | sort | uniq -c | sort -rn | head
```

## 04 : carnet

Cellule à ajouter à la fin :

```python
from pathlib import Path
print(Path("TEI/faux_visage_ONB_10790D2D.xml").stat().st_size, "octets")
```

Taille attendue : environ 45 Ko.
