
mapGroups <- c(
  "CyclOSM", 
  "OpenTopoMap",
  "SwissTopo", 
  "SwissTopo Sat",
  "Esri.WorldImagery",
  "CartoDBPositron",
  "CartoDBDarkMatter",
  "CartoDBVoyager",
  "MtbMap",
  "OPNVKarte")
# check providers https://leaflet-extras.github.io/leaflet-providers/preview/
m <- leaflet() %>%
  addProviderTiles( group = mapGroups[1], options = providerTileOptions(maxZoom = 20, tileSize= 512, zoomOffset=-1), "CyclOSM") %>% # tileSize= 256 * 2, zoomOffset=-1 is zoom the map to have nore readble label, tileSize= 512 should @2x / retina tiles
  addProviderTiles( group = mapGroups[2], options = providerTileOptions(maxZoom = 20, tileSize= 512, zoomOffset=-1), "OpenTopoMap") %>%# tileSize= 256 * 2, zoomOffset=-1 is zoom the map to have nore readble label, tileSize= 512 should @2x / retina tiles
  addProviderTiles( group = mapGroups[3], options = providerTileOptions(maxZoom = 20), "SwissFederalGeoportal.NationalMapColor") %>%
  addProviderTiles( group = mapGroups[4], options = providerTileOptions(maxZoom = 20), "SwissFederalGeoportal.SWISSIMAGE") %>%
  addProviderTiles( group = mapGroups[5], options = providerTileOptions(maxZoom = 20), "Esri.WorldImagery") %>%
  addProviderTiles( group = mapGroups[6], options = providerTileOptions(maxZoom = 20), "CartoDB.PositronNoLabels")%>%
  addProviderTiles( group = mapGroups[7], options = providerTileOptions(maxZoom = 20), "CartoDB.DarkMatterNoLabels") %>%
  addProviderTiles( group = mapGroups[8], options = providerTileOptions(maxZoom = 20), "CartoDB.VoyagerNoLabels")  %>%
  addProviderTiles( group = mapGroups[9], options = providerTileOptions(maxZoom = 20), "MtbMap")  %>%
  addProviderTiles( group = mapGroups[10], options = providerTileOptions(maxZoom = 20, tileSize= 512, zoomOffset=-1), "OPNVKarte") # tileSize= 256 * 2, zoomOffset=-1 is zoom the map to have nore readble label, tileSize= 512 should @2x / retina tiles

  # addProviderTiles( group = mapGroups[5], options = providerTileOptions(maxZoom = 20), "Stadia.AlidadeSatellite") %>% # does not work
  # addProviderTiles( group = mapGroups[10], options = providerTileOptions(maxZoom = 20), "Thunderforest.Pioneer")  %>% # does not work

# ➜ You can zoom more smoothly, in half steps.
m <- m %>% 
  onRender("
    function(el, x) {
      var map = this;
      map.options.zoomSnap = 0.5;
      map.options.zoomDelta = 0.5;
    }
  ")
