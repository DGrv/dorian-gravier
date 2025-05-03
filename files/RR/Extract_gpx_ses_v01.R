# setup
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))

args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/BU/rr_backup_Innsbruck_Alpine_Trailrun_Festival_2025_20250429-224212/")
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
}
cat(yellow("\n[INFO] - wd:   ", wd, "\n"))
setwd(wd)

data <- data.table(raw=readLines("gpx/gpxallinfo"))

gpx.name <- data[raw %like% "GPXFileName"]
gpx <- data[!raw %like% "GPXFileName"]

gpx.name[, Contest := gsub("\\d*\tGPXFileName\t\\d*\t(\\d*)\t(.*)\t\\d*", "\\1", raw)]
gpx.name[, Filename := p0(Contest, "__", gsub("\\d*\tGPXFileName\t\\d*\t(\\d*)\t(.*)\t\\d*", "\\2", raw))]
# gpx.name

gpx[, Contest := gsub("\\d*\tGPXFile\t\\d*\t(\\d*)\t(.*)", "\\1", raw)]
gpx[, gpx := gsub("\\d*\tGPXFile\t\\d*\t(\\d*)\t(.*)", "\\2", raw)]

end <- dtjoin(gpx[, .(Contest, gpx)], gpx.name[, .(Contest, Filename)])

for(i in 1:nrow(end)) {
  writeLines(end$gpx[i], p0(wd, "/gpx/", end$Filename[i]))
}

