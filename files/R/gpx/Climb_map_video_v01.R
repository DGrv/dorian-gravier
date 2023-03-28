
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

wd <- "D://Pictures/GoPro/Map_climb"
setwd(wd)


# Data --------------------------------------------------------------------


world <- data.table(map_data("world"))
world
world[,.N, subregion]
world[region %like% "France|Spain|Portuga"]
world2 <- world[region %like% "France|Spain|Portuga|Ando"]



data <- data.table(readGPX("Morris_climb.gpx")$waypoints)
data




# Plot --------------------------------------------------------------------




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


for (i in 1:nrow(data)) {
  actual <- data[i]
  rest <- data[1:i-1]
  a <- ggplot(data, aes(lon, lat))+
    # geom_map(data = world2, map = world, aes(long, lat, map_id = region), size = 0.1, fill = "white")+
    geom_polygon(data=world2, aes(long, lat, group = group), colour='white', fill=NA)+
    geom_point(data = actual, color = "red", size = 8)+
    geom_point(data = rest, color = "white", size = 4)+
    xlim(c(-32,10))+
    ylim(c(36, 52))
    # geom_label(aes(label = you))
  a
  printfast(a, "tempmap.png", ext = "png", height = 1080, width = 1920)
  
  system('ffmpeg -y -stats -loglevel error -r "1/8" -f image2 -i "tempmap.png" -vf "fps=24,format=yuv420p" 0.mp4')
  system('ffmpeg -y -stats -loglevel error -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i 0.mp4 -c:v copy -c:a aac -video_track_timescale 24000 -shortest 1.mp4')
  system(p0('ffmpeg -y -stats -loglevel error -i 1.mp4 -vf drawtext="fontfile=Arial:fontsize=70:fontcolor=white:x=w*0.05:y=h*0.1:text=', actual$name, '" -video_track_timescale 24000 2.mp4'))
  system(p0('ffmpeg -y -stats -loglevel error -i 2.mp4 -vf "fade=t=in:st=0:d=2,fade=t=out:st=5:d=2" -c:a copy ', leading0(i, 2), "_ClimbMo__", slugify(actual$name),'.mp4'))
  
  file.remove("0.mp4", "1.mp4", "2.mp4", "tempmap.png")
}
        





