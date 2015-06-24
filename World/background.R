library(ggplot2)
library(maps)
library(rgeos)
library(maptools)
gpclibPermit()

setwd('c:\\users\\weimin-srx\\desktop\\plot')
rm(list = ls())

urbanareasin <- readShapePoly("ne_10m_urban_areas.shp")

worldmap = map_data ("world")
wrld<-c(geom_polygon(aes(long,lat,group=group), size = 0.1, colour= "#090D2A", fill="#090D2A", alpha=0.8, data=worldmap))

urb <- c(geom_polygon(aes(long, lat, group = group),
                      size = 0.3,
                      color = "#ffffff",
                      fill = "#ffffff",
                      alpha = 1,
                      data = urbanareasin))

ggplot() + wrld + urb + theme(panel.background = element_rect(fill='#00001C',colour='#00001C'), 
                              panel.grid.major = element_blank(), panel.grid.minor = element_blank())
