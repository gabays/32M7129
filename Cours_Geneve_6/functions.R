customPlot<-function(var1,
                     var2,
                     var3,
                     var4,
                     agglo=round(var3, digit=2),
                     main_title="Cluster analysis",
                     x_lab=paste(var2,"\n Agglomerative coefficient =", agglo),
                     y_lab="",
                     k=2,
                     hang = -0.1,
                     cex = 0.6)
{
  if(missing(var4)) {
    var4=1
  }
  labels_color = vector(length = length(CAH$order.lab))
  labels_color[grep("boyer", CAH$order.lab)] = "darkblue"
  labels_color[grep("duryer", CAH$order.lab)] = "darkgrey"
  labels_color[grep("scarron", CAH$order.lab)] = "darkred"
  labels_color[grep("moliere", CAH$order.lab)] = "darkgreen"


  plot(var1)
  
  factoextra::fviz_dend(var1,
                        k=k,
                        k_colors = rep("black",k),
                        rect = TRUE,
                        labels_track_height = var4,
                        label_cols = labels_color,
                        main=main_title,
                        ylab=x_lab,
                        xlab=y_lab,
                        horiz=T)
}