# Markdown syntax guide

## Titre

# Titre de niveau h1
## Titre de niveau h2
…
###### Titre de niveau h6

## Gras et italique

*Ce texte sera en italiques*  
_Ce texte sera en italiques_

**Ce texte sera en gras**  
__Ce texte sera en gras__

_On **peut** combiner le gras et l'italique_

## Listes

### numérotée

1. Item 1
1. Item 2
1. Item 3

### non numérotée

* Item 1
* Item 2
* Item 3
  * Item 3a
  * Item 3b

### Liste dans liste
* Item 1
* Item 2
* Item 3
  * Item 3a
  * Item 3b


## Images

![Texte alternatif si l'image ne s'affiche pas](../../images/markdown-flowchart.png "Légende.")

## Liens

Une url sera immédiatement affichée comme un lien: https://github.com/gabays/32M7128

On peut mettre [le lien](https://github.com/gabays/32M7128) vers le cours.

## Citations

> Les humanités numériques (traduction française de _digital humanities_), sont composées de différents champs d'études qui sont les suivants : 
>
>> recherche, enseignement et ingénierie au croisement de l'informatique et des arts, lettres, sciences humaines et sciences sociales.

## Tableaux

| colonne 1     | Colonne 2     |
| ------------- |---------------| 
| left foo      | right foo     |
| left bar      | right bar     |
| left baz      | right baz     |



Il est possible de centrer une colonne avec `:---:`

| colonne 1     | Colonne 2     |
| ------------- |:-------------:| 
| left foo      | right foo     |
| left bar      | right bar     |
| left baz      | right baz     |

## Code

### Bloc de code

Je peux formater le code pour qu'il apparaisse comme tel:

```
print('Hello world');
```

Je peux préciser le langage et utiliser des jeux de couleurs (ici python):

```python
print('Hello world');
```

Les couleurs s'adaptent au langage (ici R):

```r
x <- c(1,2,3,4,5,6)
x
```

La liste des langages supportés est [disponible sur internet](https://github.com/jincheng9/markdown_supported_languages).


### Inline code

Ce document est écrit en `markdown`.

## Commentaires

Si je mets un commentaire il n'est pas compilé: 

[comment]: <> (Je peux rajouter des commentaires)

Si je veux qu'il apparaisse, je peux le mettre dans un bloc de code:
```
[comment]: <> (Je peux rajouter des commentaires)
```

## HTML

Il est possible d'utiliser le HTML directement pour toutes les choses plus compliquées comme <span style="color:red">mettre du texte en rouge</span> ou mettre une image avec sa légende:

<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Licence Creative Commons" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution 4.0 International Licence</a>.
