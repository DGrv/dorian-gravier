zoomman <- function(loc, zoom, side = F) {
  lon_span <- 360 / 2^zoom
  lat_span <- 180 / 2^zoom
  lon_bounds <- unlist(c(loc[1] - lon_span / 2, loc[1] + lon_span / 2))
  lat_bounds <- unlist(c(loc[2] - lat_span / 2, loc[2] + lat_span / 2))
  d <- data.table(lon=lon_bounds, lat=lat_bounds)
  if( side ) {
    d[, lon.ori := lon]
    # d[, lat.ori := lat]
    d[, lon := lon.ori - ((lon.ori[2] - lon.ori[1]) / 6)*2]
    # d[, lat := lat.ori + ((lat.ori[2] - lat.ori[1]) / 6)*2]
  }
  return(d)
}

# zoomman <- function(loc, zoom) {
#   lon_span <- 360 / 2^zoom
#   lat_span <- 180 / 2^zoom
#   lon_bounds <- unlist(c(loc[1] - lon_span / 2, loc[1] + lon_span / 2))
#   lat_bounds <- unlist(c(loc[2] - lat_span / 2, loc[2] + lat_span / 2))
#   return(data.table(lon=lon_bounds, lat=lat_bounds))
# }

get.contour <- function(raster.file, level.u = 100) {
  # use in ggplot contour
  r <- raster(raster.file)
  rrc <- rasterToContour(r,  level=seq(0, 3000, level.u))
  rrc2 <- st_as_sf(rrc)
  rrc3 <- data.table(st_coordinates(rrc2))
  rrc3[, group := p0(L1, "-", L2)]
  return(rrc3)
}