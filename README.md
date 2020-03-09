# Cours Visualisation

Genève, semestre de printemps  2020

Simon Gabay

---
## Installation

### R

Vous avez besoin du langage _R_
1. Pour Windows (😡): https://cran.r-project.org/bin/windows/base
2. Pour Mac: https://cran.r-project.org/bin/macosx. Pensez à installer `XQuartz` pour pouvoir faire fonctionner le package `stylo`.
3. Pour linux: `$ sudo apt install r-base-core`

Il faut ensuite télécharger _RStudio_: https://rstudio.com/products/rstudio/download/#download

### Gephi

Pour installer _Gephi_: https://gephi.org/users/download/

Si vous êtes sous Windows, il n'est pas inutile d'allumer un cierge (ou équivalent selon votre croyance).

---
## Repères bibliogrpahiques

Les références sont données au format bibTex pour les mettre dans Zotero (téléchargeable [ici](https://www.zotero.org), si vous ne l'avez pas encore).

### Généralités

```bibtex
@book{schreibman_companion_2004,
  author = {Schreibman, Susan and Siemens, Ray and Unsworth, John},
  title = {Companion to {Digital} {Humanities} ({Blackwell} {Companions} to {Literature} and {Culture})},
  address = {Oxford},
  publisher = {Blackwell Publishing Professional},
  month = dec,
  year = {2004},
  series = {Blackwell {Companions} to {Literature} and {Culture}},
  isbn = {978-1-4051-0321-3},
  url = {http://www.digitalhumanities.org/companion/},
}
@book{tufte_visual_1983,
  author = {Tufte, Edward R.},
  title = {The Visual Display of Quantitative Information},
  address = {Cheshire, CT},
  publisher = {Graphics Press},
  year = {1983},
  isbn = {978-0-9613921-0-9},
}
@book{drucker_visualisation_2020,
  author = {Drucker, Johanna},
  title = {Visualisation. {L}’interprétation modélisante},
  publisher = {B42 Eds},
  year = {2020},
  series = {Esthetique {Des} {Donnees}},
  number = {3},
}
```

### Quelques manuels pour utiliser `R` quand on est spécialiste de sciences humaines:

```bibtex
@book{silge_text_2017,
  author = {Silge, Julia and Robinson, David},
  title = {Text mining with {R} : a tidy approach},
  isbn = {978-1-4919-8165-8},
  address = {Beijing, Boston},
  publisher = {O'Reilly},
  year = {2017},
}

@book{jockers_text_2014,
  author = {Jockers, Matthew Lee},
  title = {Text analysis with {R} for students of literature},
  series = {Quantitative {Methods} in the {Humanities} and {Social} {Sciences}},
  address = {Cham},
  publisher = {Springer},
  year = {2014},
  isbn = {978-3-319-03163-7},
}

@book{arnold_humanities_2015,
  author = {Arnold, Taylor and Tilton, Lauren},
  title = {Humanities data in {R} : exploring networks, geospatial data, images, and text},
  address = {Cham},
  publisher = {Springer International Publishing},
  year = {2015},
  edition = {1st ed. 2015},
  series = {Quantitative {Methods} in the {Humanities} and {Social} {Sciences}},
  isbn = {978-3-319-20702-5},
}
```

### Quelques articles relatifs aux sujets abordés en cours:

1. Topic modeling

```bibtex
@article{schoch_dhq:_2017,
  author = {Schöch, Christof},
  title = {{DHQ}: {Digital} {Humanities} {Quarterly}: {Topic} {Modeling} {Genre}: {An} {Exploration} of {French} {Classical} and {Enlightenment} {Drama}},
  journal = {Digital Humanities Quarterly},
  volume = {11},
  number = {2},
  year = {2017},
  url = {http://www.digitalhumanities.org/dhq/vol/11/2/000291/000291.html},
}
```

2. Stylométrie

```bibtex
@article{evert_understanding_2017,
  author = {Evert, Stefan and Proisl, Thomas and Jannidis, Fotis and Reger, Isabella and Pielström, Steffen and Schöch, Christof and Vitt, Thorsten},
  title = {Understanding and explaining {Delta} measures for authorship attribution},
  journal = {Digital Scholarship in the Humanities},
  volume = {32},
  number = {suppl\_2},
  month = dec,
  year = {2017},
  pages = {ii4--ii16},
  url = {https://academic.oup.com/dsh/article/32/suppl_2/ii4/3865676},
  doi = {10.1093/llc/fqx023},
}
@article{eder_visualization_2017,
  author = {Eder, Maciej},
  title = {Visualization in stylometry: {Cluster} analysis using networks},
  journal = {Digital Scholarship in the Humanities},
  volume = {32},
  number = {1},
  month = apr,
  year = {2017},
  pages = {50--64},
  url = {https://academic.oup.com/dsh/article/32/1/50/2957386},
  doi = {10.1093/llc/fqv061},
}
```

3. Réseau

```bibtex
@article{grandjean_introduction_2015,
  author = {Grandjean, Martin},
  title = {Introduction à la visualisation de données : l'analyse de réseau en histoire},
  journal = {Geschichte und Informatik},
  number = {18/19},
  year = {2015},
  pages = {109--128},
  url = {https://halshs.archives-ouvertes.fr/halshs-01525543},
}
@incollection{venturini_how_2017,
  author = {Venturini, Tommaso and Bounegru, Liliana and Jacomy, Mathieu and Gray, Jonathan},
  title = {How to {Tell} {Stories} with {Networks}: {Exploring} the {Narrative} {Affordances} of {Graphs} with the {Iliad}},
  editor = {Schäfer, Mirko Tobias and van Es, Karin},
  booktitle = {Datafied {Society}},
  publisher = {Amsterdam University Press},
  year = {2017},
  url = {https://hal.archives-ouvertes.fr/hal-01672295},
}
```

4. Cartographie
```bibtex
@inproceedings{boeglin_pour_2016,
  author = {Boeglin, Noémie and Depeyre, Michel and Joliveau, Thierry and Le Lay, Yves-François},
  booktitle = {Conférence {Spatial} {Analysis} and {GEOmatics}},
  title = {Pour une cartographie romanesque de {Paris} au {XIXe} siècle. {Proposition} méthodologique},
  address = {Nice, France},
  month = dec,
  year = {2016},
  series = {Actes de la conférence {SAGEO}'2016 - {Spatial} {Analysis} and {GEOmatics}},
  url = {https://hal.archives-ouvertes.fr/hal-01619600},
}
@article{murrieta-flores_gis_2017,
  author = {Murrieta-Flores, Patricia and Donaldson, Christopher and Gregory, Ian},
  title = {{GIS} and {Literary} {History}: {Advancing} {Digital} {Humanities} research through the {Spatial} {Analysis} of historical travel writing and topographical literature},
  journal = {DHQ: Digital Humanities Quarterly},
  volume = {11},
  number = {1},
  year = {2017},
  url = {http://www.digitalhumanities.org/dhq/vol/11/1/000283/000283.html},
}
@misc{noauthor_literary_nodate,
  type = {Text},
  title = {Literary {Mapping} in the {Digital} {Age}: 1st {Edition} ({Hardback}) - {Routledge}},
  shorttitle = {Literary {Mapping} in the {Digital} {Age}},
  url = {https://www.routledge.com/Literary-Mapping-in-the-Digital-Age-1st-Edition/Cooper-Donaldson-Murrieta-Flores/p/book/9781472441300},
  language = {en},
  urldate = {2019-10-23},
  journal = {Routledge.com},
}
```

---
## Droits
CC-BY, sauf les données prises chez les collègues (indiquées dans les ```.Rmd```).

<img style="float: right; width: 20%;" src="images/cc-by.png">
