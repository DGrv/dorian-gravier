
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')



library(rjson)
temp <- fromJSON(file="C:/Users/doria/Downloads/refugio.txt")
data <- data.table(row = 1:length(temp))
length(temp)

for(i in 1:length(temp)) {
  data[i, Name := temp[[i]]$name]
  data[i, ID := temp[[i]]$refugio_id]
  data[i, slug := temp[[i]]$slug]
  data[i, Description := temp[[i]]$description]
  data[i, lat := temp[[i]]$latitude]
  data[i, lon := temp[[i]]$longitude]
}
data[, url := p0("http://www.refugioslibres.com/index.php/refugio/", slug)]
data[,lon := as.numeric(lon)]
data[,lat := as.numeric(lat)]
data <- data[!lat > 75]

world <- data.table(map_data("world"))
world[region %like% "Spain"]
world2 <- world[region %like% "Spain"]

ggplot(data, aes(lon, lat))+ geom_point()+
  geom_polygon(data=world2, aes(long, lat, group = group), colour='black', fill=NA)
  

library(sp)
library(rgdal)

latslongs <- SpatialPointsDataFrame(coords=data[, .(lon, lat)], data=data[, .(Description, Name, url)], proj4string =CRS("+proj=longlat + ellps=WGS84")) 
newfile <- "C:/Users/doria/Downloads/Outdoor/Refugios/20230506_refugioslibre.gpx"
writeOGR(latslongs, dsn=newfile,
         dataset_options="GPX_USE_EXTENSIONS=yes",layer="waypoints",driver="GPX", overwrite_layer = T)
data2 <- data.table(x = readLines(newfile, encoding = "UTF8"))
data2[grep("extensions>", x)]
data2 <- data2[grep("extensions>", x, invert = T)]
data2[, x := gsub("ogr:url", "url", x)]
data2

data2[, x := gsub("  <url", "<url", x)]
write.table(data2$x, newfile, quote = F, row.names = F, col.names = F)

