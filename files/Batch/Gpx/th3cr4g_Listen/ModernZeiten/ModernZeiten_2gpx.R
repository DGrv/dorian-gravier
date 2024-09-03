
# setup
rootpath <- 'D:/BU_Work/Maxi_BU/20240812/Shared_Dorian/' 
Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'Dorian/BM_Function_v01.r), encoding='utf-8')



wdf <- rP("file:///C:/Users/doria/Downloads/")
setwd(wdf)

data <- data.table(read.csv("ModernZeiten.csv", sep=";", h=T))
data

export.gpx(data, "ModernZeiten.gpx", add.desc = F, add.url = T)
