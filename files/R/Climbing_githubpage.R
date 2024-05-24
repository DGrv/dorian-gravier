

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
suppressWarnings(suppressMessages(library(rayshaderanimate)))
suppressWarnings(suppressMessages(library(htmlwidgets)))
suppressWarnings(suppressMessages(library(RColorBrewer)))
suppressWarnings(suppressMessages(library(sf)))
suppressWarnings(suppressMessages(library(plotKML)))
# display.brewer.all()

wd <- rP("file:///C:/Users/doria/Downloads/")
setwd(wd)

cat("\nwd = ", wd)




# read gpx ----------------------------------------------------------------

pausefile <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Climbing/Pause.gpx")
data <- data.table(readGPX(pausefile)$waypoints)
data[, desc := p0(name, '<br><a target=”_blank” href="', url, '">TheCrag link</a>')]

# check providers https://leaflet-extras.github.io/leaflet-providers/preview/
m <- leaflet() %>%
  addProviderTiles('OpenTopoMap')

# Add layers --------------------------------------------------------------


# data1 <- st_as_sf(x = data,                         
#                   coords = c("lon", "lat"))
m <- m %>%
    addCircleMarkers(data = data, lng = ~lon, lat = ~lat, 
               group = "Pause Touren",
               color = "red",
               opacity = 0.8,
               radius = 5,
               fillOpacity = 0.8,
               popup = ~desc,
               label = ~name) 
    
  



# output ------------------------------------------------------------------

groupslayer <- "Pause Touren"

m <-  m %>% 
  setView(11, 45,  zoom = 6) %>%
  addLayersControl(
    overlayGroups = groupslayer,
    options = layersControlOptions(collapsed=FALSE)) 
# %>% 
      # hideGroup(groupslayer[3:length(groupslayer)]) #hide all groups except the 1st and 2nd )
cat("\nLeaflet ready")

saveWidget(m, file="Pause_Touren.html")

cat("\nLeaflet DONE :)\n")

