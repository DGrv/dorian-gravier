
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')

stop("[DEBUG] - Dorian - You have to update the code, plotKML, rayshaderanimate, rgdal are not anymore maintained, used the function read.gpx that I created")



library(jsonlite)
library(httr)
library(rgdal)
library(ggmap)
library(plotKML)

wd <- "D://Pictures/GoPro/Map_climb"
wd2 <- "D://Pictures/GoPro/Map_climb/SUMMARY/"
setwd(wd)


# Data --------------------------------------------------------------------


world <- data.table(map_data("world"))
world
world[,.N, subregion]
world[region %like% "France|Spain|Portuga"]
world2 <- world[region %like% "France|Spain|Portuga|Ando"]



data <- data.table(readGPX("Morris_climb.gpx")$waypoints)
data
        # clipr::write_clip(data$name)
        # data[, time := read_clip()]
        # data[, time2 := read_clip()]
        # data
        # data[, time := strptime(time, format = "%m/%d/%Y")]
        # data[, time2 := strptime(time2, format = "%m/%d/%Y")]
        # dput(data$time)
        # dput(data$time2)


t1 <- structure(c(1673391600, 1673478000, 1673564400, 1673650800, 1673823600, 
                  1673996400, 1674082800, 1674255600, 1674601200, 1674687600, 1674774000, 
                  1674860400, 1675033200, 1675119600, 1675206000, 1675378800, 1675551600, 
                  1675638000, 1675810800, 1675983600, 1676156400, 1676242800, 1676847600, 
                  1677193200, 1678143600, 1678402800, 1676761200, 1678662000, 1678834800
), class = c("POSIXct", "POSIXt"), tzone = "")
t2 <- structure(c(1673391600, 1673478000, 1673564400, 1673737200, 1673823600, 
                  1673996400, 1674169200, 1674428400, 1674601200, 1674687600, 1674774000, 
                  1674860400, 1675033200, 1675119600, 1675292400, 1675465200, 1675551600, 
                  1675638000, 1675897200, 1675983600, 1676156400, 1676674800, 1676847600, 
                  1677193200, 1678230000, 1678575600, 1676761200, 1678748400, 1678921200
), class = c("POSIXct", "POSIXt"), tzone = "")
data[, time := t1]
data[, time2 := t2]
data[, duration2 := as.numeric(difftime(time2, time, units = "days")) + 1]
data[, duration := as.character(duration2)]
data[name %like% "Chorro", duration2 := duration2 + 8]
data[, duration3 := 1]
for(i in 2:nrow(data)) {
  data[i, duration3 := sum(data[1:i]$duration2)]
}
data
data
data[duration != "1", duration := p0(duration, " days")]
data[duration == "1", duration := p0(duration, " day")]
data
data[name == "El Chorro", duration := "6+8 days"]
data
setorder(data, "time")
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



data[, hjust := 1]
data[, vjust := 0]
data[grep("Panocha|becs|Ard|Ocaive|Caho|Puig|Rosario|Ifach", name), hjust:=-0.1]
data[grep("Panocha|becs|Ard|Caho|Sardenes|Oro|Tajos|Puig|Rosario", name), vjust:=2]
data[grep("Desplo", name), vjust:=-1.2]
data[grep("Torcal", name), vjust:=-2.4]
data[grep("Ponoch", name), vjust:=3.5]
data[grep("Ponoch", name), hjust:=-0.5]
data[grep("Toix", name), vjust:=3.5+1.5]
data[grep("Toix", name), hjust:=-0.5+0.2]




for (i in 1:nrow(data)) {
  
  actual <- data[i]
  rest <- data[1:i]
  allrest <- data[-i]

  a <- ggplot(data, aes(lon, lat))+
    # geom_map(data = world2, map = world, aes(long, lat, map_id = region), size = 0.1, fill = "white")+
    geom_polygon(data=world2, aes(long, lat, group = group), colour='white', fill=NA)+
    geom_point(data = rest, color = "white", size = 4)+
    geom_point(data = actual, color = "red", size = 8)+
    coord_cartesian(xlim = c(-32,10), ylim = c(36, 52))
    # geom_label(aes(label = you))
  a
  printfast(a, "tempmap.png", ext = "png", height = 1080, width = 1920)
  
  
  
  
  
  a <- ggplot(data, aes(lon, lat))+
    geom_path(data=rest, color = "grey15")+
    geom_text(data=actual, aes(x=-12, y=45.5, label = p0("Climbing days: ", duration3)), color = "white", size = 16, hjust = 0)+
    geom_text(data=actual, aes(x=13, y=36.5, label = time), color = "white", size = 30, hjust = 1)+
    geom_text(data=actual, aes(x=13, y=37.4, label = duration), color = "white", size = 20, hjust = 1)+
    # geom_map(data = world2, map = world, aes(long, lat, map_id = region), size = 0.1, fill = "white")+
    geom_polygon(data=world2, aes(long, lat, group = group), colour='grey50', fill=NA)+
    geom_point(data = data, color = "white", size = 4)+
    geom_point(data = actual, color = "red", size = 5)+
    geom_text(data = allrest, aes(label=name, hjust = hjust, vjust = vjust), color="white", nudge_y = 0.1, nudge_x = -0.1, size=6)+
    geom_text(data = actual, aes(label=name, hjust = hjust, vjust = vjust), color="red", nudge_y = 0.1, nudge_x = -0.1, size=6)+
    coord_cartesian(xlim=c(-13, 13), ylim=c(36.5, 46.5))
  a
  printfast(a, "tempmap2.png", ext = "png", height = 1080, width = 1920)
  
  
  
  
  
  # system('ffmpeg -y -stats -loglevel error -r "1/8" -f image2 -i "tempmap.png" -vf "fps=24,format=yuv420p" 0.mp4')
  # system('ffmpeg -y -stats -loglevel error -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i 0.mp4 -c:v copy -c:a aac -video_track_timescale 24000 -shortest 1.mp4')
  # system(p0('ffmpeg -y -stats -loglevel error -i 1.mp4 -vf drawtext="fontfile=Arial:fontsize=70:fontcolor=white:x=w*0.05:y=h*0.1:text=', actual$name, '" -video_track_timescale 24000 2.mp4'))
  # system(p0('ffmpeg -y -stats -loglevel error -i 2.mp4 -vf "fade=t=in:st=0:d=2,fade=t=out:st=5:d=2" -c:a copy ', leading0(i, 2), "_ClimbMo__", slugify(actual$name),'.mp4'))
  
  if( i == nrow(data)) {
    system('ffmpeg -y -stats -loglevel error -r "1/6" -f image2 -i "tempmap2.png" -vf "fps=24,format=yuv420p" 0.mp4')
  } else  {
    system('ffmpeg -y -stats -loglevel error -r "1/2" -f image2 -i "tempmap2.png" -vf "fps=24,format=yuv420p" 0.mp4')
  }
  system(p0('ffmpeg -y -stats -loglevel error -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i 0.mp4 -c:v copy -c:a aac -video_track_timescale 24000 -shortest ', wd2, leading0(i, 2), "_ClimbMo__", slugify(actual$name),'_SUMMARY.mp4'))
  
  file.remove("0.mp4", "1.mp4", "2.mp4", "3.mp4", "tempmap.png", "tempmap2.png")
}
        


setwd(wd2)
writeLines(p0("file '", list.files(wd2, "mp4"), "'"), "list.txt")
system("ffmpeg -stats -loglevel error -y -f concat -safe 0 -i list.txt -c copy output.mp4")
system('ffmpeg -stats -loglevel error -y -i output.mp4 -af "atempo=2" -vf "setpts=PTS/2" -video_track_timescale 24000 output_fast.mp4')



# Errezil map

i <- nrow(data)
actual <- data[i]
rest <- data[1:i]
allrest <- data[-i]

a <- ggplot(data, aes(lon, lat))+
  # geom_map(data = world2, map = world, aes(long, lat, map_id = region), size = 0.1, fill = "white")+
  geom_polygon(data=world2, aes(long, lat, group = group), colour='white', fill=NA)+
  geom_point(data = rest, color = "white", size = 4)+
  geom_point(data = actual, color = "red", size = 8)+
  geom_point(data = data.table(lat=43.165095, lon=-2.1757474), color = "yellow", size = 8)+
  geom_text(data = data.table(lat=43.165095, lon=-2.1757474), label = "Errezil", color = "yellow", size = 14, hjust = 1.1, vjust = -1.3)+
  coord_cartesian(xlim = c(-32,10), ylim = c(36, 52))
# geom_label(aes(label = you))
a
printfast(a, "tempmap.png", ext = "png", height = 1080, width = 1920)

system('ffmpeg -y -stats -loglevel error -r "1/3" -f image2 -i "tempmap.png" -vf "fps=24,format=yuv420p" 0.mp4')
system('ffmpeg -y -stats -loglevel error -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i 0.mp4 -c:v copy -c:a aac -video_track_timescale 24000 -shortest E22_Errezil_location.mp4')
file.remove("0.mp4", "1.mp4", "2.mp4", "3.mp4", "tempmap.png", "tempmap2.png")




