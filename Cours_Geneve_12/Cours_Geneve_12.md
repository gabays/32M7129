---
title: "Cours_Geneve_12"
author: "Simon Gabay"
date: "`r Sys.Date()`"
#output:
#  html_notebook:
#    number_sections: yes
#    toc: yes
#    toc_float: yes
---

```{r, setup, fig.show=hold, fig.margin=TRUE}
if(!require("knitr")){
  install.packages("knitr")
  library(knitr)
}
knitr::opts_chunk$set(echo = TRUE, fig.width=20)
```

# Préparatifs

```{r}
setwd("~/GitHub/Cours_2020_UniGE/Cours_Geneve_12")
#je charge les données que l'enseignant a préparé pour éviter de potentiels problèmes
#load("Cours_Geneve_12.RData")
```

```{r, warning=FALSE, results='hide'}
if(!require("leaflet")){
  install.packages("leaflet")
  library(leaflet)
}
if(!require("rgdal")){
  install.packages("rgdal")
  library(rgdal)
}
if(!require("sf")){
  install.packages("sf")
  library(sf)
}
if(!require("ggplot2")){
  install.packages("ggplot2")
  library(ggplot2)
}
if(!require("raster")){
  install.packages("raster")
  library(raster)
}
if(!require("plyr")){
  install.packages("plyr")
  library(plyr)
}
if(!require("leaflet.extras")){
  install.packages("leaflet.extras")
  library(leaflet.extras)
}
if(!require("htmlwidgets")){
  install.packages("htmlwidgets")
  library(htmlwidgets)
}
if(!require("geojsonio")){
  install.packages("geojsonio")
  library(geojsonio)
}
if(!require("jsonlite")){
  install.packages("jsonlite")
  library(jsonlite)
}
if(!require("leaftime")){
  install.packages("leaftime")
  library(leaftime)
}

```

# Travailler avec des _shapefiles_ 

```{r, results='hide'}
#import de shapefile
shp <- readOGR('Data/shapefile/area.shp')
```


On le rappelle, les fichiers `.shp` sont aussi des fichiers complexes, qui contiennent des informations en plus des simples formes géométriques. En l'occurrence, notre document contient

```{r}
df <- data.frame(area=shp$area,occurrences=shp$number)
df
```

On crée une palette, qui utilise une palette de couleur prédéfinie et qui est fonction du nombre d'occurrence par zone

```{r}
pal <- colorNumeric(palette = "YlOrRd", domain = shp$number)
```

```{r}
leaflet(shp)%>%
## On ajoute un fond de carte
addProviderTiles(providers$Esri.NatGeoWorldMap)%>% 
  
  # Je définis le point central de ma carte
  setView(lng = 13, 
          lat = 40, 
          zoom = 2.2 )%>%
  
  # J'ajoute mes grandes zones
    addPolygons(data = shp, 
                stroke = FALSE, 
                smoothFactor = 0.2, 
                color = ~pal(shp$number),
                group = "Zones",
                fillOpacity = 1)
```

Je peux évidemment mélanger les sources

```{r}
#import du CSV de Boyer (cf. cours  précédent)
boyer  <- read.csv("Data/boyer.csv")
leaflet(shp)%>%
## On ajoute un fond de carte
addProviderTiles(providers$Esri.NatGeoWorldMap)%>% 
  
  # Je définis le point central de ma carte
  setView(lng = 13, 
          lat = 40, 
          zoom = 2.2 )%>%
  
  # J'ajoute mes grandes zones
    addPolygons(data = shp, 
                stroke = FALSE, 
                smoothFactor = 0.2, 
                color = ~pal(shp$number),
                group = "Zones",
                fillOpacity = 1)%>%
  
  # J'ajoute les points issues des pièces de Boyer, importées précédemment
  addCircleMarkers(lng = boyer$lng, 
                   lat = boyer$lat,
                   color = "brown",
                   group = "Boyer",
                   weight = 1,
                   radius = 14,
                   fillOpacity = 0.6)
  
```

Enfin, un petit coup de tuning

![100%](images/tuning.gif)


```{r}
map<-leaflet(shp)%>%
## On ajoute un fond de carte
addProviderTiles(providers$Esri.NatGeoWorldMap)%>% 
  
  # Je définis le point central de ma carte
  setView(lng = 13, 
          lat = 40, 
          zoom = 2.2 )%>%
  
  # J'ajoute mes grandes zones
    addPolygons(data = shp, 
                stroke = FALSE, 
                smoothFactor = 0.2, 
                color = ~pal(shp$number),
                group = "Zones",
                fillOpacity = 1)%>%
  
  # J'ajoute les points issues des pièces de Boyer, importées précédemment
  addCircleMarkers(lng = boyer$lng, 
                   lat = boyer$lat,
                   color = "brown",
                   group = "Boyer",
                   weight = 1,
                   radius = 14,
                   fillOpacity = 0.6)  %>%
  
  #J'ajoute une fonction "reset", qui permet de reactiver setView()
  addResetMapButton() %>%
    
  #J'ajoute un panneau de contrôle qui me permet de choisir ce que je sélectionne
  addLayersControl(baseGroups = c("Empty layer"),
                   
                   overlayGroups = c("Zones", "Boyer"),
                   options = layersControlOptions(collapsed = TRUE)) %>%
  
  #Je cache par défaut les points tirés des pièces de Boyer
  hideGroup(c("Boyer"))
map
```

Je peux sauvegarder ma carte en html et l'ouvrir dans le navigateur (attention, cela peut prendre du temps).

```{r}
#saveWidget(map, file="maCarte.html")
#browseURL("maCarte.html")
```

# Timeline

Nous reprenons le même jeu de données que précédemment, avec nos quatre villes.

```{r}
sales <- data.frame(
                    "Latitude" = c(
                      48.8534, 52.520008, 51.509865, 50.8466
                    ),
                    "Longitude" = c(
                      2.3488, 13.404954, -0.118092, 4.3528
                    ),
                    "population" = c(
                      2.148, 3.769,8.982, 1.209 # en millions
                    ),
                    labels = c("Paris", "Berlin", "Londres", "Bruxelles")
  )
```

Pour créer une _Timeline_ il va logiquement falloir associer des dates: une de début, et une de fin.

```{r}
#j'ajoute une colonne à mon dataframe
sales$start <- c(
                    "start" = do.call(
                      #je précise que les données sont des dates
                      "as.Date",
                      #je crée une liste avec
                      list(
                        #les données
                        x = c("1-Jan-1918", "1-Jan-1919","1-Jan-1920", "1-Jan-1921"),
                        #le format des données
                        format = "%d-%b-%Y"
                      )
                    )
  )
#je recommence la même manipulation, cette fois avec la date de fin
sales$end <- c(
                    "end" = do.call(
                      "as.Date",
                      list(
                        x = c("30-Dec-1918", "30-Dec-1919","30-Dec-1920", "30-Dec-1921"),
                        format = "%d-%b-%Y"
                      )
                    )
  )
#Je pourrais copier-coller les dates de début si ce sont les mêmes que les dates de fin
#sales$end<-sales$start
```

J'obtiens donc un data frame, avec la population, les dates de début, les dates de fin

```{r}
sales
```

Je peux désormais convertir mon dataframe en fichier GEOjson:

```{r}
sales_timeline <- geojson_json(sales,lat="Latitude",lon="Longitude")
```

Le fichier GEOjson que nous avons fabriqué respecte les recommendations de `Leaflet.timeline`, qui est un type spécifique de fichier `GEOjson`. Le début est le suivant:

```json
{"type":
  "FeatureCollection",
  "features":
  [
    {"type":"Feature",
      "geometry": {
        "type":"Point",
        "coordinates":[2.3488,48.8534]
      },
      "properties":{
        "labels":"Paris",
        "population":"2.148",
        "start":"1918-01-01",
        "end":"1918-01-01"
      }
    },
    {"type":"Feature",
      "geometry":{
        "type":"Point",
        "coordinates":[13.404954,52.52001]
      },
      "properties":{
        "labels":"Berlin",
        "population":"3.769",
        "start":"1919-01-01",
        "end":"1919-01-01"
      }
    },
    …
```

Je peux sauvegarder le résultat au format `json` si je veux regarder en détail le code produit:

```{r}
data_JSON <- fromJSON(sales_timeline)
write(sales_timeline, "output.json") 
```

Je peux désormais créer ma première carte avec timeline.

```{r}
  leaflet(sales_timeline) %>%
    addTiles() %>%
    setView(lng = 5, lat = 50, zoom = 5) %>%
   # il suffit d'ajouter la fonction addTimeline(), c'est tout
    addTimeline()
```

Je peux néanmoins faire mieux, et ajouter des options. Jouez un peu avec celles-ci pour apprendre à les maîtriser.

```{r}
  leaflet(sales_timeline) %>%
    addTiles() %>%
    setView(lng = 5, lat = 50, zoom = 5) %>%
    addTimeline(
      #largeur du bouton de contrôle
      width = "50%",
      sliderOpts = sliderOptions(
        #position sur la carte de la timeline
        position = "topright", #bottomright…
        #nombre d'étapes lors du défilement de la timeline
        step = 20, 
        #rapidité du défilement
        duration = 4000 
      )
    )
```

Je peux aussi modifier la forme des marqueurs (_marker_) que j'utilise sur ma carte.

```{r}
  leaflet(sales_timeline) %>%
    addTiles() %>%
    setView(lng = 5, lat = 50, zoom = 5) %>%
    addTimeline(
      #largeur du bouton de contrôle
      width = "50%",
      sliderOpts = sliderOptions(
        #position sur la carte de la timeline
        position = "topright", #bottomright…
        #nombre d'étapes lors du défilement de la timeline
        step = 20, 
        #rapidité du défilement
        duration = 4000 
      ),
      timelineOpts = timelineOptions(
        styleOptions = styleOptions(
          #rayon des marqueurs (qui seront donc des cercles)
          radius = 10,
          #couleur de la bordure des marqueurs
          color = "grey",
          #couleur de fond des marqueurs
          fillColor = "orange",
          #opacité du marqueur
          fillOpacity = 1
        )
      )
    )
```

Je crée une copie de mon data frame, et je crée une colonne `radius` (rayon) qui est fonction de la population de la ville

```{r}
sales_radius<-sales
sales_radius$radius <- sales_radius$population*3
```

J'utilise cette information pour gérer la taille des marqueurs

```{r}
  leaflet(geojson_json(sales_radius)) %>%
    addTiles() %>%
    setView(lng = 5, lat = 50, zoom = 5) %>%
    addTimeline(
      #largeur du bouton de contrôle
      width = "50%",
      sliderOpts = sliderOptions(
        #position sur la carte de la timeline
        position = "topright", #bottomright…
        #nombre d'étapes lors du défilement de la timeline
        step = 20, 
        #rapidité du défilement
        duration = 4000 
      ),
      timelineOpts = timelineOptions(
         # j'annule tous les styles (et j'évite que les paramètres par défaut ne soient utilisés)
        styleOptions = NULL,
        #Je vais mettre mes options de visualisation ici
        pointToLayer = htmlwidgets::JS(
          "
  function(data, latlng) {
  return L.circleMarker(
    latlng,
    {
      radius: +data.properties.radius,
      fillOpacity: 1
    }
  );
}
"
        )
      )
    )
```

# Carte statique

## Des rasters

Un autre approche de la cartographie va être de produire des cartes statiques. Nous allons, pour ce faire, utiliser des rasters (et donc le package du même nom).

```{r}
Switzerland<-getData("GADM", country="Switzerland", level=0)
```

Il est ensuite très simple d'afficher ce fond de carte

```{r}
plot(Switzerland)
```

On aura remarqué le paramètre `level=0`. Chacun des niveaux représente une strate administrative

```{r, warning=FALSE}
Switzerland1<-getData("GADM", country="Switzerland", level=1)
plot(Switzerland1)
Switzerland2<-getData("GADM", country="Switzerland", level=2)
plot(Switzerland2)
```

Evidemment, ce système fonctionne avec d'autres pays:
```{r}
France<-getData("GADM", country="France", level=1)
plot(France)
```

Rappelons-nous que ces coordonnées sont _géographiques_ et non _cartographiques_: je dois donc les transformer avec la fonction `spTransform()`. J'utilise ici le système géodésique [WGS 84](https://fr.wikipedia.org/wiki/WGS_84) (_World Geodetic System 1984_) et j'obtiens donc des données UTM (_Universal Transverse Mercator_).

```{r}
Switzerland1_UTM<-spTransform(Switzerland1, CRS("+proj=longlat +datum=WGS84"))
Switzerland1_UTM
Switzerland1_UTM@data
```

Je crée désormais des données linsguistiques, à partir d'un sondage très rigoureux auprès de trois collègues sur l'emploi de _quatre-vingts_ et _huitante_ en Suisse.

```{r}
NAME_1<-c("Fribourg","Neuchâtel", "Genève", "Jura", "Valais", "Vaud",
          "Aargau", "Appenzell Ausserrhoden", "Appenzell Innerrhoden", "Basel-Landschaft", "Basel-Stadt", "Bern", "Glarus", "Graubünden", "Lucerne", "Nidwalden", "Obwalden", "Sankt Gallen", "Schaffhausen", "Schwyz", "Solothurn", "Thurgau", "Ticino", "Uri", "Zug", "Zürich")
eighty<-c("huitante","quatre", "quatre", "quatre", "huitante", "huitante",
            "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA", "NA","NA", "NA")
dialecto<-data.frame(NAME_1,eighty)
dialecto
```

Je rajoute ces nouvelles informations à mon objet `Switzerland1_UTM`, que je convertis en data.frame.

```{r, warning=FALSE, results='hide'}
Switzerland1_UTM@data <- join(Switzerland1_UTM@data, dialecto, by="NAME_1")
Switzerland1_df <- fortify(Switzerland1_UTM)
```

Je peux créer des jeux de données restreints, que j'extraie de l'objet `Switzerland1_UTM`

```{r, warning=FALSE, results='hide'}
#Je peux extraire un canton en fonction de son nom: ici celui de Genève
Geneve<-Switzerland1_UTM[Switzerland1_UTM@data$NAME_1 == "Genève",]
Geneve_df<-fortify(Geneve)

#Je peux extraire plusieurs cantons en fonction d'un autre critère que son nom — ici, "huitante" pour "quatre-vingt"
canton_huitante<-Switzerland1_UTM[Switzerland1_UTM@data$eighty == "huitante",]
canton_huitante_df<-fortify(canton_huitante)

#Je peux extraire plusieurs cantons en fonction d'un autre critère que son nom — ici, "quatre-vingt" pour "huitante"
canton_quatre<-Switzerland1_UTM[Switzerland1_UTM@data$eighty == "quatre",]
canton_quatre_df<-fortify(canton_quatre)
```

Je projette ensuite ces informations sur une carte:

```{r}
#j'utilise la fonction ggplot
ggplot() + 
  #Je place tous les cantons, en blanc
  geom_polygon(data=Switzerland1_df, aes(long,lat, group=group), fill="white", size=0.1) +
  #Je superpose le canton de Genève, en rouge
  geom_polygon(data=Geneve_df, aes(long,lat,group=group), fill="red")+
  #Je superpose enfin les contours des différents cantons
  geom_path(data=Switzerland1_df, aes(long,lat, group=group), color="darkgrey", size=0.1)
```


Je peux placer plusieurs données différentes:

```{r}
ggplot() + 
  #je place mes cantons où l'on dit "huitante"
  geom_polygon(data = canton_huitante_df, aes(x = long, y = lat, group = group, fill = "huitante"), color = "black", size = 0.25) +
  #je place mes cantons où l'on dit "quatre-vingts"
  geom_polygon(data = canton_quatre_df, aes(x = long, y = lat, group = group, fill = "quatre-vingts")) +
  scale_fill_manual(values=c("red", "white")) #scale_fill_brewer(palette = "Blues")
```

## Des points

Je vais pouvoir rajouter des données scientifiques à mon enquête. En linguistique, on utilise les points géographiques de l'ALF (_Atlas linguistique de la France_), publié entre 1902 et 1910.

![100% center](images/CarteALF1113.jpg)

![100% center](images/CarteALF1113_suisse.jpg)

Nous préparons donc les données pour chaque point (suisse):

```{r}
releves = read.table("Data/80.tsv", header=T, sep="\t", quote="", dec=".")
head(releves)
```

Je dispose par ailleurs d'un fichier contenant, pour chaque point, le nom du lieu et ses coordonnées géographiques

```{r}
georeferecement = read.table("Data/ALF-suisse.tsv", header=T, sep="\t", quote="", dec=".")
georeferecement
```

Je peux donc, à partir de ces deux fichiers, créer un tableau complet:

```{r}
dialecto_swiss = merge(releves,georeferecement,by="id")
head(dialecto_swiss)
```

Je récupère mon fond de carte

```{r}
world <- map_data('world')
```

Je crée ma carte

```{r}
ggplot()+
  geom_polygon(data = world, aes(x=long, y = lat, group = group), fill="white", colour = "black", size=0.4) +
  coord_quickmap(xlim = c(5.8, 7.8), ylim = c(45.8, 47.5)) 
```

Je place mes points
```{r}
ggplot()+
  geom_polygon(data = world, aes(x=long, y = lat, group = group), fill="white", colour = "black", size=0.4) +
  coord_quickmap(xlim = c(5.8, 7.8), ylim = c(45.8, 47.5)) +
  
  geom_point(data = dialecto_swiss, mapping = aes(x = Long, y = Lat, color = token, shape = token), size=3.3) +
  geom_text(data = georeferecement, mapping = aes(x = Long, y = Lat, label=id), color="black", size = 3.3, nudge_x= 0.11)
```

Je modifie les marqueurs:

```{r}
ggplot()+
  geom_polygon(data = world, aes(x=long, y = lat, group = group), fill="white", colour = "black", size=0.4) +
  coord_quickmap(xlim = c(5.8, 7.8), ylim = c(45.8, 47.5)) +
  
  geom_point(data = dialecto_swiss, mapping = aes(x = Long, y = Lat, color = token, shape = token), size=3.3) +
  geom_text(data = georeferecement, mapping = aes(x = Long, y = Lat, label=id), color="black", size = 3.3, nudge_x= 0.11) +

  scale_color_manual(values=c("darkblue","darkred"), "",
                     limits=c("huitante","quatre-vingts")) +
  #changer les chiffres 19 et 17 par d'autres, et observez
  scale_shape_manual(values=c(19,17), "", limits=c("huitante","quatre-vingts")) 
```

Je crée une carte qui superpose toutes les informations

```{r}
ggplot() + 
  #je replace mes cantons
  geom_polygon(data = canton_quatre_df, aes(x = long, y = lat, group = group, fill = "quatre-vingts")) +
  geom_polygon(data = canton_huitante_df, aes(x = long, y = lat, group = group, fill = "huitante"), color = "black", size = 0.25) +
  scale_fill_manual(values=c("red", "white")) + #scale_fill_brewer(palette = "Blues")
  
  #J'ajoute mes points
  geom_point(data = dialecto_swiss, mapping = aes(x = Long, y = Lat, color = token, shape = token), size=3.3) +
  geom_text(data = georeferecement, mapping = aes(x = Long, y = Lat, label=id), color="black", size = 3.3, nudge_x= 0.11)+
  
  #Je choisis la visualisation de mes points
  scale_color_manual(values=c("darkblue","darkred"), "",
                     limits=c("huitante","quatre-vingts")) +
  scale_shape_manual(values=c(19,17), "", limits=c("huitante","quatre-vingts"))
```

Je peux préparer mes données d'affichage:

```{r}
theme_opts<-list(theme(
                       panel.grid.minor = element_blank(),
                       panel.grid.major = element_blank(),
                       axis.line = element_blank(),
                       axis.text.x = element_blank(),
                       axis.text.y = element_blank(),
                       axis.ticks = element_blank(),
                       axis.title.x = element_blank(),
                       axis.title.y = element_blank(),
                       plot.title = element_blank(),
                       legend.justification=c(0,0),
                       axis.ticks.x=element_blank(),
                       axis.ticks.y=element_blank(),
                       #Je définis le cadre de la carte
                       panel.background=element_rect(fill = "transparent", colour = "grey"),
                       #Je définis lôrganisation de ma légende
                       legend.box="horizontal",
                       #taille des boîtes contenant les échantillons de couleurs
                       legend.key.size=unit(1,"lines"), 
                       #contour des boîtes
                       legend.key = element_rect(fill = "transparent", color="grey"),
                       #Texte de la légende
                       legend.text=element_text(size=12, color="black"),
                       #Titre de la légende
                       legend.title=element_text(size=12, color="transparent", face = "bold"),  
                       #Fond de la légende
                       legend.background = element_rect(fill = "beige")
                       )
                )
```

Je crée ma carte

```{r}
map <- ggplot() + 
  #je replace mes cantons
  geom_polygon(data = canton_quatre_df, aes(x = long, y = lat, group = group, fill = "quatre-vingts"), color = "black", size = 0.25) +
  geom_polygon(data = canton_huitante_df, aes(x = long, y = lat, group = group, fill = "huitante"), color = "black", size = 0.25) +
  scale_fill_manual(values=c("red", "white")) + #scale_fill_brewer(palette = "Blues")
  
  #J'ajoute mes points
  geom_point(data = dialecto_swiss, mapping = aes(x = Long, y = Lat, color = token, shape = token), size=3.3) +
  geom_text(data = georeferecement, mapping = aes(x = Long, y = Lat, label=id), color="black", size = 3.3, nudge_x= 0.11)+
  
  #Je choisis la visualisation de mes points
  scale_color_manual(values=c("darkblue","darkred"), "",
                     limits=c("huitante","quatre-vingts")) +
  scale_shape_manual(values=c(19,17), "", limits=c("huitante","quatre-vingts")) +

  #J'ajoute le options de thème que je viens de définir
  theme_opts
map
```

Je sauvegarde ma carte

```{r}
ggsave(map, filename = "carte_huitante.png", device = "png", width = 30, height = 20, units = "cm") 
```

![100% center](carte_huitante.png)
