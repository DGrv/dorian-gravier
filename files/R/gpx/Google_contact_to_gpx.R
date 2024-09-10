
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')



library(ggmap)
library(plotKML)
library(rgdal)


data <- data.table(read.csv(rP("file:///C:/Users/doria/Downloads/contacts.csv"), encoding = "UTF-8"))

data <- data[Address.1...Formatted != "", .(Name, Address.1...Formatted)]
data[, Address.1...Formatted := gsub("\n", " ", Address.1...Formatted)]
data


api <- readLines(rP("file:///C:/Users/doria/Downloads/Outdoor/ggmap_ap1_k3y.txt")) # Text file with the API key
register_google(key = api)


getOption("ggmap")

loc <- geocode(data$Address.1...Formatted)

data <- cbind(data, loc)
data <- data[!is.na(lon)]

data2 <- data[, .(lon, lat, name = Name)]


latslongs <- SpatialPointsDataFrame(coords=data2[, .(lon, lat)], data=data2[, .(name)], proj4string =CRS("+proj=longlat + ellps=WGS84")) 
newfile <- p0(rP("file:///C:/Users/doria/Downloads/"), gettimestamp(long=F), "_google_contacts.gpx")
newfile
writeOGR(latslongs, dsn=newfile,
         dataset_options="GPX_USE_EXTENSIONS=yes",layer="waypoints",driver="GPX", overwrite_layer = T)
data <- data.table(x = readLines(newfile, encoding = "UTF8"))
data[grep("extensions>", x)]
data <- data[grep("extensions>", x, invert = T)]
data[, x := gsub("ogr:url", "url", x)]
data
data[, x := gsub("  <url", "<url", x)]
write.table(data$x, newfile, quote = F, row.names = F, col.names = F)




