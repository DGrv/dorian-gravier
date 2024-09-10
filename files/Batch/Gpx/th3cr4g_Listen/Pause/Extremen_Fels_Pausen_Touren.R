
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

data <- data.table(read.csv(rP("file:///C:/Users/doria/Downloads/Pause_touren.csv"), sep = ","))
data
data[, ID := gsub(".* (\\d*)$", "\\1", Tour)]
data[nchar(ID) > 3]
data[nchar(ID) > 3, ID := "?"]
data <- data[!is.na(lon)]
setnames(data, "Tour", "name")
data[, name := gsub("(.*) \\/.*", "\\1", name)]
data[, name := p0("# ", ID, " - ", name)]
data[, desc := p0(lt.Buch, "\n", Bewertung, "\nAbsich.: ", Absicherung)]

export.gpx(data, rP("file:///C:/Users/doria/Downloads/Pause_touren.gpx"), add.desc = F)
