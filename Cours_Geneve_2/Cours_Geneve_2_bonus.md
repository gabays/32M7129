---
title: "Collecter des images sur Tweeter"
author: "Simon Gabay"
date: "03/03/2020"
output:
  ioslides_presentation: default
  html_notebook: default
  beamer_presentation: default
  slidy_presentation: default
---

Je prépare mes packages

```{r}
if (!require("knitr")) install.packages("knitr")
if (!require("rtweet")) install.packages("rtweet")
if (!require("dplyr")) install.packages("dplyr")
```

Je prépare ma session de travail
ATTENTION: C'EST LÀ OÙ LES IMAGES VONT ÊTRE TELECHARGEES!!!!

```{r}
setwd("~/GitHub/Cours_2020_UniGE/Cours_Geneve_2")
dossier_image<-getwd()
```

Je télécharge les 50 derniers tweets qui contiennent  "Geneva"

```{r}
get_images <- get_timeline("geneva", n = 50)
```

Petit coup d'œil aux résultats

```{r}
get_images %>%
  glimpse()
```

Je remarque une colonne "media_url"… Je regarde de plus près:

```{r}
get_images$media_url
```

C'est bien ce que je veux: je prépare une liste vide que je vais remplir des url

```{r}
toutes_les_url<-c()
```

Je loop sur ma colonne `$media_url`

```{r}
for (tweet in get_images$media_url){
  #subtilité: chaque résultat est une liste, je dois donc récupérer le objet de chaque liste, et donc refaire une boucle
  for (tweet_media in tweet){
    #Si c'est vide ("NA"), je ne récupère rien
    if(!is.na(tweet_media))
      toutes_les_url=c(toutes_les_url,tweet_media)
  }
}
```

J'affiche les urls récupérées pour contrôler que tout est en ordre

```{r}
toutes_les_url
```

Je télécharge toutes les images dans mon dossier de travail

```{r}
for (image in seq_along(toutes_les_url)){
  download.file(toutes_les_url[image], destfile = paste(dossier_image, image,'.jpg'), mode="wb")
}
```
