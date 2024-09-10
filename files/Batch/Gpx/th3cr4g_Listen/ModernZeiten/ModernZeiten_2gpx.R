
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')



wdf <- rP("file:///C:/Users/doria/Downloads/")
setwd(wdf)

data <- data.table(read.csv("ModernZeiten.csv", sep=";", h=T))
data

export.gpx(data, "ModernZeiten.gpx", add.desc = F, add.url = T)
