# icons -------------------------------------------------------------------

if(exists("splits") ) {
  offsetlabel <- c(0, 0)
  iconAnchor <- 0
} else {
  offsetlabel <- c(0,0)
  iconAnchor <- 0
}


rrIcons <- iconList(
  iconUbi = makeIcon(
    iconUrl = "https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/RR/Images/Ubidium.png",
    iconWidth = 36,
    iconHeight = 36
    # iconAnchorY does not seem to work 
    # iconAnchorY does not seem to work 
    # iconAnchorY does not seem to work 
    # iconAnchorY does not seem to work 
  ),
  iconFinish = makeIcon(
    iconUrl = "https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/RR/Images/Finish.png",
    iconWidth = 36,
    iconHeight = 36
  )
)



# providers ---------------------------------------------------------------

mapGroups <- c(
               "SwissTopo BW", 
  "SwissTopo", 
               "SwissTopo Sat",
               "OpenTopoMap",
               "Esri.WorldImagery",
               "CartoDBPositron",
               "CartoDBDarkMatter",
               "CartoDBVoyager")


# check providers https://leaflet-extras.github.io/leaflet-providers/preview/
#https://www.jeffreyschmid.com/posts/2022-01-01-different-basemaps-in-leaflet-r/
m <- leaflet() %>%
  # addProviderTiles('OpenTopoMap')
  # addProviderTiles('OpenTopoMap', options = providerTileOptions(maxZoom = 20),
  #                  group = "OpenTopoMap") %>%
  # addTiles(urlTemplate = "https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg",
  #          attribution = '&copy; <a href="https://www.geo.admin.ch/de/about-swiss-geoportal/impressum.html#copyright">swisstopo</a>',
  #          group = "SwissTopo", options = providerTileOptions(maxZoom = 20)) %>%
  # addTiles(urlTemplate = "https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.swissimage/default/current/3857/{z}/{x}/{y}.jpeg",
  #          attribution = '&copy; <a href="https://www.geo.admin.ch/de/about-swiss-geoportal/impressum.html#copyright">swisstopo</a>',
  #          group = "SwissTopo Sat", options = providerTileOptions(maxZoom = 20)) %>%
  addProviderTiles( group = mapGroups[1], options = providerTileOptions(maxZoom = 20), "SwissFederalGeoportal.NationalMapGrey") %>%
  addProviderTiles( group = mapGroups[2], options = providerTileOptions(maxZoom = 20), "SwissFederalGeoportal.NationalMapColor") %>%
  addProviderTiles( group = mapGroups[3], options = providerTileOptions(maxZoom = 20), "SwissFederalGeoportal.SWISSIMAGE") %>%
  addProviderTiles( group = mapGroups[4], options = providerTileOptions(maxZoom = 20), "OpenTopoMap") %>%
  addProviderTiles( group = mapGroups[5], options = providerTileOptions(maxZoom = 20), "Esri.WorldImagery") %>%
  addProviderTiles( group = mapGroups[6], options = providerTileOptions(maxZoom = 20), "CartoDB.PositronNoLabels")%>%
  addProviderTiles( group = mapGroups[7], options = providerTileOptions(maxZoom = 20), "CartoDB.DarkMatterNoLabels") %>%
  addProviderTiles( group = mapGroups[8], options = providerTileOptions(maxZoom = 20), "CartoDB.VoyagerNoLabels")

m <- m %>% 
  onRender("
    function(el, x) {
      var map = this;
      map.options.zoomSnap = 0.5;
      map.options.zoomDelta = 0.5;
    }
  ")


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
                 group = ll$Name[i],
                 color = ll$color[i],
                 opacity = 1,
                 weight = 4)
  if( exists("splits") ) {
    tp2 <- tp[TimingPoint %in% splits[Contest == ll$Contest[i]]$TimingPoint]
    
    if( nrow(tp2) > 0 ) {
      m <- m %>%
        addCircleMarkers(data = tp2, lng = ~lon, lat = ~lat, 
                         group = ll$Name[i],
                         color = ll$color[i],
                         opacity = 1,
                         radius = 15,
                         fillOpacity = 0.8) 
      
    }
  } 
  
}



# output ------------------------------------------------------------------

groupslayer <- c("Labels", "TimingPoints", ll$Name)

m <-  m %>% 
  addLayersControl(
    baseGroups = mapGroups, 
    overlayGroups = groupslayer,
    options = layersControlOptions(collapsed=TRUE)) %>%
  addMarkers(data = tp, lng = ~lon, lat = ~lat, popup = ~label,
             group = "TimingPoints",
             icon = ~rrIcons[tp$icon]
             ) %>%
  # addLabelOnlyMarkers(data = tp,
  #   ~lon, ~lat, label = ~TimingPoint, 
  #   labelOptions = labelOptions(noHide = TRUE, direction = "top"),
  #   group = "Labels"
  # ) %>%
  
  # # used before tamaro
  # fitBounds(
  #   lng1 = min(data0$lon), lat1 = min(data0$lat),
  #   lng2 = max(data0$lon), lat2 = max(data0$lat)
  # )
  setView((max(data0$lon)-min(data0$lon))/2+min(data0$lon),
                    (max(data0$lat)-min(data0$lat))/2+min(data0$lat),
                    zoom = 17.5)
  
  
  # addAwesomeMarkers(data = tp,
  #                   icon=awesomeIcons(
  #                     icon = "caret-forward-circle-outline",
  #                     iconColor = 'black',
  #                     library = 'ion',
  #                     markerColor = "green"),
  #                   lng = ~lon, lat = ~lat, popup = ~label, label = ~TimingPoint, group = "TimingPoints", labelOptions = labelOptions(noHide = TRUE)) %>%
  # addMarkers(data = tp, lng = ~lon, lat = ~lat, popup = ~label,
  #            label = ~TimingPoint, group = "TimingPoints",
  #            icon = ~rrIcons["ubi"],
  #            labelOptions = labelOptions(noHide = TRUE, offset = offsetlabel)) %>%  
# old - used then fitbounds
# setView((max(data0$lon)-min(data0$lon))/2+min(data0$lon),
#                   (max(data0$lat)-min(data0$lat))/2+min(data0$lat), 
#                   zoom = 17) %>%


# to hide layers
# to hide layers
# to hide layers
# to hide layers
# %>% 
# hideGroup(groupslayer[3:length(groupslayer)]) #hide all groups except the 1st and 2nd )


m <-  m %>%  addFullscreenControl() %>%
  addHash() %>%
  addSearchOSM() %>%
  # addDrawToolbar() %>%
  # addStyleEditor() %>%
  addControlGPS()


cat(green("\n\nLeaflet ready"))

saveWidget(m, file="OverviewMap.html")

cat(green("\nLeaflet DONE :)\n"))