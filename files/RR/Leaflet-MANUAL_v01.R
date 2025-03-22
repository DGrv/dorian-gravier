

# setup
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))

suppressWarnings(suppressMessages(library(leaflet)))
suppressWarnings(suppressMessages(library(leaflet.extras)))
# suppressWarnings(suppressMessages(library(rayshaderanimate)))
suppressWarnings(suppressMessages(library(htmlwidgets)))
suppressWarnings(suppressMessages(library(RColorBrewer)))
# display.brewer.all()
suppressWarnings(suppressMessages(library(sf)))
suppressWarnings(suppressMessages(library(sp)))
suppressWarnings(suppressMessages(library(lubridate)))
suppressWarnings(suppressMessages(library(xml2)))
suppressWarnings(suppressMessages(library(gpx)))
suppressWarnings(suppressMessages(library(geosphere)))
# suppressWarnings(suppressMessages(library(rgdal)))


args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/2025______SwissBikeCup/STAGES/#1_Tamaro/gpx/")
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
}
cat(yellow("\n[INFO] - wd:   ", wd, "\n"))
setwd(wd)



# TimingPoints ------------------------------------------------------------

tp.input <- "TimingPoints.gpx"

tp <- read.gpx(tp.input, type="wpt")
setnames(tp, "name", "TimingPoint")
tp[, label := TimingPoint]
tp[, icon := ifelse(grepl("start|finish|ziel", TimingPoint, ignore.case = T), "iconFinish", "iconUbi")]
tp


# read gpx ----------------------------------------------------------------

ll <- data.table(filepath=Sys.glob("*"))
ll <- ll[!filepath %like% tp.input][filepath %like% "gpx$"]

if(nrow(ll)==0){
  cat(red("\nFound", nrow(ll), "gpx :(\n"))
} else {
  cat(green("\nFound", nrow(ll), "gpx :)\n"))
}

ll[, file := basename(filepath)]
ll <- ll[!filepath %like% "ContestID_|All_Splits"]





# colorb <- brewer.pal(n = nrow(ll)+1, name = "Set1")
# colorb <- colorb[colorb != "#4DAF4A"]
colorb <- "#1956fc"

ll[, color := colorb]
# ll[, Contest := as.numeric(gsub("(\\d*)__.*", "\\1", file))]

# ll <- dtjoin(ll, contest[, .(Contest, Start, Dist, Name)])
# ll[, Name := p0(Contest, "__", Start, "__", Dist, "__", Name)]
ll[, Name := gsub(".gpx", "", file)]


data0 <- data.table()
for (i in seq_along(ll$filepath)) {
  temp <- read.gpx(ll$filepath[i], type="trk")
  temp[, file := ll$file[i]]
  temp[, dist:=0]
  temp[2:nrow(temp), dist := distHaversine(temp[,.(lon, lat)])/1000]
  temp[, dist := cumsum(dist)]
  data0 <- rbind(data0, temp, fill = T)
  cat("\n", i, "- Read done:", ll$file[i])
}

ll <- dtjoin(ll, data0[data0[, .I[dist==max(dist, na.rm = T)], file]$V1])
ll[, dist := round(dist, 2)]

ll[, Name := p0(name, "__", dist, "__", Name)]



# temp tamaro 
# temp tamaro 
# temp tamaro 
# temp tamaro 
# temp tamaro 

ll
ll <- ll[3]


source(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/Leaflet-MapCreate_v01.R"))

 
