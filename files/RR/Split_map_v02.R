
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



suppressWarnings(suppressMessages(library(jsonlite)))

args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/Drive/RR/20240525__Lenzburger%20Lauf%202024/BU/backup_Lenzburger_Lauf_2024_20240523-164107/")
} else{
  wd <- gsub("/mnt/c", "C:/", args[1])
}
setwd(wd)



tp <- data.table(read.csv("timingpoints.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
tp[, Position := gsub(" ", "", Position)]
tp[, lat := as.numeric(gsub("(.*),(.*)", "\\1", Position))]
tp[, lon := as.numeric(gsub("(.*),(.*)", "\\2", Position))]
tp[, Position := NULL]
tp <- tp[, .(Name, Color, lat, lon)]
tp <- tp[Name != ""]
setnames(tp, "Name", "TimingPoint")
tp <- tp[!is.na(lon)]

if( nrow(tp) > 0 )  {
  
  splits <- data.table(read.csv("splits.csv", sep = "\t", header = T, fileEncoding = "utf-8"))
  splits <- splits[, .(Contest, Name, TimingPoint, Distance, OrderPos)]
  splits <- splits[TimingPoint != ""]
  
  
  suppressWarnings(suppressMessages(data <- dtjoin(tp, splits)))
  data <- data[order(Contest, OrderPos)]
  data[, ID := 1:.N, .(Contest)]
  data[, Name0 := Name]
  data[, name := ID]
  data[, desc := p0("Pos: ", OrderPos, 
                    "\nTP: ", TimingPoint, 
                    "\nName: ", Name0, 
                    "\nDist.:", Distance)]
  
  # export in gpx -----------------------------------------------------------
  
  contest <- u(data[!is.na(Contest)]$Contest)
  
  for(i in seq_along(contest)) {
    export.gpx(data[Contest == contest[i]], p0("gpx/ContestID_", contest[i], ".gpx"), add.desc = T, add.url = F, layer.type = "waypoints")
  }
  
  all <- data[, .N, .(lon, lat, name = TimingPoint)]
  export.gpx(all, "gpx/All_Splits.gpx", add.desc = F, add.url = F, layer.type = "waypoints")
  cat("Export Split DONE :)\n")

}


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
    
    


