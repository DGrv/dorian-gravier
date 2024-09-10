

# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')

wd <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/skate")
setwd(wd)


system("curl -o list.txt https://skatemap.de/xml/xml_skateparks_live.php")
library(rvest)
library(xml2)
url <- "https://skatemap.de/xml/xml_skateparks_live.php"
url %>% read_xml(as_html=T) 
test <- url %>% read_xml(as_html=T) %>% xml_nodes("marker") 
test %>% xml_attr("lat")
data <- data.table(lat = as.numeric(xml_attr(test,"lat")), 
                   lon = as.numeric(xml_attr(test,"lng")),
                   desc=xml_attr(test,"text"),
                   id = xml_attr(test,"id"),
                   name = xml_attr(test,"titel"))
data[, url := p0("https://skatemap.de/#", id)]

data[lat == ""]
data[lon == ""]
data[is.na(lat)==T]
data[is.na(lon)==T]

# data <- data[is.na(lon)==T]


export.gpx(data, "Skatemap.gpx", add.desc = T, add.url = T)
export.gpx(data, "Skatemap_morris.gpx", add.desc = F, add.url = T)
