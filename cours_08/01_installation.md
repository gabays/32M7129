# Flair 1 : installation

**Objectif** : avoir un environnement Python dans lequel Flair est installé, et le modèle rangé au bon endroit.

On procède exactement comme au cours 04 pour Kraken.

## 1. Créer et activer l'environnement

```bash
cd 32M7129/cours_08
python3 -m venv env
source env/bin/activate
```

Le prompt affiche `(env)`. Rappel : à chaque nouvelle fenêtre de terminal, il faut refaire `source env/bin/activate` depuis `cours_08`.

## 2. Installer Flair

[Flair](https://github.com/flairNLP/flair) est une bibliothèque Python pour l'annotation automatique de textes (parties du discours, entités nommées...).

```bash
pip install --upgrade pip
pip install flair==0.15.1
```

On précise la version (`==0.15.1`) parce que le modèle a été entraîné avec elle : une autre version pourrait ne pas savoir le relire. L'installation prend quelques minutes (elle télécharge PyTorch, comme pour Kraken).

Vérification :

```bash
python -c "import flair; print(flair.__version__)"
```

Réponse attendue : `0.15.1`.

> Flair n'a pas de commande à lui comme `kraken` : on l'utilise depuis un script Python. C'est le rôle de `annoter.py`, fourni dans le dossier.

```bash
python annoter.py --help
```

## 3. Récupérer le modèle

Le modèle pèse **2,3 Go**. Il n'est pas dans le dépôt Git : GitHub refuse les fichiers de plus de 100 Mo (voir le cours 06). Il est joint à la [release 0.1](https://github.com/gabays/32M7129/releases/tag/0.1) du dépôt, **coupé en deux morceaux**, car une release n'accepte pas de fichier de plus de 2 Go.

On télécharge les deux morceaux avec `curl`, depuis `cours_08` :

```bash
mkdir -p model
cd model
curl -L -O https://github.com/gabays/32M7129/releases/download/0.1/model-v6.pt.part_aa
curl -L -O https://github.com/gabays/32M7129/releases/download/0.1/model-v6.pt.part_ab
```

- `-L` : suivre les redirections (GitHub renvoie vers un serveur de téléchargement) ;
- `-O` : garder le nom du fichier d'origine.

(Vous pouvez aussi cliquer sur les deux fichiers dans la page de la release, puis les déplacer dans `model/`.)

On recolle ensuite les morceaux avec `cat`, qui les écrit l'un après l'autre dans un seul fichier, puis on supprime les morceaux :

```bash
cat model-v6.pt.part_aa model-v6.pt.part_ab > model-v6.pt
rm model-v6.pt.part_aa model-v6.pt.part_ab
ls -lh
cd ..
```

`ls -lh` doit afficher un seul fichier, `model-v6.pt`, d'environ 2,2 G.

## 4. Ce que contient le modèle

Le modèle repose sur un **transformer** (XLM-RoBERTa *large*), un modèle de langue pré-entraîné sur une centaine de langues, puis spécialisé sur du français ancien. Au-dessus de ce tronc commun, cinq petites « têtes » font chacune une tâche :

| Tâche | Ce qu'elle annote | Exemple |
|---|---|---|
| `pos` | la partie du discours de chaque mot | *Roy* → `Nc` (nom commun) |
| `coarse` | les entités, en grandes catégories | *Monſeigneur le duc de Guiſe* → `pers` |
| `fine` | les mêmes entités, en catégories fines | → `pers.ind` (une personne individuelle) |
| `finecomp` | les composants d'une entité | *Cardinal de Guiſe* : *Guiſe* → `comp.name` |
| `nest` | les entités emboîtées dans une autre | *Orleãs* dans *le ſiege d’Orleãs* → `loc.adm.town` |

Les cinq têtes partagent le même transformer : le texte n'est analysé qu'une fois, puis chaque tête lit cette analyse.

## Exercice

1. Créer l'environnement et installer Flair 0.15.1.
2. Télécharger les deux morceaux du modèle, les recoller dans `model/model-v6.pt` et vérifier sa taille.
3. Afficher l'aide du script avec `python annoter.py --help` : quelles options peut-on lui donner ?

Étape suivante : [02_annoter.md](02_annoter.md)
