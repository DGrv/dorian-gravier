

# setup
rm(list = ls())
rootpath <- "D:/BU_Work/Maxi_BU/20240812/Shared_Dorian/" 
Sys.setlocale("LC_ALL", "German")
source(paste0(rootpath, "Dorian/BM_Function_v01.r"), encoding="utf-8")

suppressWarnings(suppressMessages(library(leaflet)))
suppressWarnings(suppressMessages(library(leaflet.extras)))
suppressWarnings(suppressMessages(library(rayshaderanimate)))
suppressWarnings(suppressMessages(library(htmlwidgets)))
suppressWarnings(suppressMessages(library(RColorBrewer)))
suppressWarnings(suppressMessages(library(sf)))
suppressWarnings(suppressMessages(library(plotKML)))
# display.brewer.all()

wd <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Climbing/")
setwd(wd)

cat("\nwd = ", wd)




# read gpx ----------------------------------------------------------------

ll <- list.files(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Climbing"), pattern = "gpx$")
ll
data <- data.table()
for(i in seq_along(ll)) {
  temp <- data.table(readGPX(ll[i])$waypoints)
  temp[, file := ll[i]]
  data <- rbind(data, temp)
}
data[, desc := p0(name, '<br><a target=”_blank” href="', url, '">TheCrag link</a>')]

# check providers https://leaflet-extras.github.io/leaflet-providers/preview/
m <- leaflet() %>%
  addProviderTiles('OpenTopoMap')

# Add layers --------------------------------------------------------------

groupslayer <- gsub(".gpx", "", ll)
# data1 <- st_as_sf(x = data,                         
#                   coords = c("lon", "lat"))
for(i in seq_along(ll)) {
  m <- m %>%
      addCircleMarkers(data = data[file == ll[i]], lng = ~lon, lat = ~lat, 
                 group = groupslayer[i],
                 color = brewer.pal(n = length(ll), name = "Set1")[i],
                 opacity = 0.8,
                 radius = 5,
                 fillOpacity = 0.8,
                 popup = ~desc,
                 label = ~name) 
}
    
  



# output ------------------------------------------------------------------


m <-  m %>% 
  setView(11, 45,  zoom = 6) %>%
  addLayersControl(
    overlayGroups = groupslayer,
    options = layersControlOptions(collapsed=FALSE)) %>%
  addFullscreenControl() %>%
  addHash() %>%
  addSearchOSM() %>%
  addControlGPS()


# %>% 
      # hideGroup(groupslayer[3:length(groupslayer)]) #hide all groups except the 1st and 2nd )
cat("\nLeaflet ready")

saveWidget(m, file="Climbing.html")

cat("\nLeaflet DONE :)\n")

