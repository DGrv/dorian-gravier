
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


wdf <- rP("file:///C:/Users/doria/Downloads/")
setwd(wdf)

data <- data.table(read.csv("ModernZeiten.csv", sep=";", h=T))
data

export.gpx(data, "ModernZeiten.gpx", add.desc = F, add.url = T)
