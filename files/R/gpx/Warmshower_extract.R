library("stringi")
library("jsonlite")
# library("rjson")
library("data.table")
library(httr)
library(rgdal)


# go on warmshower let load several part of the map and devtools network search for "by_location", use copy append and copy response of all of this in a text file

# text <- content(GET("https://www.warmshowers.org/services/rest2/hosts/by_location"), as = "text", encoding = "UTF-8")
text <- readLines("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/by_location-copy_responde.txt")
all <- data.table()
for(i in 1:length(text)) {
  result <- fromJSON(text[i])
  all <- rbind(all, as.data.table(result$accounts))
}

# all <- as.data.table(result$accounts)
# all[, lat := as.numeric(gsub("c\\(", "", gsub("(.*),(.*)", "\\1", position)))]
# all[, lon := as.numeric(gsub("\\)", "", gsub("(.*),(.*)", "\\2", position)))]
all
# all <- all[(lat > -4.5 & lat < 10) & (lon < 51 & lon > 40 )]

all <- all[, .(name = fullname, desc = paste0(street , ", ", city, ", ", postal_code), url = paste0("https://www.warmshowers.org/user/", uid), lat = as.numeric(longitude), lon = as.numeric(latitude))]
all <- unique(all)
# lschoice <- c("84", "6829", "11316", "9767", "10288", "1907", "10263", "7199")

# all[grep(paste0("host/", lschoice, "$", collapse = "|"), url), choice := 1]
# all[choice == 1]

all2 <- copy(all)
all2[, lat := NULL]
all2[, lon := NULL]


# choice
    latslongs <- SpatialPointsDataFrame(coords=all[, .(lat, lon)], data=all2, proj4string =CRS("+proj=longlat + ellps=WGS84")) 
    
    newfile <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/202206_Warmshower.gpx"
    writeOGR(latslongs, dsn=newfile,
             dataset_options="GPX_USE_EXTENSIONS=yes",layer="waypoints",driver="GPX", overwrite_layer = T, )
    
    data <- data.table(x = readLines(newfile))
    data <- data[grep("extension", x, invert = T)]
    data[, x := gsub("ogr:url", "url", x)]
    data[, x := gsub(" \\<url", " <url", x)]
    data
    write.table(data$x, newfile, quote = F, row.names = F, col.names = F)

