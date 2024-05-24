

# setup
rm(list = ls())
if( paste0(Sys.info()[4]) == 'DESKTOP-MG495PG' ) {
  rootpath <- 'C:/Users/doria/Dropbox/Shared_Dorian/'
  suppressWarnings(suppressMessages(Sys.setlocale('LC_ALL', 'German')))
} else {
  if( paste0(Sys.info()[4]) == 'DORIANSRECHNER' ) {
    rootpath <- 'C:/Users/dorian.BSPM/Dropbox/Shared_Dorian/'
  } else {
    rootpath <- 'C:/Users/buero.BSPM/Dropbox/Shared_Dorian/'
  }
}
suppressWarnings(suppressMessages(source(paste0(rootpath, "Dorian/BM_Function_v01.r"), encoding="utf-8")))

suppressWarnings(suppressMessages(library(leaflet)))
suppressWarnings(suppressMessages(library(leaflet.extras)))
suppressWarnings(suppressMessages(library(rayshaderanimate)))
suppressWarnings(suppressMessages(library(htmlwidgets)))
suppressWarnings(suppressMessages(library(RColorBrewer)))
suppressWarnings(suppressMessages(library(sf)))
# display.brewer.all()


args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/Drive/RR/20240421__Zurick_Marathon/BU/backup_OCHSNER_SPORT_Zurich_Marathon_2024830_20240422-002750/")
} else{
  wd <- gsub("/mnt", "C:/", args[1])
}
setwd(wd)

cat("\nwd = ", wd)



# Splits ------------------------------------------------------------------

tp <- data.table(read.csv("timingpoints.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
tp[, Position := gsub(" ", "", Position)]
tp[, lat := as.numeric(gsub("(.*),(.*)", "\\1", Position))]
tp[, lon := as.numeric(gsub("(.*),(.*)", "\\2", Position))]
tp[, Position := NULL]
tp <- tp[, .(Name, Color, lat, lon)]
tp <- tp[Name != ""]
setnames(tp, "Name", "TimingPoint")
tp <- tp[!is.na(lon)]



# splits ------------------------------------------------------------------

splits <- data.table(read.csv("splits.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
splits <- splits[, .(Contest, Name, TimingPoint, Distance, OrderPos)]
splits <- splits[TimingPoint != ""]


# read gpx ----------------------------------------------------------------

ll <- data.table(filepath=list.files.only(p0(wd, "gpx")))
ll[, file := basename(filepath)]
ll <- ll[!filepath %like% "ContestID_|All_Splits"][file %like% "gpx$"]
ll[, color := brewer.pal(n = nrow(ll), name = "Set1")]
ll[, Contest := gsub("(\\d*)__.*", "\\1", file)]

data0 <- data.table()
for (i in seq_along(ll$filepath)) {
  temp <- data.table(get_table_from_gpx(ll$filepath[i]))
  # temp <- data.table(readGPX(ll[i])$tracks[[1]][[1]])
  temp[, file := ll$file[i]]
  data0 <- rbind(data0, temp, fill = T)
  cat("\n", i, "- Read done:", ll$file[i])
}


# check providers https://leaflet-extras.github.io/leaflet-providers/preview/
m <- leaflet() %>%
  addProviderTiles('OpenTopoMap')





# Add layers --------------------------------------------------------------


for (i in seq_along(ll$filepath)) {
  data1 <- st_as_sf(x = data0[file == ll$file[i]],                         
                    coords = c("lon", "lat"))
  data2 <- data1 %>%
    st_combine() %>%
    st_cast(to = "LINESTRING") %>%
    st_sf()
  
  
  m <- m %>%
    addPolylines(data = data2,
                 group = gsub(".gpx", "", ll$file[i]),
                 color = ll$color[i],
                 opacity = 0.8)
  tp2 <- tp[TimingPoint %in% splits[Contest == ll$Contest[i]]$TimingPoint]
  
  if( nrow(tp2) > 0 ) {
    m <- m %>%
      addCircleMarkers(data = tp2, lng = ~lon, lat = ~lat, 
                 group = gsub(".gpx", "", ll$file[i]),
                 color = ll$color[i],
                 opacity = 0.8,
                 radius = 15,
                 fillOpacity = 0.8) 
      
  }
  
}



# output ------------------------------------------------------------------

groupslayer <- c("Splits", gsub(".gpx", "", ll$file))

m <-  m %>% 
  addMarkers(data = tp, lng = ~lon, lat = ~lat, popup = ~TimingPoint, label = ~TimingPoint, group = "Splits") %>% 
  setView((max(data0$lon)-min(data0$lon))/2+min(data0$lon),
                    (max(data0$lat)-min(data0$lat))/2+min(data0$lat), 
                    zoom = 12) %>%
  addLayersControl(
    overlayGroups = groupslayer,
    options = layersControlOptions(collapsed=FALSE)) %>% 
      hideGroup(groupslayer[3:length(groupslayer)]) #hide all groups except the 1st and 2nd )
m <-  m %>%  addFullscreenControl() %>%
  addHash() %>%
  addSearchOSM() %>%
  addDrawToolbar() %>%
  addStyleEditor() 


cat("\nLeaflet ready")

saveWidget(m, file="OverviewMap.html")

cat("\nLeaflet DONE :)\n")

