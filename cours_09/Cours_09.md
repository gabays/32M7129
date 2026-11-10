---
marp: true
theme: default
paginate: true
---

<style>
img[alt~="center"] {
  display: block;
  margin: 0 auto;
}
h1 {
  font-size: 46px;
  color: darkred;
}
h2 {
  font-size: 38px;
  color: darkred;
}
</style>

Comment mieux faire?

# Langages du web: HTML et CSS

Simon Gabay

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Licence Creative Commons" style="border-width:0;float:right;\" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a>

---
## HTML
---

### HTML

HTML, pour _Hypertext Markup Language_, est un langage de balisage inventé en 1997 conçu pour représenter les pages web.

Plus d'informations sur [Wikipedia](https://fr.wikipedia.org/wiki/Hypertext_Markup_Language)

Si le XML est le fond, HTML est la forme.

---

### Un document HTML

```HTML
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8"/>
    <meta name="keywords"
          content="key1, key2"/>
    <title>Titre</title>
  </head>
  <body>
    <h1>This is the h1</h1>
    <div>
      <h2>This is the h2</h2>
      <p>First paragraph.</p>
      <p>Another
        <br/>paragraph.</p>
    </div>
  </body>
</html>
```

---

### HTML vs XML: points communs
- Structure arborescente
- Une balise ouverte doit être fermée
- Il est possible d'utiliser des balises autofermantes

---

### Principaux éléments HTML

C'est un vocabulaire non-extensible. Il a quelques éléments importants:
- L'élément ```<span>``` est un conteneur générique en ligne (_inline_) pour les contenus phrasés.
```XML
<div>Ici commence une div dont je veux <span>encadrer
un passage</span> pour telle et telle raison</div>
```

- L'élément ```<img>``` permet d'insérer une image. Le chemin vers le fichier est spécifié avec ```src``` et ```alt``` permet de fournir une description sommaire de l'image (si le navigateur n'arrive pas à l'ouvrir)

```HTML
<img src="chemin.jpg" alt="description"/>
```

---

### Principaux éléments HTML (suite)

- L'élément ```<ul>``` (_unordered list_) est une liste non numérotée
```HTML
<ul>
  <li>un item</li>
  <li>un autre item</li>
</ul>
```
On obtient une liste avec des puces :

```HTML
• un item
• un autre item
```

---

### Principaux éléments HTML (suite)


- L'élément ```<ol>``` (_ordered list_) fonctionne de la même manière
```HTML
<ol>
  <li>un item</li>
  <li>un autre item</li>
</ol>
```
On obtient une liste numérotée :

```HTML
1. un item
2. un autre item
```
---

### Principaux éléments HTML (suite)

- L'élément ```<a>``` permet de créer un lien. Il est utilisé avec ```@href``` pour encoder l'adresse du lien

```HTML
<a href="www.unige.ch">uni de Genève</a>
```

On obtient un lien du  type: [uni de Genève](www.unige.ch)

- L'élément ```<meta>``` permet d'ajouter des metadonnées au document

```HTML
<meta charset="utf-8"/>
<meta name="keywords"
      content="key1, key2"/>
```

---

### Deux attributs importants

- ```@class``` permet de catégoriser l'élément (utile pour javascript et CSS).

```HTML
<div>Ici commence une div où j'identifie une ville comme
  <span class="lieu">Paris</span> mais aussi beaucoup
  d'autres comme <span class="lieu">Berne</span> ou bien
  <span class="lieu">Berlin</span> parce que ça
  m'intéresse.</div>
```

- ```@id``` permet d'identifier un élément (utile pour javascript et CSS).

```HTML
<div>Ici commence une div dans laquelle je veux
  identifier le nom <span id="simon">Simon</span> parce
  que, encore une fois, ça m'intéresse.</div>
```


---

## Exercice

Fabriquez votre CV en HTML

---
## CSS
---

### CSS

CSS (_Cascading Style Sheets_) est un langage informatique qui décrit la présentation des documents HTML (et aussi XML…)

Plus d'informations sur [Wikipedia](https://fr.wikipedia.org/wiki/Feuilles_de_style_en_cascade)

---
### Sélection

<style scoped>
table {
    height: 100%;
    width: 100%;
    font-size: 13px;
}
</style>

|SELECTEUR | DECLARATION
|--- | ---
|sélecteur| {
| | propriété1: valeur1;
| | propriété2: valeur2;
| | …
| | propriétéN: valeurN;
| | }

Syntaxe:
- Sélecteur au début
- Bloc de règles, délimité par les accolades `{}`
- La propriété est séparée de la valeur par deux points `:`
- Une règle se termine par point-virgule `;`

---

### Sélection

Un document HTML (ou XML)

```XML
<span id="Voltaire">Voltaire</span>
<span class="auteur">Victor Hugo</span>
<span class="poète">Baudelaire</span>
```

Lié à la règle CSS suivante

```CSS
span{
 font-style: italic;
 font-weight: bold;
}
```

Produit

> ___Voltaire___
> ___Victor Hugo___
> ___Beaudelaire___

___

### Sélection II: précisions


Il est possible de sélectionner plusieurs éléments

```CSS
span,div{
 font-style: italic;
 font-weight: bold;
}
```

De restreindre la sélection via l'attribut

```CSS
span[class]{
 font-style: italic;
 font-weight: bold;
}
```

De restreindre la sélection via l'attribut et sa valeur
```CSS
span[class="auteur"]{
 font-style: italic;
 font-weight: bold;
}
```
___

### Sélection III: raccourcis

Pour sélectionner tous les éléments portant une même classe, on utilise un point:

```CSS
.auteur{
        font-style: italic;
}
```

Pour sélectionner l'élément portant un id précis, on utilise un dièse:

```CSS
#Voltaire{
        font-style: italic;
}
```

___

### Emplacement

1. _Inline_: à l'intérieur de l'```<élément>``` avec l'attribut ```@style```
```HTML
<h1 style="color:blue;">Heading 1</h1>
```
2 _Interne_: avec l'élément ```<style>``` dans la balise `<head>`
```HTML
<style>
  body {
         background-color: green;
       }
  h1   {
         color: maroon;
         margin-left: 40px;
       }
</style>
```
___

### Emplacement

<style scoped>
code {
    float: right;
    height: 100%;
    width: 100%;
    font-size: 22px;
}
</style>

3. Externe
```HTML
<!DOCTYPE html>
<html>
  <link rel="stylesheet" type="text/css" href="mon.css">
  <body>
    <h1>This is the h1</h1>
    <h2>This is the h2</h2>
    <p>My first paragraph.</p>
    <p>Another paragraph.</p>
  </body>
</html>
```

Contenu du fichier CSS

```CSS
  body {
         background-color: green;
       }
  h1   {
         color: maroon;
         margin-left: 40px;
       }
```
___

### Construire son dossier

```
racine
|-index.html
|-img
  |-img1.jpg
  |-img2.png
  |-img3.tif
|-css
  |-mon.css
|-scripts
  |-mon.js
|-docs
  |-unPdf.pdf
  |-fichierDocx.docx
|-README.md
```

Dans ` <link rel="stylesheet" href="mon.css">`, la valeur de l'attribut `@href` n'est pas le nom du fichier `.css` mais le chemin vers le fichier `.css`, donc `mon.css`.

___

### Quelques super-propriétés: ```font```
- ```font-size``` pour la taille du texte

```CSS
font-size:16px; /* valeurs en px, Em, % */
```

- ```font-weight``` pour les gras

```CSS
font-weight: bold; /* valeurs: bold, bolder, lighter */
```

- ```font-style``` pour les italiques

```CSS
font-style: italic; /* valeurs: italic, oblique */
```

- ```font-variant``` pour les capitales

```CSS
font-variant:small-caps;
```

___

### Quelques super-propriétés: ```text```

- ```text-indent``` pour l'alinéa

```CSS
text-indent:16px; /* valeurs en px, Em, % */
```

- ```text-align``` pour l'alignement

```CSS
text-align:justify; /* valeurs: left, center, right*/
```

- ```text-decoration``` ligne au dessus, au dessous, dessus
```CSS
text-align:decoration; /* valeurs: underline, overline,
line-through*/
```


___

### Quelques super-propriétés: ```background```

- ```background-color``` pour la couleur de fond. On utilise directement le nom de la couleur ou son code (![#000000](https://placehold.it/15/000000/000000?text=+) `#000000`, ![#FF0000](https://placehold.it/15/FF0000/000000?text=+) `#FF0000`, ![#0000FF](https://placehold.it/15/0000FF/000000?text=+) `#0000FF`, ![#FFFF00](https://placehold.it/15/FFFF00/000000?text=+) `#FFFF00`… cf. liste sur le [site du W3C](https://www.w3schools.com/cssref/css_colors.asp))
```CSS
background-color:green; /* nom ou code couleur*/
```

- ```background-align``` pour l'image de fond

```CSS
background-image:url(images/image_de_fond.png);
```

___

### Quelques super-propriétés: ```margin``` et ```padding```

- ```padding``` pour la marge intérieure (entre le contenu et la bordure)

```CSS
padding:16px; /* valeurs en px, Em, % */
```
- Il est possible de préciser quelle marge (haut, bas, gauche…)
```CSS
padding-top:16px; /* valeurs en px, Em, % */
padding-left:16px;
```

- ```margin``` pour la marge extérieure (après la bordure)

```CSS
margin:16px; /* valeurs en px, Em, % */
```
- Il est possible de préciser quelle marge (haut, bas, gauche…)
```CSS
margin-top:16px; /* valeurs en px, Em, % */
margin-left:16px;
```

---

### Margin vs padding

![80% center](images/CSS.jpg)

___

### À savoir

- ```color``` permet de changer la couleur de la police [(cf. W3C)](https://www.w3schools.com/cssref/pr_text_color.asp)

```CSS
color:red;  /* nom ou code couleur*/
```

- ```display``` définit le type d'affichage utilisée pour le rendu d'un élément [(cf. W3C)](https://www.w3schools.com/cssref/pr_class_display.asp)

```CSS
display:block;  /* nom ou code couleur*/
```

- Il est possible (et même conseillé) de commenter son code
```CSS
/* commentaire */
```
___

### Conflits

En cas de conflit, la dernière règle s'applique
```CSS
div {
      background-color: green;
}
div[class="chapter"]   {
      background-color: yellow;
      }
```

→ Toutes les ```<div>``` auront un fond vert, sauf celle avec un attribut ```@type="chapter"```

```CSS
div[class="chapter"]   {
      background-color: yellow;
      }
div {
      background-color: green;
}
```

→ Toutes les `<div>` auront un fond vert, même celle avec un attribut `@type="chapter"`

---
## One more thing

Nous n'avons pas le temps d'aborder le sujet, mais plutôt que de faire son CSS directement, il est très chaudement recommandé d'utiliser _Bootstrap_. Vous trouverez un premier tutoriel en ligne: https://www.w3schools.com/bootstrap/bootstrap_get_started.asp

---
## Exercice

Stylez avec un CSS externe votre CV