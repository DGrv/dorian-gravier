
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')


library(httr)
library(rvest)
library(tibble)
library(rgdal)
library(sf)
library(concaveman)

# data <- data.table(read.csv(rP("file:///C:/Users/doria/Downloads/test/test.csv"), sep = ",", encoding = "UTF-8", header = F))
# names(data) <-c("id", "lat", "lon", "rating", "type", "url", "name", "desc")
# data[, .N, type]
# 
# data <- data[type %like% "Daily parking only|Parking lot"]
# data[, url := p0("https://park4night.com/", url)]
# data[, desc := p0("ID: ", id, "\nType: ", type, "\nRating: ", rating, "\nDesc: ", desc)]
# 
# export.gpx(data[lon != ""], rP("file:///C:/Users/doria/Downloads/test/test.gpx"), add.desc = T, add.url = F)


wdcsv <- "file:///C:/Users/doria/Downloads/P4N/P4N_csv/"
title <- "Croatia_3"
rdata <- p0(dirname(rP(wdcsv)), "/", title, ".RData")




# if new run --------------------------------------------------------------

      data <- data.table()
      lcsv <- list.files(rP(wdcsv), full.names = T, pattern = "P4N")
      lcsv
      for (i in seq_along(lcsv)) {
        print(i)
        temp <- data.table(read.csv(rP(lcsv[i]), sep = ",", encoding = "UTF-8", header = F))
        temp[, file := lcsv[i]]
        data <- rbind(data, temp)
        data <- u(data)
      }
      # data <- data.table(read.csv(rP("file:///C:/Users/doria/Downloads/test/test.csv"), sep = ",", encoding = "UTF-8", header = F))
      names(data) <-c("id", "lat", "lon", "rating", "type", "url", "name", "desc", "file")
      data[, .N, type]
      
      data[, .(lon1=min(lon), lon2=max(lon), lat1=min(lat), lat2=max(lat)), file]
      
      
      save.image(rdata)
      
      
load(rdata)


type1 <- "Daily parking only|Parking lot"
type2 <- "Picnic|nature"

data[type %like% type1, What := "Parking"]
data[type %like% type2, What := "Nature"]

data <- data[is.na(What)==F]

data[, url := p0("https://park4night.com", url)]
data[, desc := p0("ID: ", id, "\nType: ", type, "\nRating: ", rating, "\nDesc: ", desc)]

data <- u(data)


country.list <- c("Croatia", "Hunga", "Serbia", "Montenegro", "Albania", "Bosnia", "Macedonia")
# country.list <- c("Croatia", "Slovenia", "Hunga", "Serbia", "Montenegro", "Albania", "Bosnia", "Macedonia", "Greece")
# country.list <- c("Croatia")
world <- data.table(map_data("world"))
setnames(world, "long", "lon")
world2 <- world[region %like% paste0(country.list, collapse = "|")]
world2[, .N, region]
ggplot()+
  geom_polygon(data=world2, aes(lon, lat, group = group), colour='black', fill=NA)+
  geom_point(data=data, aes(lon, lat))
  

data[, lon2 := lon]
data[, lat2 := lat]
world2[, lon2 := lon]
world2[, lat2 := lat]
datasf <- st_as_sf(data, coords = c("lon2","lat2")) # , crs = st_crs(4326)
datasf
world2sf <- concaveman(st_as_sf(world2, coords = c("lon2","lat2"))) # , crs = st_crs(4326) )
datasf2 <- st_filter(datasf, world2sf)
# datasf2 <- st_crop(world2sf, datasf)
ggplot()+
  geom_polygon(data=world2, aes(lon, lat, group = group), colour='black', fill=NA)+
  geom_point(data=datasf2, aes(lon, lat))
 


for(i in u(data[is.na(What)==F]$What)) {
  export.gpx(data.table(datasf2)[lon != "" & What == i], p0(dirname(rP(wdcsv)), "/P4N_", title, "_", i, ".gpx"), add.desc = T, add.url = T)
}
  

