
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



library(jsonlite)

wd <- rP("file:///C:/Users/doria/Downloads/Drive/RR/Zurick_Marathon/BU/Splits/")
setwd(wd)

llvs <- list.files(wd, pattern = "lvs$", full.names = T)
llvs <- llvs[!llvs %like% "Timing"]
llvs

loc <- data.table(read.csv("Timing Points.lvs", sep = ";", header = F, fileEncoding = "utf-8"))
loc <- loc[, .(V1, V5, V4)]
loc
loc[, V5 := gsub(" ", "", V5)]
loc[, lat := as.numeric(gsub("(.*),(.*)", "\\1", V5))]
loc[, lon := as.numeric(gsub("(.*),(.*)", "\\2", V5))]
loc[, V5 := NULL]
setnames(loc, c("TimingPoint", "Color0", "lat", "lon"))
loc

splitall <- data.table()
for(i in seq_along(llvs)) {
  split <- data.table(fromJSON(llvs[i]))
  split[, filename := llvs[i]]
  splitall <- rbind(splitall, split, fill = T)
}

splitall
data <- dtjoin(splitall, loc)
data[, IDDORI := 1:.N, filename]
data <- data[!is.na(lon)]
data[, Name := p0(IDDORI, " - ", Name, " - ", TimingPoint, " - ", Distance)]
data <- data[, .(Name, TimingPoint, filename,lon, lat, IDDORI)]
data[, ID := 1:.N, .(filename, TimingPoint)]
data[, ID := p0("S", ID)]
data2 <- dcast.data.table(data, TimingPoint+filename+lon+lat~ID, value.var = "Name")
data2[, Name := ifelse(is.na(S2), S1, p0(S1, "\n", S2))]




# test osm ----------------------------------------------------------------

    # source("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/Function_srtm.R")
    # library(sf)
    # # data2
    # temp <- data2[filename == llvs[3]]
    # data3 <- st_as_sf(temp, coords = c("lon","lat"), crs = st_crs(4326))
    # # data2 <- st_transform(data, crs= 3857)
    # bb <- st_bbox(data3)
    # bb
    # loc2 <- zoomman(c((max(temp$lon)+min(temp$lon))/2, (max(temp$lat)+min(temp$lat))/2), 10, side = F)
    # # loc2 <- zoomman(bb, 10, side = F)
    # bb2 <- st_bbox(c(xmin = min(loc2$lon), xmax = max(loc2$lon), ymin = min(loc2$lat), ymax = max(loc2$lat)))  
    # 
    # st_crs(bb) <- 4326
    # st_crs(bb2) <- 4326
    # # st_crs(bb) <- 4326
    # 
    # library(basemaps)
    # get_maptypes()
    # # set defaults for the basemap
    # set_defaults(map_service = "osm", map_type = "streets")
    # 
    # ggplot()+
    #   basemap_gglayer(bb2)+
    #   geom_sf_label(data = st_transform(data3, crs = 3857), aes(label = Name), hjust = 1.05, vjust = 1.05)+
    #   geom_sf(data = st_transform(data3, crs = 3857), size = 3)+
    #   scale_fill_identity() +
    #   coord_sf(expand = T)
  

# basemapR test new package -----------------------------------------------

    # library(basemapR)
    # ggplot() +
    #   base_map(bb2, basemap = 'voyager', increase_zoom = 0) +
    #   geom_sf(data = data3, size = 3)+ 
    #   geom_sf_label(data = data3, aes(label = Name), hjust = 1.05, vjust = 1.05)
    
    
      
# export in gpx -----------------------------------------------------------



for(i in seq_along(llvs)) {
  split <- data[filename == llvs[i]]
  split
  newname <- p0("Splits_GPX__", gsub("\\.lvs", "", basename(llvs[i])), ".gpx")
  export.gpx(split, newname, add.desc = F, add.url = F, layer.type = "tracks")
}

