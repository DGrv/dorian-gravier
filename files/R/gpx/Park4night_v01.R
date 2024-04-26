
# setup
rm(list = ls())
if( paste0(Sys.info()[4]) == 'DESKTOP-MG495PG' ) {
  rootpath <- 'C:/Users/doria/Dropbox/Shared_Dorian/'
  Sys.setlocale('LC_ALL', 'German')
} else {
  if( paste0(Sys.info()[4]) == 'DORIANSRECHNER' ) {
    rootpath <- 'C:/Users/dorian.BSPM/Dropbox/Shared_Dorian/'
  } else {
    rootpath <- 'C:/Users/buero.BSPM/Dropbox/Shared_Dorian/'
  }
}
source(paste0(rootpath, "Dorian/BM_Function_v01.r"), encoding="utf-8")

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



data <- data.table()
lcsv <- list.files(rP("file:///C:/Users/doria/Downloads/test/P4N_csv/"), full.names = T, pattern = "P4N")
lcsv
for (i in seq_along(lcsv)) {
  temp <- data.table(read.csv(rP(lcsv[i]), sep = ",", encoding = "UTF-8", header = F))
  data <- rbind(data, temp)
}
# data <- data.table(read.csv(rP("file:///C:/Users/doria/Downloads/test/test.csv"), sep = ",", encoding = "UTF-8", header = F))
names(data) <-c("id", "lat", "lon", "rating", "type", "url", "name", "desc")
data[, .N, type]

data <- data[type %like% "Daily parking only|Parking lot"]
data[, url := p0("https://park4night.com", url)]
data[, desc := p0("ID: ", id, "\nType: ", type, "\nRating: ", rating, "\nDesc: ", desc)]

data <- u(data)

export.gpx(data[lon != ""], rP("file:///C:/Users/doria/Downloads/test/P4N.gpx"), add.desc = T, add.url = T)


