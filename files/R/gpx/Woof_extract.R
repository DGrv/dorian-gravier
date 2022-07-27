library("stringi")
library("jsonlite")
# library("rjson")
library("data.table")
library(httr)
library(rgdal)

text <- content(GET("https://wwoof.fr/api/host-coordinates?searchTerm=&approvalStatus=approved&activities=&lodgings=&membershipStatus=active&isSuspended=false&isHidden=false&regionId=&capacity=1&childrenOk=false&petsOk=false&favoritesOnly=false&isNew=false&diets=&languages=&certifiedOrganic=false&type=&methodologies=&limit=5000"), as = "text", encoding = "UTF-8")
result <- fromJSON(text)
result

all <- as.data.table(result$features)
all[, lat := as.numeric(gsub("c\\(", "", gsub("(.*),(.*)", "\\1", geometry.coordinates)))]
all[, lon := as.numeric(gsub("\\)", "", gsub("(.*),(.*)", "\\2", geometry.coordinates)))]
all[, url := paste0("https://wwoof.fr/de/host/", properties.hostId)]
all
all <- all[(lat > -4.5 & lat < 10) & (lon < 51 & lon > 40 )]

all <- all[, .(name = properties.farmName, desc = properties.shortDescription, url, lat, lon)]

lschoice <- c("84", "6829", "11316", "9767", "10288", "1907", "10263", "7199", "92", "8096", "822", "5024", "4146", "6720", "13945", "7809", "3540", "5833", "5923", "7275", "7467", "7818")

all[grep(paste0("host/", lschoice, "$", collapse = "|"), url), choice := 1]
all[choice == 1]

all2 <- copy(all)
all2[, lat := NULL]
all2[, lon:= NULL]


# choice
    latslongs <- SpatialPointsDataFrame(coords=all[choice == 1, .(lat, lon)], data=all2[choice == 1], proj4string =CRS("+proj=longlat + ellps=WGS84")) 
    
    newfile <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/202206_Wwoof_France_choice.gpx"
    writeOGR(latslongs, dsn=newfile,
             dataset_options="GPX_USE_EXTENSIONS=yes",layer="waypoints",driver="GPX", overwrite_layer = T, )
    
    data <- data.table(x = readLines(newfile))
    data <- data[grep("extension", x, invert = T)]
    data[, x := gsub("ogr:url", "url", x)]
    data[, x := gsub(" \\<url", " <url", x)]
    data
    write.table(data$x, newfile, quote = F, row.names = F, col.names = F)

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
