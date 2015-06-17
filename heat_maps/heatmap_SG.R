library(ggplot2)
library(ggmap)

rm(list = ls())
setwd('c:\\SG Map')

zoom = 11
point_size = 2.0

private_sale<-read.csv2('hot_deal.csv',sep=",", stringsAsFactors = F)
private_sale$lat = as.numeric(private_sale$lat)
private_sale$lon = as.numeric(private_sale$lon)

sg_map = get_map(location='Singapore', maptype = 'roadmap', zoom = 11)

ggmap(sg_map, extent = "device") + 
  
geom_density2d(data = hdb_rent,
               aes(x = lon, y = lat), size = 0.01) + stat_density2d(data = hdb_rent, 
                                                                    aes(x = lon, y = lat, fill = ..level.., alpha = ..level..), size = 0.03, 
                                                                    bins = 16, geom = "polygon") + scale_fill_gradient(low = "green", high = "red", 
                                                                                                                       guide = FALSE) + scale_alpha(range = c(0, 0.8), guide = FALSE) + geom_point(data = hdb_rent, 
                                                                                                                                                                                                   pch=20,
                                                                                                                                                                                                   aes(x = lon, y = lat),
                                                                                                                                                                                                   colour = I('blue'), size = 3)


















