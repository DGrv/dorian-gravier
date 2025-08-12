# icons -------------------------------------------------------------------

setwd(wd)

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
               "SwissTopo", 
               "SwissTopo BW", 
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
  addProviderTiles( group = mapGroups[1], options = providerTileOptions(maxZoom = 20), "SwissFederalGeoportal.NationalMapColor") %>%
  addProviderTiles( group = mapGroups[2], options = providerTileOptions(maxZoom = 20), "SwissFederalGeoportal.NationalMapGrey") %>%
  addProviderTiles( group = mapGroups[3], options = providerTileOptions(maxZoom = 20), "SwissFederalGeoportal.SWISSIMAGE") %>%
  addProviderTiles( group = mapGroups[4], options = providerTileOptions(maxZoom = 20), "OpenTopoMap") %>%
  addProviderTiles( group = mapGroups[5], options = providerTileOptions(maxZoom = 20), "Esri.WorldImagery") %>%
  addProviderTiles( group = mapGroups[6], options = providerTileOptions(maxZoom = 20), "CartoDB.PositronNoLabels")%>%
  addProviderTiles( group = mapGroups[7], options = providerTileOptions(maxZoom = 20), "CartoDB.DarkMatterNoLabels") %>%
  addProviderTiles( group = mapGroups[8], options = providerTileOptions(maxZoom = 20), "CartoDB.VoyagerNoLabels")
  # addWMSTiles(
  #   "http://ows.mundialis.de/services/service?",
  #   layers = "SRTM30-Hillshade",
  #   options = WMSTileOptions(opacity = 0.5),
  #   group = mapGroups[9]
  # )
  # addWMSTiles(
  #   baseUrl = "https://tiles.arcgis.com/tiles/oPre3pOfRfefL8y0/arcgis/rest/services/WTM_Hillshade/MapServer/WMTS/1.0.0/WMTSCapabilities.xml",
  #   layers = "WTM_Hillshade",
  #   # options = WMSTileOptions(opacity = 0.5),
  #   group = mapGroups[9]
  # )
  # addTiles(
  #   urlTemplate = "https://wmts.geo.admin.ch/1.0.0/hillshade/default/current/3857/{z}/{x}/{y}.jpeg",
  #   options = tileOptions(opacity = 0.5),
  #   group = mapGroups[9]
  # )


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
  
  data1 <- st_as_sf(x = data[file == ll$file[i]],                         
                    coords = c("lon", "lat"))
  data2 <- data1 %>%
    st_combine() %>%
    st_cast(to = "LINESTRING") %>%
    st_sf()
  
  
  m <- m %>%
    addPolylines(data = data2,
                 group = ll$Name[i],
                 color = ll$ColorTrack[i],
                 opacity = 1,
                 weight = 4)
  
  if( exists("splits") ) {
    tp2 <- tp[TimingPoint %in% splits[Contest == ll$Contest[i]]$TimingPoint]
    splits2 <- splits[Contest == ll$Contest[i], .(SplitName, TimingPoint)]
    splits3 <- splits2[, .(SplitName = paste(SplitName, collapse = ", ")), TimingPoint]
    tp2 <- dtjoin(tp2, splits3)
    

    if( nrow(tp2) > 0 ) {
      m <- m %>%
        addCircleMarkers(data = tp2, lng = ~lon, lat = ~lat,
                         group = ll$Name[i],
                         color = ll$ColorTrack[i],
                          popup = ~SplitName,
                         popupOptions = popupOptions(autoClose = TRUE, offset=c(0, -30)),
                         opacity = 1,
                         radius = 30,
                         fillOpacity = 0.8)

    }
  }

}



# output ------------------------------------------------------------------

if( exists("tpr") ) {
  if( nrow(tpr) > 0 ) {
    groupslayer <- c("Labels", "TimingPoints", "Loop/Channel IDs", ll$Name)
  } else  {
    groupslayer <- c("Labels", "TimingPoints", ll$tName)
  }
} else {
    groupslayer <- c("Labels", "TimingPoints", ll$Name)
}




m <-  m %>% 
  addLayersControl(
    baseGroups = mapGroups, 
    overlayGroups = groupslayer,
    options = layersControlOptions(collapsed=TRUE)) 




if( nrow(tp) > 0 ) {
  m <- addMarkers(map = m, data = tp, lng = ~lon, lat = ~lat, popup = ~label,
             group = "TimingPoints",
             icon = ~rrIcons[tp$icon]
             ) %>%
  addLabelOnlyMarkers(data = tp,
                      ~lon, ~lat, label = ~TimingPointUTF8,
                      labelOptions = labelOptions(noHide = TRUE, 
                                                  direction = "right",
                                                  offset = c(32, 0)),
                      group = "Labels"
  )
} 
  
  # # used before tamaro
  # fitBounds(
  #   lng1 = min(data$lon), lat1 = min(data$lat),
  #   lng2 = max(data$lon), lat2 = max(data$lat)
  # )
  if( nrow(data)>0) {
    m <- setView(map=m, lng=(max(data$lon)-min(data$lon))/2+min(data$lon),
                    lat=(max(data$lat)-min(data$lat))/2+min(data$lat),
                    zoom = 11, options = )
    
  } else {
    m <- setView(map=m, lng=46.7615,
            lat=8.4601,
            zoom = 8)
  }
  
if( exists("tpr") ) {
  if( nrow(tpr) > 0 ) {
  
    m <- m %>%
      addCircleMarkers(data = tp[is.na(labelrules) == F & labelrules %like% "L1"], lng = ~lon, lat = ~lat, 
                       group = "Loop/Channel IDs",
                       color = "#000000",
                       opacity = 1,
                       radius = 15,
                       fillOpacity = 0.8,
                       label = ~labelrules) %>%
      addCircleMarkers(data = tp[is.na(labelrules) == F & !labelrules %like% "L1"], lng = ~lon, lat = ~lat, 
                       group = "Loop/Channel IDs",
                       color = "#000000",
                       opacity = 1,
                       radius = 10,
                       fillOpacity = 0.5,
                       label = ~labelrules)
    
    lCHloop1 <- tpr[LoopID==1]$ChannelID
    
    for( i in lCHloop1) {
      
      temp <- tprloc[ChannelID == lCHloop1[i]]
      
      l1 <- temp[LoopID == 1]
      l0 <- temp[LoopID != 1]
      
      for( j in 1:nrow(l0))  {
        toplot <- rbind(l1, l0[j])
        m <- m %>%
          addPolylines(lat = toplot$lat,
                       lng = toplot$lon,
                       group = "Loop/Channel IDs",
                       color = "#000000",
                       opacity = 1,
                       weight = 4)
      }
    }
  }
}



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
# setView((max(data$lon)-min(data$lon))/2+min(data$lon),
#                   (max(data$lat)-min(data$lat))/2+min(data$lat), 
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
  addControlGPS() %>%
  hideGroup("Loop/Channel IDs") %>%
  addMeasure(
    primaryLengthUnit = "kilometers",   # or "meters", "miles", etc.
    secondaryLengthUnit = "meters",
    position = "topleft"
  )



cat(green("\n\nLeaflet ready"))

saveWidget(m, file="OverviewMap.html")

t <- readLines("OverviewMap.html")
idwidget <- gsub('<script type\\="application/htmlwidget-sizing" data-for\\="(.*)">\\{"viewer".*', "\\1", t[length(t)-2])

# change meta that is good phones 
# t[t %like% "<meta"]
t <- gsub(t[t %like% "<meta"], '<meta charset="utf-8" />\n<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />', t)


# Mouse position ---------------------------------------------------------


tadd <- readLines(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/Javascript/Copy_MousePosition_v01.html"))
tadd <- gsub("\\#idwidget", p0("#", idwidget), tadd)
t <- c(t[1:(length(t)-2)], tadd, t[(length(t)-1):length(t)])
write.table(t, "OverviewMap.html", row.names = F, col.names = F, quote = F)



# Tracking ----------------------------------------------------------------

t <- readLines("OverviewMap.html")
 
# idwidget <- gsub('<script type\\="application/htmlwidget-sizing" data-for\\="(.*)">\\{"viewer".*', "\\1", t[length(t)-2])

tadd <- readLines(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/Javascript/TrackingBox_CLEAN_v02.html"))
tadd <- gsub("\\#idwidget", p0("#", idwidget), tadd)

t <- c(t[1:(length(t)-2)], tadd, t[(length(t)-1):length(t)])

write.table(t, "OverviewMap_Tracking.html", row.names = F, col.names = F, quote = F)

cat(green("\nLeaflet DONE :)\n"))




