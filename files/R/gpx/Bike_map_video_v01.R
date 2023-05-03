
# setup
rm(list = ls())
if( paste0(Sys.info()[4]) == 'DESKTOP-MG495PG' ) {
  rootpath <- 'C:/Users/doria/Dropbox/Shared_Dorian/'
  Sys.setlocale('LC_ALL', 'German')
} else {
  if( paste0(Sys.info()[4]) == 'DORIANSRECHNER' ) {
    rootpath <- 'file:///C:/Users/dorian.BSPM/Dropbox/Shared_Dorian/'
  } else {
    rootpath <- 'file:///C:/Users/buero.BSPM/Dropbox/Shared_Dorian/'
  }
}
source(paste0(rootpath, "Dorian/BM_Function_v01.r"), encoding="utf-8")

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

source("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/Function_srtm.R")



wd <- "D://Pictures/GoPro//Map_bike"
setwd(wd)


# Data --------------------------------------------------------------------


world <- data.table(map_data("world"))
world
world[,.N, subregion]
world[region %like% "France|Spain|Portuga"]
world2 <- world[region %like% "France|Spain|Portuga|Ando"]


ll <- list.files.only("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Bike_trip_2022")
data <- data.table()
for (i in seq_along(ll)) {
  temp <- data.table(get_table_from_gpx(ll[i]))
  # temp <- data.table(readGPX(ll[i])$tracks[[1]][[1]])
  temp[, file := basename(ll[i])]
  data <- rbind(data, temp, fill = T)
}


data[, time1 := strptime(substr(time, 1, 10), format = "%Y-%m-%d")]
          # # does not work for transition
          data[, time2 := gsub("Z", "", gsub("T", " ", gsub(".000Z", "", time)))]
          data[, time3 := strptime(time2, format = "%Y-%m-%d %H:%M:%S")]
          data <- data[order(time3)]
          data[, n := as.numeric(1:.N)]


temp <- data[, .N, time1]$time1
nlast <- 5
temp <- temp[(length(temp)-nlast):length(temp)]
datafirst <- data[!time1 %in% temp]
datalast <- data[time1 %in% temp]
datalast[, time1b := p0(min(time1), " - ", max(time1))]
datalast[, n := as.numeric(1:.N)]
datafirst[, time1 := NULL]


# data cities and pop -----------------------------------------------------

        # 
        # # https://ec.europa.eu/eurostat/estat-navtree-portlet-prod/BulkDownloadListing?sort=1&dir=dic%2Fen
        # # https://ec.europa.eu/eurostat/databrowser/bulk?lang=en
        # 
        # names.cities <- data.table(read.csv("C:/Users/doria/Downloads/ESTAT_downloads_ea0a9c6a-22f7-48ab-8638-dce2d9995537/cities.dic", sep="\t", header = F, encoding = "UTF-8"))
        # colnames(names.cities) <- c("cities", "name")
        # names.cities
        # pop <- data.table(read.csv("C:/Users/doria/Downloads/ESTAT_downloads_ea0a9c6a-22f7-48ab-8638-dce2d9995537/URB_CPOP1.csv"), sep = ",")
        # pop
        # pop2 <- dtjoin(pop, names.cities)
        # pop2
        # pop2 <- pop2[pop2[,.I[TIME_PERIOD == max(TIME_PERIOD)], name]$V1]
        # pop2 <- pop2[, .(pop = sum(OBS_VALUE)), name]
        # pop2[name == "Zonguldak"]
        # 
        # city <- data.table(read.csv2("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/european_cities_eu_standard.csv"))
        # colnames(city) <- c("name", "Country", "lat", "lon")
        # city[,.N,Country]
        # city
        # city <- dtjoin(city, pop2[, .(name, pop)])
        # 
        # write.csv(city, "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/Cities_EU.csv")

city <- data.table(read.csv("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/gpx/Cities_EU.csv"))
city <- city[Country %in% c("ES", "FR", "PT") & !is.na(pop)]
city <- city[lat > min(world2$lat) & lon > min(world2$long) & lat < max(world2$lat) & lon < max(world2$long)]
        
        # # test data
        # ggplot(city, aes(lon, lat))+
        #   geom_point(color = "red")+
        #   geom_polygon(data=world2, aes(long, lat, group = group), colour='grey', fill=NA)
  

# SRTM ----------------------------------------------------------



# data
# data2 <- get_enriched_gpx_table(data[, c(1:4)])
# data2
# 
# databbox <- get_bbox_from_gpx_table(data[, c(1:4)])
# databbox


          # # to get the srtm locally I think
          # my.fn <- function(aurl, filename){
          #   cat("You wanna download: ", aurl, "\n")
          #   cat("You wanna save it there : ", filename, "\n\n")
          #   httr::set_config(httr::config(ssl_verifypeer=0L))
          #   httr::GET(aurl, httr::write_disk(path = filename, overwrite = F))
          # }
          # tmpfun <- get(".download", envir = asNamespace("raster"))
          # environment(my.fn) <- environment(tmpfun)
          # attributes(my.fn) <- attributes(tmpfun)  # don't know if this is really needed
          # assignInNamespace(".download", my.fn, ns="raster")
          # 
          # 
          # el_mat <- get_elevdata_from_bbox(databbox)
          # el_mat



# # prepare nasa data
# rr <- raster('C:/Users/doria/Downloads/Outdoor/SRTM/merge_n30w030_n30e000.tif')
# plot(rr)
# writeRaster(r, filename='C:/Users/doria/Downloads/Outdoor/GDEM/nasa_test_02.tif', overwrite=TRUE)
# rr3 <- get.contour('C:/Users/doria/Downloads/GDEM/MOSAIC.tif', 100)
rr3 <- get.contour('C:/Users/doria/Downloads/Outdoor/SRTM/MOSAIC.tif', 100)


# plot(raster("C:/Users/doria/Downloads/Outdoor/SRTM/N30W030/cut_n30w030.tif"))
# plot(raster("C:/Users/doria/Downloads/Outdoor/SRTM/N30E000/cut_n30e000.tif"))
# plot(raster("C:/Users/doria/Downloads/Outdoor/SRTM/merge_n30w030_n30e000.tif"))
# plot(raster("C:/Users/doria/Downloads/Outdoor/SRTM/MOSAIC.tif"))


# # get center point for zoom
# https://www.r-bloggers.com/2019/04/zooming-in-on-maps-with-sf-and-ggplot2/
loc <- c((max(datalast$lon) - min(datalast$lon))/2 + min(datalast$lon), (max(datalast$lat) - min(datalast$lat))/2 + min(datalast$lat))  # Berlin
locbig <- c(2, 31)
zlast <- zoomman(loc, 8)



# # ggplot2 with raster
# databbox <- get_bbox_from_gpx_table(datalast[, c(1:4)])
# e <- as(extent(c(databbox[, 1], databbox[, 2])), 'SpatialPolygons')
# rr2 <- crop(rr, databbox)
# rr4 <- as.data.table(as(rr2, "SpatialPixelsDataFrame"))
# setnames(rr4, names(rr4), c("value", "x", "y"))
# ggplot() +
#   geom_tile(data=rr4, aes(x=x, y=y, fill=value), alpha=0.8) +
#   coord_equal()







# theme --------------------------------------------------------------------


# ggplot(all, aes(lon, lat))+
#   geom_map(data = world[region %like% "France|Spain|Portuga"], map = world, aes(long, lat, map_id = region), color = "white", fill = "lightgray", size = 0.1)+
#   geom_point()

theme_set(theme_void())
theme_set(theme(plot.background = element_rect(fill = "black"),
                panel.background = element_rect(fill="black"),
                panel.grid.major = element_line(color = 'black'),
                panel.grid.minor = element_line(color = 'black'),
                axis.text=element_text(color="black")))
# theme_set(theme(panel.background = element_rect(fill = "black", color ="black")))




# Global map --------------------------------------------------------------



cc <- c("#ffbe0b","#fb5607","#ff006e","#8338ec","#3a86ff")
cc <- cc[sample(1:length(cc), 2)]

a <- ggplot()+
  geom_path(data = rr3, aes(x = X, y = Y, group=group), color = "grey20")+
  geom_polygon(data=world, aes(long, lat, group = group), colour='white', fill=NA)+
  geom_path(data=datalast, aes(lon, lat), color = cc[1], size = 1.2)+
  geom_path(data=datafirst, aes(lon, lat), color = cc[2], size = 1.2)+
  geom_point(data = city, aes(lon, lat), color = "white")+
  geom_text(data = city, aes(lon, lat, label = name), color = "white", size = 3, hjust = 1.1, vjust = -0.2)+
  geom_text(data=datalast, aes(x=-33, y=51, label = time1b), color = cc[1], size = 25, hjust = 0)

# coord_map()
b <- a+  coord_cartesian(xlim = c(-32,10), ylim = c(36, 52))
# c <- a+  coord_cartesian(xlim = zlast$lon, ylim = zlast$lat)
# printfast(b, "tempmap.png", ext = "png", height = 1080, width = 1920)
printfast(b, "tempmap.png", ext = "png", height = 1080, width = 1920)
# printfast(c, "tempmapb.png", ext = "png", height = 1080, width = 1920)

system('ffmpeg -y -stats -loglevel error -r "1/10" -f image2 -i "tempmap.png" -vcodec libx264 -vf "fps=24,format=yuv420p" 0.mp4')
system('ffmpeg -y -stats -loglevel error -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i 0.mp4 -c:v copy -c:a aac -video_track_timescale 24000 -shortest 1.mp4')
system(p0('ffmpeg -y -stats -loglevel error -i 1.mp4 -vf "fade=t=in:st=0:d=2,fade=t=out:st=8:d=2" -c:a copy Last_5_days.mp4'))

file.remove("0.mp4", "1.mp4")





# Animate -----------------------------------------------------------------

# #test
# a <- ggplot(datalast, aes(lon, lat))+
#   geom_point(color = "red", size =3)+
#   geom_path(color = "red")+
#   coord_cartesian(xlim = zlast$lon, ylim = zlast$lat)+
#   transition_reveal(n)+
#   shadow_mark()
# a


a <- ggplot(data, aes(lon, lat))+
  geom_path(data = rr3, aes(x = X, y = Y, group=group), color = "grey20")+
  geom_polygon(data=world, aes(long, lat, group = group), colour='grey', fill=NA)+
  geom_point(color = "#fb5607", size = 3)+
  geom_point(color = "#fb5607", alpha = 0.8, size = 1)+
  coord_cartesian(xlim = c(-32,10), ylim = c(36, 52))+
  transition_states(n)+
  shadow_mark()
b <- gganimate::animate(a, renderer = ffmpeg_renderer(), width = 1920, height = 1080,  start_pause = 4, end_pause = 4, duration = 20)
anim_save("Complete_trip.mp4", b)
gganimate::animate(a, duration = 10, renderer = gifski_renderer())
anim_save("Complete_trip.gif")




a <- ggplot(datalast, aes(lon, lat))+
  geom_path(data = rr3, aes(x = X, y = Y, group=group), color = "grey20")+
  geom_polygon(data=world, aes(long, lat, group = group), colour='grey', fill=NA)+
  geom_point(data = datalast, color = "#fb5607")+
  geom_path(data = datafirst, color = "white")+
  coord_cartesian(xlim = zlast$lon, ylim = zlast$lat)+
  transition_state(n)+
  shadow_mark()
b <- gganimate::animate(a, renderer = ffmpeg_renderer(), width = 1920, height = 1080, start_pause = 4, end_pause = 4)
anim_save("Last_trip.mp4", b)




a <- ggplot(datalast, aes(lon, lat))+
  geom_polygon(data=world, aes(long, lat, group = group), colour='grey', fill=NA)+
  geom_point(data = datalast, color = "red")+
  # geom_path(data = datafirst, color = "white")+
  # coord_cartesian(xlim = c(-32,10), ylim = c(36, 52))+
  coord_cartesian(xlim = c(median(datalast$lon) - 5,median(datalast$lon) + 7),
                  ylim = c(median(datalast$lat) - 3, median(datalast$lat)+2))+
  transition_states(n)+
  shadow_mark()
a
printfast(a, "tempmap.png", ext = "png", height = 1080, width = 1920)




b <- gganimate::animate(a, renderer = ffmpeg_renderer(), width = 1920, height = 1080)
anim_save("test.mp4", b)



databbox <- get_bbox_from_gpx_table(datalast)
bbox <- get_bbox_from_gpx_table(datalast)
map <- get_stamenmap(databbox, zoom = 11, maptype = "watercolor")
ggmap(map)+
  geom_point(data = datalast, color = "red", size = 2)+
  transition_states(n)+
  shadow_mark()












ll2 <- u(data$file)
for (i in seq_along(ll2)) {
  actual <- data[file == ll2[i]]
  rest <- data[file %in% ll2[1:(i-1)]]
  a <- ggplot(data, aes(lon, lat))+
    # geom_map(data = world2, map = world, aes(long, lat, map_id = region), size = 0.1, fill = "white")+
    geom_polygon(data=world2, aes(long, lat, group = group), colour='grey', fill=NA)+
    geom_point(data = rest[rest[, .I[1], file]$V1], color = "yellow", size = 2)+
    geom_path(data=actual, color = "red", size = 1)+
    geom_path(data=rest, color = "white")+
    transition_time(time)+
    # geom_point(data = actual, color = "red", size = 8)+
    coord_cartesian(xlim = c(median(actual$lon) - 5,median(actual$lon) + 7),
              ylim = c(median(actual$lat) - 3, median(actual$lat)+2))
    # xlim(c(median(actual$lon) - 5,median(actual$lon) + 7))+
    # xlim(c(-32,10))+
    # ylim(c(median(actual$lat) - 3, median(actual$lat)+2))
    # ylim(c(36, 52))
    # geom_label(aes(label = you))
  a
  printfast(a, "tempmap.png", ext = "png", height = 1080, width = 1920)
  
  system('ffmpeg -y -stats -loglevel error -r "1/8" -f image2 -i "tempmap.png" -vcodec libx265 -vf "fps=24,format=yuv420p" 0.mp4')
  system('ffmpeg -y -stats -loglevel error -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i 0.mp4 -c:v copy -c:a aac -video_track_timescale 24000 -shortest 1.mp4')
  system(p0('ffmpeg -y -stats -loglevel error -i 1.mp4 -vf drawtext="fontfile=Arial:fontsize=70:fontcolor=white:x=w*0.05:y=h*0.1:text=', actual$name, '" -video_track_timescale 24000 2.mp4'))
  system(p0('ffmpeg -y -stats -loglevel error -i 2.mp4 -vf "fade=t=in:st=0:d=2,fade=t=out:st=5:d=2" -c:a copy ', leading0(i, 2), "_ClimbMo__", slugify(actual$name),'.mp4'))
  
  file.remove("0.mp4", "1.mp4", "2.mp4", "tempmap.png")
}
        





