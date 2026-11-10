# Flair 2 : annoter un texte

**Objectif** : faire annoter *Faux visage* par le modèle et comprendre les deux fichiers produits.

Toutes les commandes se lancent depuis `cours_08`, environnement activé.

## 1. Regarder le texte

Le fichier `data/faux_visage.txt` contient le texte du TEI produit au cours 05, sans les balises : un paragraphe ou un vers par ligne.

```bash
head -n 5 data/faux_visage.txt
wc -l -w data/faux_visage.txt
```

On obtient 133 lignes et environ 5 900 mots. On reconnaît l'orthographe de l'imprimé : *ſ* (s long), *v* pour *u* (*IVDAS*), tildes d'abréviation (*commũ*).

## 2. Nettoyer avant d'annoter

La transcription garde le signe `¬` pour les mots coupés en fin de ligne : *Ca¬ tholique*. Pour le modèle, ce sont deux mots qui n'existent pas. On les recolle avec `sed` :

```bash
grep -o '¬' data/faux_visage.txt | wc -l
sed 's/¬ //g' data/faux_visage.txt > faux_visage_propre.txt
grep -o '¬' faux_visage_propre.txt | wc -l
```

- `grep -o '¬'` affiche chaque `¬` trouvé, `wc -l` les compte : 195 avant, 1 après.
- `sed 's/¬ //g'` remplace (`s`) chaque « ¬ suivi d'une espace » par rien, partout dans la ligne (`g`).
- `>` écrit le résultat dans un nouveau fichier : l'original n'est pas modifié.

> Il reste un `¬`. Retrouvez-le avec `grep -n '¬' faux_visage_propre.txt` : pourquoi la commande `sed` ne l'a-t-elle pas supprimé ?

## 3. Lancer l'annotation

```bash
python annoter.py faux_visage_propre.txt
```

Le script :

1. charge le modèle (quelques secondes à une minute) ;
2. découpe le texte en phrases, puis en mots ;
3. fait passer les phrases dans le modèle : une barre de progression s'affiche, comptez **2 à 5 minutes** selon l'ordinateur ;
4. écrit les résultats dans un dossier `resultats/`.

Fin attendue de l'affichage :

```text
Annotation terminée en 127 secondes.
125 entités (niveau coarse) trouvées.
Résultats : resultats/faux_visage_propre.pos.tsv et resultats/faux_visage_propre.entites.tsv
```

> Si l'ordinateur ralentit fortement ou si le script s'arrête avec `Killed`, la mémoire vive est insuffisante : fermez les autres applications (navigateur notamment) et relancez.

## 4. Lire les parties du discours

```bash
head -n 15 resultats/faux_visage_propre.pos.tsv
```

C'est un fichier **TSV** : un tableau dont les colonnes sont séparées par des tabulations. Il s'ouvre aussi dans un tableur (LibreOffice, Excel). Pour l'afficher en colonnes alignées dans le terminal :

```bash
column -t -s $'\t' resultats/faux_visage_propre.pos.tsv | less
```

(`q` pour sortir de `less`.) Trois colonnes : le numéro de la phrase, le mot, et son étiquette. Les étiquettes les plus fréquentes :

| Étiquette | Catégorie | Exemples dans le texte |
|---|---|---|
| `Nc` | nom commun | *religion*, *ſang*, *Egliſe* |
| `Np` | nom propre | *Dieu*, *France*, *Henry* |
| `Vvc` | verbe conjugué | *peut*, *faict*, *veut* |
| `Vvn` | verbe à l'infinitif | *faire*, *porter* |
| `Vuc` | auxiliaire conjugué | *a*, *eſt*, *ſont* |
| `Ge` | participe passé | *eſté*, *veu*, *ruiné* |
| `Ag` | adjectif | *grand*, *ſaincte*, *bon* |
| `Da` | article défini | *la*, *le*, *les*, *l’* |
| `Ds` | déterminant possessif | *ſa*, *ſon*, *noſtre* |
| `Pp` | pronom personnel | *vous*, *il*, *nous* |
| `Pr` | pronom relatif | *qui*, *où*, *laquelle* |
| `S` | préposition | *de*, *à*, *en*, *pour* |
| `S+Da` | préposition + article contractés | *du*, *des*, *au* |
| `Cc` / `Cs` | conjonction de coordination / de subordination | *&*, *mais* / *que*, *comme* |
| `Rg` | adverbe | *ſi*, *plus*, *tant* |
| `Xe` | mot étranger | *in*, *ſæculi* (latin) |
| `Fs` / `Fw` | ponctuation forte / faible | *.* *?* / *,* *:* |

Le modèle s'est entraîné sur des textes annotés à la main : il reproduit leurs choix, avec leurs étiquettes, qui ne sont pas celles de la grammaire scolaire.

## 5. Lire les entités nommées

```bash
column -t -s $'\t' resultats/faux_visage_propre.entites.tsv | head -n 20
```

Une ligne par entité, avec cinq colonnes : la phrase, le **niveau** d'annotation, le texte de l'entité, son type, et le **score** (la confiance du modèle, de 0 à 1).

Le même passage peut être annoté à plusieurs niveaux. Pour *le ſiege d’Orleãs* (phrase 42) :

| Niveau | Entité | Type |
|---|---|---|
| `coarse` | ſiege d’Orleãs | `event` (événement) |
| `fine` | ſiege d’Orleãs | `event` |
| `finecomp` | Orleãs | `comp.name` (le nom, composant de l'entité) |
| `nest` | Orleãs | `loc.adm.town` (une ville, emboîtée dans l'événement) |

Les niveaux ne sont pas toujours d'accord entre eux : pour *Monſeigneur le duc de Guiſe* (phrase 33), `coarse` prend tout le groupe, `fine` seulement *duc de Guiſe*, avec un score plus bas (0.84).

Les grandes catégories (`coarse`) : `pers` (personne), `loc` (lieu), `time` (date), `func` (fonction : *Cardinal de Guiſe*), `org` (organisation), `prod` (production humaine), `event` (événement), `amount` (quantité).

## 6. Annoter sa propre phrase

```bash
echo "Le Roy partit de Paris le 3 iuin 1650 auec Monſieur le Cardinal Mazarin." > essai.txt
python annoter.py essai.txt
cat resultats/essai.entites.tsv
```

Chaque nouvel essai recharge le modèle : c'est plus long que l'annotation elle-même.

## Exercice

1. Nettoyer le texte et l'annoter.
2. Dans `faux_visage_propre.pos.tsv`, choisir une phrase et vérifier l'étiquette de chaque mot : noter **deux erreurs**.
3. Dans `faux_visage_propre.entites.tsv`, relever **une entité oubliée** ou **mal découpée**.
4. Trouver les entités dont le modèle est le moins sûr, en triant sur la 5e colonne :

```bash
sort -t$'\t' -k5,5n resultats/faux_visage_propre.entites.tsv | head
```

Étape suivante : [03_exploiter.md](03_exploiter.md)
