
# setup
rm(list = ls())
if( paste0(Sys.info()[4]) == 'DESKTOP-MG495PG' ) {
  rootpath <- 'C:/Users/doria/Dropbox/Shared_Dorian/'
  Sys.setlocale('LC_ALL', 'German')
} else {
  if( paste0(Sys.info()[4]) == 'DORIANSRECHNER' ) {
    rootpath <- 'C:/Users/dorian.BSPM/Dropbox/Shared_Dorian/'
  } else {
    rootpath <- 'C:/Users/buero.BSPM/Dropbox/Shared_Dorian/'
  }
}
source(paste0(rootpath, "Dorian/BM_Function_v01.r"), encoding="utf-8")

args <- commandArgs(trailingOnly=TRUE)


# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  lookfor <- "Sidelenhütte"
} else if (length(args)==1) {
  # default output file
  lookfor <- args[1]
}

lookfor <- str_conv(lookfor, "utf-8")

library(ggh4x)
library(ggmap)
library(jsonlite)
library(httr)
library(rgdal)
library(ggmap)
library(plotKML)
library(gganimate)
library(rayshader)
library(rayshaderanimate)
library(raster)
library(sf)
library(ggspatial) 
library(gifski)
library(geosphere)
library(basemaps)
library(RANN)
library(ggrepel)

source("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/Function_srtm.R")

wd <- "D:/Pictures/GoPro/Map_bike/"
setwd(wd)

file.remove("Location_choose_white_nobike.png")










api <- readLines(rP("file:///C:/Users/doria/Downloads/Outdoor/ggmap_ap1_k3y.txt")) # Text file with the API key
register_google(key = api)
getOption("ggmap")



# world -------------------------------------------------------------------

world <- data.table(map_data("world"))
world2 <- world[region %like% "France|Spain|Portuga|Ando|Switzerland|Italy|Germany"]

# cities ------------------------------------------------------------------

# if( !exists("city") ) {
#   city <- data.table(read.csv("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/Cities_EU.csv"))
#   city <- city[Country %in% c("ES", "FR", "PT", "CH", "IT", "DE") & !is.na(pop)]
#   city <- city[lat > min(world2$lat) & lon > min(world2$long) & lat < max(world2$lat) & lon < max(world2$long)]
# }

# srtm --------------------------------------------------------------------
 
# if( !exists("rr3") ) {
#   rr3 <- get.contour('C:/Users/doria/Downloads/Outdoor/SRTM/MOSAIC.tif', 100)
# }





# ggplot ------------------------------------------------------------------

cc <- c("#ffbe0b","#fb5607","#ff006e","#8338ec","#3a86ff")
cc <- cc[sample(1:length(cc), 2)]








# gpx ---------------------------------------------------------------------


# city <- city[tolower(name) != tolower(lookfor)]
loc <- geocode(lookfor)
debug.easy(is.na(loc$lon), "Your location was not found !!!!")

locp <- st_as_sf(loc, coords = c("lon","lat"), crs = st_crs(4326))

# bbox for sf
loc1 <- get_googlemap(lookfor, zoom = 7)
loc2 <- bb2bbox(attr(loc1, "bb"))
t <- (loc2[[4]]-loc2[[2]])*((16-9)/16)/2
loc3 <- st_bbox(c(xmin = loc2[[1]], xmax = loc2[[3]], ymin = loc2[[2]]+t, ymax = loc2[[4]]-t))  
loc3
st_crs(loc3) <- 4326



# ggplot ------------------------------------------------------------------

# theme -------------------------------------------------------------------

theme_set(theme_void())
theme_set(theme(plot.background = element_rect(fill = "black"),
                panel.background = element_rect(fill="black"),
                panel.grid.major = element_line(color = 'black'),
                panel.grid.minor = element_line(color = 'black'),
                axis.text=element_text(color="black")))

  


a <- ggplot()+
  geom_polygon(data=world, aes(long, lat, group = group), colour='white', fill="gray80", linewidth=1.25)+
  coord_cartesian(xlim = c(-22,20), ylim = c(36, 52))+
  geom_point(data = loc, aes(x = lon, y = lat), color = cc[2], size = 7) + 
  # geom_label(data = loc, aes(lon, lat, label = lookfor), fill = cc, size = 14, hjust = -0.1, vjust = 1.2)
  geom_label_repel(data = loc, aes(lon, lat, label = lookfor), fill = cc[2], color = "white", size = 14, hjust = -0.2, vjust = 1.3, label.r = 0.5, segment.colour = NA)
# a
printfast(a, "Location_choose_white_nobike.png", ext = "png", height = 1080, width = 1920)
# png2mp4("Location_choose_white_nobike.png", 10)
system("magick Location_choose_white_nobike.png -background black -alpha background -alpha off -bordercolor black -border 1 -transparent black Location_choose_white_nobike.png")
system('magick Location_choose_white_nobike.png -fill "rgba(204,204,204,0.4)" -opaque rgba(204,204,204)  Location_choose_white_nobike.png')
# system("qimgv Location_choose_white_nobike.png")

# 
# # osm ---------------------------------------------------------------------
# 
# 
# # set defaults for the basemap
# set_defaults(map_service = "osm", map_type = "topographic")
# # raster object: Brick
# flush_cache()
# map <- basemap_raster(loc3)
# 
# 
# # # view all available maps
# # get_maptypes()
# 
# # a <- ggplot() + 
# #   basemap_gglayer(loc3) + # will be transformed in 3857
# #   scale_fill_identity() +
# #   geom_sf(data=data2, color = cc[1], size = 1.2, inherit.aes = FALSE)+
# #   # coord_cartesian(xlim = c(loc3[[1]], loc3[[3]]), ylim = c(loc3[[2]], loc3[[4]]))
# #   coord_sf()+
# #   force_panelsizes(rows = unit(10.8*5, "cm"),
# #                    cols = unit(10.8*5, "cm"))
# theme_set(theme_void())
# 
# 
# # plotting RasterBrick
# a <- gg_raster(map, r_type = "RGB", maxpixels = 500e5)+
#   geom_sf(data=data2, color = cc2a, size = 2, inherit.aes = FALSE)+
#   geom_sf(data = locp, color = cc2b, size = 10)+
#   force_panelsizes(rows = unit(108/2.5, "cm"),
#                    cols = unit(192/2.5, "cm"))
# printfast(a, "Location_choose_topo.png", ext = "png", height = 1080, width = 1920)
#   
# 
# png2mp4("Location_choose_topo.png")
# 
# 
# 
#   