
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')



wdf <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Batch/Gpx/th3cr4g_Listen/Pause/")
setwd(wdf)

data <- data.table(read.csv("output.csv", sep=";", h=T))
data[, name := p0(name, " - ", grad)]

export.gpx(data, "Pause.gpx", add.desc = F, add.url = T)
