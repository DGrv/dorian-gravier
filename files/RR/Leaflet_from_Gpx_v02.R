

# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')

suppressWarnings(suppressMessages(library(leaflet)))
suppressWarnings(suppressMessages(library(leaflet.extras)))
suppressWarnings(suppressMessages(library(rayshaderanimate)))
suppressWarnings(suppressMessages(library(htmlwidgets)))
suppressWarnings(suppressMessages(library(RColorBrewer)))
# display.brewer.all()
suppressWarnings(suppressMessages(library(sf)))
suppressWarnings(suppressMessages(library(lubridate)))
suppressWarnings(suppressMessages(library(plotKML)))
suppressWarnings(suppressMessages(library(httr2)))
suppressWarnings(suppressMessages(library(beepr)))


args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/Drive/RR/20240316__SwissBikeCup/08_Lenzerheide/gpx/")
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
}
cat(yellow("\n[INFO] - wd:   ", wd, "\n"))
setwd(wd)

source(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/Devices_API_v01.R"))




# Splits ------------------------------------------------------------------

# tp <- data.table(read.csv("timingpoints.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
# tp[, Position := gsub(" ", "", Position)]
# tp[, lat := as.numeric(gsub("(.*),(.*)", "\\1", Position))]
# tp[, lon := as.numeric(gsub("(.*),(.*)", "\\2", Position))]
# tp[, Position := NULL]
# tp <- tp[, .(Name, Color, lat, lon)]
# tp <- tp[Name != ""]
# setnames(tp, "Name", "TimingPoint")
# tp <- tp[!is.na(lon)]
# 
# export.gpx(tp, "gpx/TimingPoints.gpx", add.desc = F, add.url = F)


tp <- data.table(readGPX(rP("file:///C:/Users/doria/Downloads/Drive/RR/20240316__SwissBikeCup/08_Lenzerheide/gpx/TimingPoints.gpx"))$waypoints)
setnames(tp, "name", "TimingPoint")



# splits ------------------------------------------------------------------

# splits <- data.table(read.csv("splits.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
# splits <- splits[, .(Contest, Name, TimingPoint, Distance, OrderPos)]
# splits <- splits[TimingPoint != ""]



# Contest -----------------------------------------------------------------

# contest <- data.table(read.csv("Contests.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
# contest <- contest[ContestName != ""]
# contest[, Name := ifelse(is.na(ContestNameShort), ContestName, ContestNameShort)]
# contest[, Start := seconds_to_period(ContestStart)]
# contest[, Start := sprintf('%02d:%02d:%02d', Start@hour, minute(Start), second(Start))]
# contest[, Dist := round(ContestLength, 2)]
# setnames(contest, "ID", "Contest")

# read gpx ----------------------------------------------------------------

ll <- data.table(filepath=list.files.only(wd))
ll[, file := basename(filepath)]
ll <- ll[!filepath %like% "ContestID_|All_Splits"][file %like% "gpx$"]
ll <- ll[!filepath %like% "TimingPoints.gpx"]

if(nrow(ll)==0){
  cat(red("\nFound", nrow(ll), "gpx :(\n"))
} else {
  cat(green("\nFound", nrow(ll), "gpx :)\n"))
}

ll[, color := rep(brewer.pal(n = nrow(ll), name = "Set1"), times = 5)[1:nrow(ll)]]
# ll[, Contest := as.numeric(gsub("(\\d*)__.*", "\\1", file))]

# colorDF(contest)
# colorDF(splits)
# colorDF(tp)
# colorDF(ll)

# ll <- dtjoin(ll, contest[, .(Contest, Start, Dist, Name)])
# ll[, Name := p0(Contest, "__", Start, "__", Dist, "__", Name)]
ll[, Name := gsub(".gpx", "", file)]
ll

data0 <- data.table()
for (i in seq_along(ll$filepath)) {
  temp <- data.table(get_table_from_gpx(ll$filepath[i]))
  # temp <- data.table(readGPX(ll[i])$tracks[[1]][[1]])
  temp[, Name := ll$Name[i]]
  data0 <- rbind(data0, temp, fill = T)
  cat("\n", i, "- Read done:", ll$file[i])
}






# check providers https://leaflet-extras.github.io/leaflet-providers/preview/
m <- leaflet() %>%
  addProviderTiles('OpenTopoMap', options = providerTileOptions(maxZoom = 19),
                   group = "OpenTopoMap") %>%
  addTiles(urlTemplate = "https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg",
           attribution = '&copy; <a href="https://www.geo.admin.ch/de/about-swiss-geoportal/impressum.html#copyright">swisstopo</a>',
           group = "SwissTopo") %>%
  addTiles(urlTemplate = "https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.swissimage/default/current/3857/{z}/{x}/{y}.jpeg",
           attribution = '&copy; <a href="https://www.geo.admin.ch/de/about-swiss-geoportal/impressum.html#copyright">swisstopo</a>',
           group = "SwissTopo Sat")




# Add layers --------------------------------------------------------------


for (i in seq_along(ll$filepath)) {
  data1 <- st_as_sf(x = data0[Name == ll$Name[i]],                         
                    coords = c("lon", "lat"))
  data2 <- data1 %>%
    st_combine() %>%
    st_cast(to = "LINESTRING") %>%
    st_sf()
  
  
  m <- m %>%
    addPolylines(data = data2,
                 group = ll$Name[i],
                 color = ll$color[i],
                 opacity = 0.8)
  
  # tp2 <- tp[TimingPoint %in% splits[Contest == ll$Contest[i]]$TimingPoint]
  
  # if( nrow(tp2) > 0 ) {
  #   m <- m %>%
  #     addCircleMarkers(data = tp2, lng = ~lon, lat = ~lat, 
  #                group = ll$Name[i],
  #                color = ll$color[i],
  #                opacity = 0.8,
  #                radius = 15,
  #                fillOpacity = 0.8) 
  #     
  # }
  
}



# output ------------------------------------------------------------------

groupslayer <- c("TimingPoints", "DevicesOnline", "DevicesOffline", ll$Name)

m <-  m %>%
  addMarkers(data = tp, lng = ~lon, lat = ~lat, popup = ~TimingPoint, label = ~TimingPoint, group = "TimingPoints") %>%
  addMarkers(data = RRdevices[Connected == T], lng = ~lon, lat = ~lat, popup = ~DeviceID, label = ~DeviceID, group = "DevicesOnline",
             icon= icons(iconUrl ="https://github.com/DGrv/dorian-gravier/blob/master/files/RR/Images/loc_green_small.png?raw=true",
                         iconAnchorX=51, iconAnchorY=101)) %>%
  addMarkers(data = RRdevices[Connected == F], lng = ~lon, lat = ~lat, popup = ~DeviceID, label = ~DeviceID, group = "DevicesOnline",
             icon= icons(iconUrl = "https://github.com/DGrv/dorian-gravier/blob/master/files/RR/Images/loc_red_small.png?raw=true",
                         iconAnchorX=51, iconAnchorY=101)) %>%
  setView((max(data0$lon)-min(data0$lon))/2+min(data0$lon),
                    (max(data0$lat)-min(data0$lat))/2+min(data0$lat), 
                    zoom = 12) %>%
  addLayersControl(
    baseGroups = c("OpenTopoMap", "SwissTopo", "SwissTopo Sat"), 
    overlayGroups = groupslayer,
    options = layersControlOptions(collapsed=FALSE)) %>% 
      hideGroup(groupslayer[c(2,3,5:length(groupslayer))]) #hide all groups except the 1st and 2nd )




# for( i in 1:length(RRdevices$DeviceID)) {
#   if( RRdevices$Connected[i] ){
#     m <-  m %>% 
#       addAwesomeMarkers(data = RRdevices[DeviceID == RRdevices$DeviceID[i]],
#                         icon=awesomeIcons(
#                           icon = RRdevices$icon[i],
#                           iconColor = 'black',
#                           library = 'ion',
#                           markerColor = RRdevices$color[i]),
#                         lng = ~lon, lat = ~lat, popup = ~popup, label = ~DeviceID, group = "DevicesOnline")
#   } else {
#     m <-  m %>% 
#       addAwesomeMarkers(data = RRdevices[DeviceID == RRdevices$DeviceID[i]],
#                         icon=awesomeIcons(
#                           icon = RRdevices$icon[i],
#                           iconColor = 'black',
#                           library = 'ion',
#                           markerColor = RRdevices$color[i]),
#                         lng = ~lon, lat = ~lat, popup = ~popup, label = ~DeviceID, group = "DevicesOffline")
#   }
# }





m <-  m %>%  addFullscreenControl() %>%
  addHash() %>%
  addSearchOSM() %>%
  addDrawToolbar() %>%
  addStyleEditor() %>%
  addControlGPS()


cat(green("\n\nLeaflet ready"))

saveWidget(m, file="OverviewMap_fromGPX.html")

cat(green("\nLeaflet DONE :)\n"))

