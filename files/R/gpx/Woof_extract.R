library(jsonlite)
# library("rjson")
library(data.table)
library(httr)
library(rgdal)
library(ggmap)

export.gpx <- function(DATA, output) {
  
  latslongs <- SpatialPointsDataFrame(coords=DATA[, .(lon, lat)], data=DATA, proj4string =CRS("+proj=longlat + ellps=WGS84")) 
  
  writeOGR(latslongs, dsn=output,
           dataset_options="GPX_USE_EXTENSIONS=yes",layer="waypoints",driver="GPX", overwrite_layer = T, )
  
  data <- data.table(x = readLines(output))
  data <- data[grep("extension", x, invert = T)]
  data[, x := gsub("ogr:url", "url", x)]
  data[, x := gsub(" \\<url", " <url", x)]
  data
  write.table(data$x, output, quote = F, row.names = F, col.names = F)
  
}








# Get data ----------------------------------------------------------------

data <- data.table()
code <- c("fr", "es", "pt")
link <- c("https://wwoof.fr/api/host-coordinates?searchTerm=&approvalStatus=approved&activities=&lodgings=&membershipStatus=active&isSuspended=false&isHidden=false&regionId=&capacity=1&childrenOk=false&petsOk=false&favoritesOnly=false&isNew=false&diets=&languages=&certifiedOrganic=false&type=&methodologies=&limit=5000", "https://wwoof.es/api/host-coordinates?activities=&approvalStatus=approved&capacity=1&certifiedOrganic=false&childrenOk=false&diets=&favoritesOnly=false&isHidden=false&isNew=false&isSuspended=false&languages=&limit=5000&lodgings=&membershipStatus=active&methodologies=&petsOk=false&countryId=&regionId=&searchTerm=&type=", "https://wwoof.pt/api/host-coordinates?activities=&approvalStatus=approved&capacity=1&certifiedOrganic=false&childrenOk=false&diets=&favoritesOnly=false&isHidden=false&isNew=false&isSuspended=false&languages=&limit=5000&lodgings=&membershipStatus=active&methodologies=&petsOk=false&countryId=&regionId=&searchTerm=&type=")

for(i in seq_along(code)) {
  
  text <- content(GET(link[i]), as = "text", encoding = "UTF-8")
  result <- fromJSON(text)
  result2 <- as.data.table(result$features)[, Country := code[i]]
  data <- rbind(data, result2)
  
}

all <- copy(data)

# prepare -----------------------------------------------------------------



all[, lon := as.numeric(gsub("c\\(", "", gsub("(.*),(.*)", "\\1", geometry.coordinates)))]
all[, lat := as.numeric(gsub("\\)", "", gsub("(.*),(.*)", "\\2", geometry.coordinates)))]
all[Country == "fr", url := paste0("https://wwoof.fr/en/host/", properties.hostId)]
all[Country == "es", url := paste0("https://wwoof.es/en/host/", properties.hostId)]
all[Country == "pt", url := paste0("https://wwoof.pt/en/host/", properties.hostId)]
all

ggplot(all, aes(lon, lat))+geom_point()
all <- all[lat > 37]
all <- all[lon > -10]
ggplot(all, aes(lon, lat))+geom_point()



all <- all[, .(name = properties.farmName, desc = properties.shortDescription, url, lat, lon, Country)]

lschoice <- c("84", "6829", "11316", "9767", "10288", "1907", "10263", "7199", "92", "8096", "822", "5024", "4146", "6720", "13945", "7809", "3540", "5833", "5923", "7275", "7467", "7818", "7945", "3540", "967", "4353")

all[grep(paste0("host/", lschoice, "$", collapse = "|"), url), choice := 1]
all[choice == 1]

all2 <- copy(all)
all2[, lat := NULL]
all2[, lon := NULL]

all


# map ---------------------------------------------------------------------



world <- data.table(map_data("world"))
world
world[,.N, subregion]
world[region %like% "France|Spain|Portuga"]


ggplot(all, aes(lon, lat))+
  geom_map(data = world[region %like% "France|Spain|Portuga"], map = world, aes(long, lat, map_id = region), color = "white", fill = "lightgray", size = 0.1)+
  geom_point(aes(color=Country))



# Spatial -----------------------------------------------------------------




export.gpx(all[Country == "es"], "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/202211_Wwoof_Spain.gpx")
export.gpx(all[Country == "pt"], "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/202211_Wwoof_Portugal.gpx")





    
    

# 
# 
# # all 
#     latslongs <- SpatialPointsDataFrame(coords=all[, .(lat, lon)], data=all2, proj4string =CRS("+proj=longlat + ellps=WGS84")) 
#     
#     newfile <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/202206_Wwoof_France.gpx"
#     writeOGR(latslongs, dsn=newfile,
#              dataset_options="GPX_USE_EXTENSIONS=yes",layer="waypoints",driver="GPX", overwrite_layer = T, )
#     
#     data <- data.table(x = readLines(newfile))
#     data <- data[grep("extension", x, invert = T)]
#     data[, x := gsub("ogr:url", "url", x)]
#     data[, x := gsub(" \\<url", " <url", x)]
#     data
#     write.table(data$x, newfile, quote = F, row.names = F, col.names = F)
