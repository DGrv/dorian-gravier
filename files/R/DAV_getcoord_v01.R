#Loading the rvest package
library(rvest)
library(data.table)
library(rgdal)
library(ggmap)

#Specifying the url for desired website to be scraped
url <- 'https://www.alpsonline.org/reservation/calendar?hut_id='

listhu <- data.table()
for(i in 1:300) { 
  #Reading the HTML code from the website
  webpage <- read_html(paste0(url, i))
  
  #Using CSS selectors to scrap the rankings section
  rank_data_html <- html_nodes(webpage,'span')
  #Converting the ranking data to text
  rank_data <- html_text(rank_data_html)

  temp <- data.table(ID = i,
                     Name = html_text(html_nodes(webpage,'h4')),
                     coord = rank_data[6])
  listhu <- rbind(listhu, temp)
  cat(i, "\n")
}


listhubu <- copy(listhu)


listhu[, link := paste0(url, ID)]
listhu[, coord := gsub("Koordinaten:\n", "", coord)]
listhu[, coord := gsub("Coordinates:\n", "", coord)]
listhu[, coord := gsub(" *", "", coord)]
listhu <- listhu[coord != "XXX.XXX/YYY.YYY"][coord != ""]
listhu[, Name := gsub("'", "", Name)]
listhu[, Name := gsub("ü", "ue", Name)]
listhu[, Name := gsub("Ü", "Ue", Name)]
listhu[, Name := gsub("ä", "ae", Name)]
listhu[, Name := gsub("Ä", "Ae", Name)]
listhu[, Name := gsub("ö", "oe", Name)]
listhu[, Name := gsub("Ö", "Oe", Name)]
listhu[, Name := gsub("ò", "o", Name)]
listhu[, Name := gsub("é", "e", Name)]
listhu[, Name := gsub("ß", "ss", Name)]




    # # https://console.cloud.google.com/google/maps-apis/overview?consoleReturnUrl=https:%2F%2Fcloud.google.com%2Fmaps-platform%2F%3Fapis%3Dmaps,routes,places%26project%3Dgithubpage-1551297032481&consoleUI=CLOUD&project=githubpage-1551297032481
    # key<-""
    # register_google(key = key)
    # 
    # listhu2 <- mutate_geocode(listhu, Name)

#listhu2 <- data.table(left_join(listhu, listhu2))

p <- ggmap(get_map("Konstanz", zoom=7))
p + geom_point(data=listhu2, aes(x=lon, y=lat))

wd <- "D:/DG-Papers/GitHub/Website/dorian.gravier.github.io/files/R"
setwd(wd)
write.csv(listhu2, "DAV_hutte_coord.csv", row.names = F)


jsvar.start <- c("var DAVhutten = [")
jsvar.end <- c("];")

listhu2BU <- copy(listhu2)
# listhu2 <- copy(listhu2BU)



listhu2[1:(nrow(listhu2) - 1), js := paste0("['", Name, "',", lon, ",", lat, ",'", link, "'],")]
listhu2[nrow(listhu2), js := paste0("['", Name, "',", lon, ",", lat, ",'", link, "']")]

jsvar <- c(jsvar.start, listhu2$js, jsvar.end)

leaf <- readLines(paste0(dirname(dirname(wd)), "/leaflet.md"))
leaf1 <- leaf[1:grep("// VARIABLE DAVHUTTEN START", leaf)]
leaf2 <- leaf[grep("// VARIABLE DAVHUTTEN END", leaf):length(leaf)]

leafnew <- c(leaf1, jsvar, leaf2)
writeLines(leafnew, paste0(dirname(dirname(wd)), "/leaflet.md"))





