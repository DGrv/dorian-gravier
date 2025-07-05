

# setup
rm(list = ls())
rootpath <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/" 
Sys.setlocale("LC_ALL", "German")
source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")


suppressWarnings(suppressMessages(library(leaflet)))
suppressWarnings(suppressMessages(library(leaflet.extras)))
# suppressWarnings(suppressMessages(library(rayshaderanimate)))
suppressWarnings(suppressMessages(library(htmlwidgets)))
suppressWarnings(suppressMessages(library(RColorBrewer)))
suppressWarnings(suppressMessages(library(sf)))
suppressWarnings(suppressMessages(library(gpx)))
suppressWarnings(suppressMessages(library(xml2)))
# display.brewer.all()

wd <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Bike_trip_2022/")
wdout <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/html_output/")
setwd(wd)

cat("\nwd = ", wd)




# read gpx ----------------------------------------------------------------

ll <- data.table(path = list.files(wd, pattern = "gpx$", full = T, recursive = T))
ll2 <- data.table(path = list.files(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Leaflet/"), pattern = "gpx$", full = T, recursive = T))
ll <- rbind(ll, ll2)
ll[, file := basename(path)]
ll[, What := basename(dirname(path))]

ll[, colorID := .GRP, What]
ll[, .N, colorID]
ll[, color := brewer.pal(n = length(u(ll$colorID)), name = "Set1")[colorID]]
ll[, .N, .(colorID, color)]

# ll[, desc := p0(file, '<br><a target=”_blank” href="https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/gpx/', What, "/", file, ' download>Download</a>')]
ll <- ll[!What %like% "time|Project|Stop"]
ll[, .N, What]
ll[What == "Bike_trip_2022", What := "Bike"]

data <- data.table()
for (i in seq_along(ll$path)) {
  cat(i, "- Try:", ll$file[i])
  temp <- read.gpx(ll$path[i], type="trk")
  temp[, file := ll$file[i]]
  temp[, What := ll$What[i]]
  data <- rbind(data, temp, fill = T)
  cat(green(" - Read done\n"))
}
dataBU <- copy(data)

# # Old
# data <- data.table()
# for(i in seq_along(ll)) {
#   temp <- read.gpx(ll[i], type="wpt")
#   data <- rbind(data, temp)
# }
# brewer.pal(n = 2, name = "Set1")




mapGroups <- c(
  "CyclOSM", 
  "OpenTopoMap",
  "SwissTopo", 
  "SwissTopo Sat",
  "Esri.WorldImagery",
  "CartoDBPositron",
  "CartoDBDarkMatter",
  "CartoDBVoyager",
  "OPNVKarte")
# check providers https://leaflet-extras.github.io/leaflet-providers/preview/
m <- leaflet() %>%
  addProviderTiles( group = mapGroups[1], options = providerTileOptions(maxZoom = 20), "CyclOSM") %>%
  addProviderTiles( group = mapGroups[2], options = providerTileOptions(maxZoom = 20), "OpenTopoMap") %>%
  addProviderTiles( group = mapGroups[3], options = providerTileOptions(maxZoom = 20), "SwissFederalGeoportal.NationalMapColor") %>%
  addProviderTiles( group = mapGroups[4], options = providerTileOptions(maxZoom = 20), "SwissFederalGeoportal.SWISSIMAGE") %>%
  addProviderTiles( group = mapGroups[5], options = providerTileOptions(maxZoom = 20), "Esri.WorldImagery") %>%
  addProviderTiles( group = mapGroups[6], options = providerTileOptions(maxZoom = 20), "CartoDB.PositronNoLabels")%>%
  addProviderTiles( group = mapGroups[7], options = providerTileOptions(maxZoom = 20), "CartoDB.DarkMatterNoLabels") %>%
  addProviderTiles( group = mapGroups[8], options = providerTileOptions(maxZoom = 20), "CartoDB.VoyagerNoLabels") %>%
  addProviderTiles( group = mapGroups[9], options = providerTileOptions(maxZoom = 20), "OPNVKarte")


m <- m %>% 
  onRender("
    function(el, x) {
      var map = this;
      map.options.zoomSnap = 0.5;
      map.options.zoomDelta = 0.5;
    }
  ")

# Add layers --------------------------------------------------------------

groupLayers <- c(u(ll$What), "Huts")


u(data$name)
for(i in seq_along(u(data$name)) ) {
  
  data1 <- st_as_sf(x = data[name == u(data$name)[i]],                         
                    coords = c("lon", "lat"))
  data2 <- data1 %>%
    st_combine() %>%
    st_cast(to = "LINESTRING") %>%
    st_sf()
  
  ll2 <- ll[file == data[name == u(data$name)[i]]$file[1]]
  
  m <- m %>%
    addPolylines(data = data2,
                 group = ll2$What,
                 color = ll2$color,
                 popup = ~desc,
                 opacity=1,
                 weight=6
                 # label = ~name
                 )
}

# icon/hutte.png
hutte <- data.table(read.csv(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/DAV_hutte_coord.csv")))
hutte[, popup := p0(Name, '<br><a href="', link, '">Infos</a>')]
hutte


m <- m %>%
  addCircleMarkers(data = hutte, lng = ~lon, lat = ~lat,
                   group = "Huts",
                   color = "#ff3355",
                   popup = ~popup,
                   popupOptions = popupOptions(autoClose = TRUE, offset=c(0, -10)),
                   opacity = 1,
                   radius = 4,
                   fillOpacity = 0.5)


# output ------------------------------------------------------------------

m <- setView(map=m, lng=(max(data$lon)-min(data$lon))/2+min(data$lon),
             lat=(max(data$lat)-min(data$lat))/2+min(data$lat),
             zoom = 5, options = )

m <-  m %>% 
  # setView(11, 45,  zoom = 6) %>%
  addLayersControl(
    baseGroups = mapGroups, 
    overlayGroups = groupLayers,
    options = layersControlOptions(collapsed=FALSE)) %>%
  addFullscreenControl() %>%
  addHash() %>%
  addSearchOSM() %>%
  addControlGPS() %>%
  hideGroup("Huts")


# %>% 
      # hideGroup(groupslayer[3:length(groupslayer)]) #hide all groups except the 1st and 2nd )
cat("\nLeaflet ready")

setwd(wdout)
saveWidget(m, file="Leaflet.html")

cat("\nLeaflet DONE :)\n")

