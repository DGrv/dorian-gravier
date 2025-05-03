

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
# suppressWarnings(suppressMessages(library(rgdal)))


args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/BU/rr_backup_Innsbruck_Alpine_Trailrun_Festival_2025_20250429-224212/")
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
}
cat(yellow("\n[INFO] - wd:   ", wd, "\n"))
setwd(wd)








# TimingPoints ------------------------------------------------------------------

tp <- data.table(read.csv("timingpoints.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
tp[, Position := gsub(" ", "", Position)]
tp[, lat := as.numeric(gsub("(.*),(.*)", "\\1", Position))]
tp[, lon := as.numeric(gsub("(.*),(.*)", "\\2", Position))]
tp[, Position := NULL]
tp <- tp[, .(Name, Color, lat, lon)]
tp <- tp[Name != ""]
setnames(tp, "Name", "TimingPoint")
tp <- tp[!is.na(lon)]
tp[, url:= p0("https://www.google.com/maps/place/", lat, ",", lon)]
tp[, label := p0(TimingPoint, '<br><a href="', url, '" target="_blank">GoogleMap</a>' )]

tp[, icon := ifelse(grepl("start|finish|ziel", TimingPoint, ignore.case = T), "iconFinish", "iconUbi")]

# tp


export.gpx2(tp[, .(name = TimingPoint, lat, lon)], "gpx/TimingPoints.gpx", add.desc = F, add.url = F)



# splits ------------------------------------------------------------------

splits <- data.table(read.csv("splits.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
splits <- splits[, .(Contest, Name, TimingPoint, Distance, OrderPos)]
splits <- splits[TimingPoint != ""]



# Contest -----------------------------------------------------------------

contest <- data.table(read.csv("Contests.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
contest
contest <- contest[Name != ""]
contest[, Name := ifelse(is.na(NameShort), Name, NameShort)]
contest[, Start := hms::as_hms(Start)]
contest[, Dist := round(Length, 2)]
setnames(contest, "ID", "Contest")

# read gpx ----------------------------------------------------------------

ll <- data.table(filepath=Sys.glob(p0(wd, "/gpx/*")))
ll <- ll[!filepath %like% "TimingPoints.gpx"][filepath %like% "gpx$"]

if(nrow(ll)==0){
  cat(red("\nFound", nrow(ll), "gpx :(\n"))
} else {
  cat(green("\nFound", nrow(ll), "gpx :)\n"))
}

ll[, file := basename(filepath)]
ll <- ll[!filepath %like% "ContestID_|All_Splits"]
suppressWarnings(suppressMessages(ll[, color := brewer.pal(n = nrow(ll), name = "Set1")[1:nrow(ll)]]))
ll[, Contest := as.numeric(gsub("(\\d*)__.*", "\\1", file))]

ll <- dtjoin(ll, contest[, .(Contest, Start, Dist, Name)])
ll[, Name := p0(Contest, "__", Start, "__", Dist, "__", Name)]


data0 <- data.table()
for (i in seq_along(ll$filepath)) {
  temp <- read.gpx(ll$filepath[i], type="trk")
  temp[, file := ll$file[i]]
  temp[, Name := ll$Name[i]]
  data0 <- rbind(data0, temp, fill = T)
  cat("\n", i, "- Read done:", ll$file[i])
}




source(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/Leaflet-MapCreate_v01.R"))

 
