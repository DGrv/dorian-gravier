

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
suppressWarnings(suppressMessages(library(geosphere)))
suppressWarnings(suppressMessages(library(svglite)))  # To save as SVG
suppressWarnings(suppressMessages(library(ggrepel)))


args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250822__Matterhorn_Ultraks/BU/rr_backup_Matterhorn_Ultraks_20250812-130226/")
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
  wd <- gsub("\\\\", "/", wd)
}
cat(yellow("\n[INFO] - wd:   ", wd, "\n"))
setwd(wd)








# TimingPoints ------------------------------------------------------------------

tp <- data.table(read.csv("timingpoints.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
tp[, Position := gsub(" ", "", Position)]
tp[, lat := as.numeric(gsub("(.*),(.*)", "\\1", Position))]
tp[, lon := as.numeric(gsub("(.*),(.*)", "\\2", Position))]
tp[, Position := NULL]
if( length(tp$Color) == 0 ) { tp[, Color := ""] }
setnames(tp, "Color", "ColorTP")
tp <- tp[, .(Name, ColorTP, lat, lon)]
tp <- tp[Name != ""]
setnames(tp, "Name", "TimingPoint")
tp <- tp[!is.na(lon)]
tp[, url:= p0("https://www.google.com/maps/place/", lat, ",", lon)]
tp[, label := p0(TimingPoint, '<br><a href="', url, '" target="_blank">GoogleMap</a>' )]

tp[, icon := ifelse(grepl("start|finish|ziel", TimingPoint, ignore.case = T), "iconFinish", "iconUbi")]
tp[, TimingPointUTF8 := TimingPoint] 
tp[, TimingPoint := stri_trans_general(TimingPoint, "de-ASCII")] # replace the german umlaut
# tp

export.gpx2(tp[, .(name = TimingPoint, lat, lon)], "gpx/TimingPoints.gpx", add.desc = F, add.url = F)



# tp rules ----------------------------------------------------------------

if( file.exists("timingpointrules.csv")) {
  
  if( file.info("timingpointrules.csv")$size > 0 ) {
    
    tpr <- data.table(read.csv("timingpointrules.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
    
    if( nrow(tpr) > 0 ) {
      tpr <- tpr[, .(TimingPoint, LoopID, ChannelID)]
      tpr[, labelrules := p0(" - C", ChannelID, "/L", LoopID)]
      tpr2 <- tpr[, .(labelrules = paste(labelrules, collapse = "")), by = TimingPoint]
      tpr2[, labelrules := p0(TimingPoint, labelrules)]
      
      tp <- dtjoin(tp, tpr2)
      tprloc <- dtjoin(tpr, tp[, .(TimingPoint, lon, lat)])
    }
  }
}



# Contest -----------------------------------------------------------------

contest <- data.table(read.csv("Contests.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
setnames(contest, grepcol("Name", contest), p0("Contest", grepcol("Name", contest)))

contest <- contest[ContestName != ""]
contest[, Length := ifelse(LengthUnit=="m", Length/1000, Length)/10000]
contest[, ContestNameShort := ifelse(is.na(ContestNameShort), ContestName, ContestNameShort)]
contest[, Start := hms::as_hms(Start/10000)]
contest[, Dist := p0(round(Length, 2), "km")]
setnames(contest, "ID", "Contest")

# get color contest
contest[, ColorHEX := gsub(".*\\#(.{6}).*", "#\\1", Attributes)]
contest[, ColorCID := hex2rgba(ColorHEX, 0.8)]

# splits ------------------------------------------------------------------

if( file.exists("splits.csv") ) {
  
  if( file.info("splits.csv")$size > 0 ) {
    
    splits <- data.table(read.csv("splits.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
    splits <- splits[, .(Contest, Name, TimingPoint, Distance, OrderPos, Label)]
    splits[, TimingPoint := stri_trans_general(TimingPoint, "de-ASCII")] # replace the german umlaut
    splits <- splits[TimingPoint != ""]
    setnames(splits, c("Name", "Label"), c("SplitName", "Split"))
    
    cd <- dtjoin(contest[, .(Contest, ContestName)], splits)
    cd[, Split := gsub(",", ".", Split)]
    cd[, Split := gsub(" km", "km", Split)]
    cd[, Split := gsub(" ca. ", " - ", Split)]
    cd[, dist := Distance / 1000 / 10000]
    
    cd[cd[, .I[dist==max(dist)], ContestName]$V1] # Wichtig should feet the Contest.Length
    
    cd <- cd[!grep("start|finish|spotter", SplitName, ignore.case = T)]
    cd[cd[, .I[dist==max(dist)], ContestName]$V1]
    cd[, .N, .(ContestName)]
    
  }
}




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
suppressWarnings(suppressMessages(ll[, ColorTrack := brewer.pal(n = nrow(ll), name = "Set1")[1:nrow(ll)]]))
ll[, Contest := as.numeric(gsub("(\\d*)__.*", "\\1", file))]

ll <- dtjoin(ll, contest[, .(Contest, Start, Dist, ContestName, Length, ColorCID)])

ll[, Name := p0(Contest, "__", Start, "--", Dist, "__", ContestName)]
ll[, ncharName := nchar(Name)]
tt <- max(ll$ncharName)
ll[, Name := ifelse(Name == "NA__NA--NA__NA", gsub(".gpx", "", file), Name)]
ll[, Name := gsub("--", paste0(rep("_", (tt-ncharName+2)), collapse = ""), Name), Name]


# SVG
ll[, breaksx := ifelse(Length >= 40, 10, ifelse(Length < 5, 1, 5))]
ll[, nylabel := 1000]
ll[, nxlabel := ifelse(Length >= 80, -5, ifelse(Length >= 40, -2, -1))]
ll


# read gpx

data <- data.table()
for (i in seq_along(ll$filepath)) {
  dt <- read.gpx(ll$filepath[i], type="trk")
  setnames(dt, "name", "GpxName")
  dt[, file := ll$file[i]]
  dt[, ContestName := ll$ContestName[i]]
  
  #svg
  # Calculate dist btw points
  dt[, dist:=0]
  dt[2:nrow(dt), dist := distHaversine(dt[,.(lon, lat)])/1000]
  dt[, dist := cumsum(dist)]
  
  cat(yellow("[INFO] - dist gpx="), red(round(max(dt$dist), 2)), yellow("dist.wanted="), blue(ll$Length[i]), "\n")
  
  # correction distance if gpx is longer than expected
  if( !is.na(ll$Length[i]) ) {
    cat(red("[INFO] - Make dist ratio correction with dist.wanted"))
    ratio.correction <- max(dt$dist)/ll$Length[i]
    dt[, dist := dist/ratio.correction]
  }
  
  # trim ele
  if( exists("ylim1") ) {
    dt[1, ele := ylim1]
    dt[nrow(dt), ele := ylim1]
  } else {
    dt[1, ele := 0]
    dt[nrow(dt), ele := 0]
  }
  
  # bind
  data <- rbind(data, dt, fill = T)
  cat("\n", i, "- Read done:", ll$file[i])
}


data[data[, .I[dist==max(dist)], ContestName]$V1]


# svg again 


if( file.exists("splits.csv") ) {
  
  if( file.info("splits.csv")$size > 0 ) {
    
    suppressWarnings(data[, Split := NULL])
    data[, Split := ""]
    # assign them depending on dist
    temp <- copy(data)
    rm(data)
    data <- data.table()
    
    for(j in seq_along(ll$ContestName)) {
      if( length(u(cd$ContestName)) == 1 ) {
        cd2 <- copy(cd)
        temp2 <- copy(temp)
      } else {
        cd2 <- cd[ContestName == ll$ContestName[j]]
        temp2 <- temp[ContestName == ll$ContestName[j]]
      }
      for(i in 1:nrow(cd2)) {
        t <- which.min(abs(temp2$dist - cd2$dist[i]))
        temp2[t, Split := cd2$Split[i]]
      }
      data <- rbind(data, temp2)
    }
    
    data[Split != "", .N, .(ContestName, Split)]
  }   
}




source(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/Track_for_LED_v03.R"))

source(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/Leaflet-MapCreate_v02.R"))

source(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/SVGCreate_v01.R"))

 
