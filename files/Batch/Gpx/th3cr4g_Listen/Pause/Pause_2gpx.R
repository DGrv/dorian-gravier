
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


wdf <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/Batch/Gpx/th3cr4g_Listen/Pause/")
setwd(wdf)

data <- data.table(read.csv("output.csv", sep=";", h=T))
data[, name := p0(name, " - ", grad)]

export.gpx(data, "Pause.gpx", add.desc = F, add.url = T)
