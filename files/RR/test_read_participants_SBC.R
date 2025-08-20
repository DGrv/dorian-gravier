
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))


url <- "https://api.raceresult.com/315977/4TV4B6CVD10OOGLG5KYUUWZ30GFO2PYA"

data <- data.table(jsonlite::fromJSON(url(url), flatten = TRUE))
setnames(data, names(data), c("Contest","Firstname","Lastname","Nation","UCI_ID", "Bib"))

data[Contest != 100][UCI_ID %in% data[Contest != 100][UCI_ID != "", .N, UCI_ID][N>1]$UCI_ID][order(UCI_ID, Contest)]

