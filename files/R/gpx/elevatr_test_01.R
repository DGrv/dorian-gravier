library(raster)
library(dplyr)
library(ggplot2)
library(raster)
library(scales)
library(rgeos)
dem1<- getData("SRTM",lat=36,lon=-32)
c(-32,10), ylim = c(36, 52)

library(elevatr)
latslongs2 <- SpatialPointsDataFrame(coords=data[, .(x=lon, y=lat)], data=data[, .(file)], proj4string =CRS("+proj=longlat + ellps=WGS84")) 

ele <- get_elev_raster(latslongs2, z = 10)
ele2 <- raster_to_matrix(ele)
# elep <- get_elev_point(latslongs2)

plot(ele)

# sphere_shade(ele2)
ele3 <- rasterTocontour(ele)
contour(ele, level=seq(0, 3000, 50), xlim = c(-2.3,-1.8) , ylim = c(42.7, 43.2))

        