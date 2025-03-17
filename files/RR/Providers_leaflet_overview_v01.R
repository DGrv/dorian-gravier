library(leaflet)

setwd("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/")
# Get all available providers
all_providers <- names(leaflet::providers)



maxt <- 20
ceiling(length(all_providers)/maxt)
for(j in 1:ceiling(length(all_providers)/maxt)) {
  s1 <- (((maxt*j)-maxt)+1):(maxt*j)

  # Create the leaflet map
  m <- leaflet() %>%
    setView(lng = 8.91579, lat = 46.13684, zoom = 17)
    
  for( i in s1) {
    m <- m %>% addProviderTiles(all_providers[i], group = all_providers[i], options = providerTileOptions(maxZoom = 20))
  }
  
  m <- m %>% addLayersControl(
    baseGroups = all_providers[s1],
    options = layersControlOptions(collapsed = FALSE)
  )
  saveWidget(m, file=paste0("Providers", j, ".html"))
  rm(m)

}



# cartodb <- all_providers[all_providers %like% "Swiss"]
cartodb <- all_providers[all_providers %like% "CartoDB"]
m <- leaflet() %>%
  setView(lng = 8.91579, lat = 46.13684, zoom = 17)

# for( i in seq_along(cartodb)) {
for( i in 2:length(cartodb)) {
  m <- m %>% addProviderTiles(cartodb[i], group = cartodb[i])
}

m <- m %>% addLayersControl(
  baseGroups = cartodb[2:length(cartodb)],
  options = layersControlOptions(collapsed = FALSE)
)
# m
saveWidget(m, file=paste0("Providers_cartoDB.html"))

