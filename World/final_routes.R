library(ggplot2)
library(maps)
library(rgeos)
library(maptools)
library(ggmap)
library(geosphere)
library(plyr)
gpclibPermit()

setwd('c:\\users\\weimin-srx\\desktop\\plot')
rm(list = ls())

fortify.SpatialLinesDataFrame = function(model, data, ...){
  ldply(model@lines, fortify)
}

df = read.csv('routes_all.csv', stringsAsFactor=F)
plot_countries = c('United States', 'United Kingdom', 'Spain', 'Germany', 'France', 'Italy','China', 'Singapore')
df = df[df$from %in% plot_countries,]

routes = gcIntermediate(df[,c('lon1', 'lat1')], df[,c('lon2', 'lat2')], 200, breakAtDateLine = FALSE, addStartEnd = TRUE, sp=TRUE)

fortifiedroutes = fortify.SpatialLinesDataFrame(routes) 

#### merge to form great circles 
routes_count = data.frame('count'=df$count, 'id'=1:nrow(df), 'Countries'=df$from)
greatcircles = merge(fortifiedroutes, routes_count, all.x=T, by='id')

####

worldmap = map_data ("world")

wrld<-c(geom_polygon(aes(long,lat,group=group), size = 0.1, colour= "#090D2A", 
                     fill="#090D2A", alpha=0.8, data=worldmap))

urbanareasin <- readShapePoly("ne_10m_urban_areas.shp")
urb <- c(geom_polygon(aes(long, lat, group = group),
                    size = 0.3,
                    color = "#ffffff",
                    fill = "#ffffff",
                    alpha = 0.8,
                    data = urbanareasin))


ggplot() + 
wrld +
urb + 
geom_line(aes(long,lat,group=id, color=Countries), alpha = 0.3, size=0.01, data= greatcircles) + 
theme(panel.background = element_rect(fill='#00001C',colour='#00001C'), panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
theme(legend.position = c(0,0.4),
     legend.justification = c(0,1),
     legend.background = element_rect(colour = NA, fill = NA),
     legend.key = element_rect(colour = NA, fill = NA, size = 10),
     legend.text = element_text(colour='white', size = 20)) + 
guides(fill = guide_legend(keywidth = 20, keyheight = 20)) + 
annotate("text",x=max(worldmap$long),y=-60,hjust=.9,size=6,
        label=paste("Flight routes from top 8 countries","Created by Weimin Wang","Data From OpenFlights.org", sep="\n"),color="white")

















