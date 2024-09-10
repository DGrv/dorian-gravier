
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

wd <- rP("file:///C:/Users/doria/Downloads/Outdoor/Topo/Filidor_plaisir/")

# login -------------------------------------------------------------------

url <- "https://main-apis-prd.mapme.com/api/stories/aggregated/edition-filidor?pub=131&build=7c3d6fb"
session <-  session(url)
# form <- html_form(session)[[2]]
# fl_fm <- html_form_set(form,
#                        "D:Login" = "les4kins",
#                        "D:Password" = "&h7kuv&3yxXP4e*3")
# main_page <- session_submit(session, fl_fm)
main_page <- session_jump_to(session, url)



# area and tiles ----------------------------------------------------------

world <- data.table(map_data("world"))
country.list <- c("Switzerland")
world2 <- world[region %like% p0(country.list, collapse = "|")]

# size.tile <- 0.4



# Loop --------------------------------------------------------------------

yes <- stringi::stri_encode(main_page$response$content)
yes <- rawToChar(main_page$response$content)
t0 <- jsonlite::fromJSON(yes, flatten = FALSE)
t0
d <- data.table(enframe(unlist(t0)))
d


data <- data.table()
for( i in seq_along(t0$mapmeStories$sections) ) {
  temp <- data.table(name = t0$mapmeStories$sections[[i]]$name,
                     desc = t0$mapmeStories$sections[[i]]$description,
                     lat = t0$mapmeStories$sections[[i]]$mapView$center$lat,
                     lon = t0$mapmeStories$sections[[i]]$mapView$center$lng,
                     url2 = t0$mapmeStories$sections[[i]]$callToAction$url)
  data <- rbind(data, temp)
}
data[, url := gsub('.*destination=(.*?)target=.*', "https://www.google.com/maps/place/\\1", desc)]
data
data[, url := gsub('\\"| ', "", url)]
data[, url := gsub("\\'", "", url)]
data

data[, desc := gsub("<a .*</a>", "", desc)]
data[, desc := gsub("<b>.*</b>|<p>|</p>", "", desc)]
data[, desc := gsub("â€“", "to", desc)]
data

data





a <- ggplot(data, aes(lon, lat))+ geom_point()+
  geom_polygon(data=world2, aes(long, lat, group = group), colour='black', fill=NA)+
  labs(title = "Filidor")
a
printfast(a, p0(wd, "Map_Filidor.jpg"), ext = ".jpg",
          width = 600, height = 400)







  latslongs <- SpatialPointsDataFrame(coords=data[, .(lon, lat)], data=data[, .(name, desc, url, url2)], proj4string =CRS("+proj=longlat + ellps=WGS84")) 
  
  newfile <- p0(wd, "ALL_filidor.gpx")
  
  writeOGR(latslongs, dsn=newfile,
           dataset_options="GPX_USE_EXTENSIONS=yes",layer="waypoints",driver="GPX", overwrite_layer = T)
  data2 <- data.table(x = readLines(newfile, encoding = "UTF8"))
  data2[grep("extensions>", x)]
  data2 <- data2[grep("extensions>", x, invert = T)]
  data2[, x := gsub("ogr:url", "url", x)]
  data2[, x := gsub("ogr:url2", "url", x)]
  data2
  
  data2[, x := gsub("  <url", "<url", x)]
  data2[, x := gsub("url2", "url", x)]
  data2
  write.table(data2$x, newfile, quote = F, row.names = F, col.names = F)
  
