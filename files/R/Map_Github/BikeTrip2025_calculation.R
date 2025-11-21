# setup
rm(list = ls())
rootpath <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/" 
Sys.setlocale("LC_ALL", "German")
source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")


suppressWarnings(suppressMessages(library(leaflet)))
suppressWarnings(suppressMessages(library(leaflet.extras)))
# suppressWarnings(suppressMessages(library(rayshaderanimate)))
suppressWarnings(suppressMessages(library(htmlwidgets)))
suppressWarnings(suppressMessages(library(RColorBrewer)))
suppressWarnings(suppressMessages(library(sf)))
suppressWarnings(suppressMessages(library(gpx)))
suppressWarnings(suppressMessages(library(xml2)))
# display.brewer.all()

wd <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Bike_trip_2025/")
wdout <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/assets/images/BikeTrip2025/")
wdout2 <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/_includes")
setwd(wd)

cat("\nwd = ", wd)


# read gpx ----------------------------------------------------------------

ll <- data.table(path = list.files(wd, pattern = "gpx$", full = T, recursive = T))
ll[, file := basename(path)]
ll[, What := basename(dirname(path))]


data <- data.table()
for (i in seq_along(ll$path)) {
  cat(i, "- Try:", ll$file[i])
  temp <- read.gpx(ll$path[i], type="trk")
  temp[, file := ll$file[i]]
  temp[, What := ll$What[i]]
  temp[, isStart := F]
  temp[1, isStart := T]
  temp[, dist := 0]
  temp[2:nrow(temp), dist := distHaversine(temp[,.(lon, lat)])/1000]
  data <- rbind(data, temp, fill = T)
  cat(green(" - Read done\n"))
}

data[, time2 := strptime(substr(time, 1, 10), format = "%Y-%m-%d")]
data[, ele2 := ele-data.table::shift(ele)]
data[, ele2type := "Ascent"]
data[ele2<=0, ele2type := "Descent"]
data
data[, distfs := cumsum(dist)]
data


distanceTT <- round(sum(data$dist, na.rm = T))
distanceTT  
daysTT <- as.numeric(round(max(data$time2, na.rm = T)-min(data$time2, na.rm = T)))
daysTT
daysBike <- length(unique(data$time2)) 
daysBike    
TTa <- sum(data[ele2type == "Ascent"]$ele2, na.rm = T)
TTa
TTb <- sum(data[ele2type == "Descent"]$ele2, na.rm = T)
TTb



setwd(wdout)


theme_set(theme_bw())
# theme_set(theme(
#   panel.background = element_rect(fill = "transparent"),
#   # ,
#                                   # colour = NA_character_), # necessary to avoid drawing panel outline
#   # panel.grid.major = element_blank(), # get rid of major grid
#   # panel.grid.minor = element_blank(), # get rid of minor grid
#   # plot.background = element_rect(fill = "transparent",
#                                  # colour = NA_character_), # necessary to avoid drawing plot outline
#   legend.background = element_rect(fill = "transparent"),
#   legend.box.background = element_rect(fill = "transparent"),
#   legend.key = element_rect(fill = "transparent"),
#   text = element_text(size=10,  family="Segoe UI")
# ))

# create plots  
b <- ggplot(data, aes(time2, dist))+stat_summary(fun = "sum", geom = "bar")+xlab("Date")+ylab("Distance (km)")+labs(title="Distance per day")+theme(text = element_text(size =15))+scale_y_continuous(sec.axis=dup_axis())+ theme(text = element_text(size=8,  family="Segoe UI"))

c <- ggplot(data, aes(time2, ele2))+stat_summary(aes(fill=ele2type),fun = "sum", geom = "bar")+xlab("Date")+ylab("Elevation (m)")+labs(title="Ascent and descent per day")+theme(text = element_text(size =15))+scale_y_continuous(sec.axis=dup_axis())+ theme(text = element_text(size=8,  family="Segoe UI"))


a <- ggplot(data, aes(distfs, ele))+geom_line()+ylab("Altitude (m)")+xlab("Distance (km)")+labs(title="Elevation profile for the bike trip")+theme(text = element_text(size =15))+scale_y_continuous(sec.axis=dup_axis())+ theme(text = element_text(size=8,  family="Segoe UI"))


ggsave(plot = a, filename = paste0(wdout, "Elevation.png"), bg = "transparent", width = 1200/120, height = 300/120)
ggsave(plot = b, filename = paste0(wdout, "Distance.png"), bg = "transparent", width = 1200/120, height = 300/120)
ggsave(plot = c, filename = paste0(wdout, "Ascent.png"), bg = "transparent", width = 1200/120, height = 300/120)

info <- data.table(What=c("Distance total (km)",
                          "Days spent on the bike",
                          "Days gone", 
                          "Total ascent (m)", 
                          "Total descent (m)"), value = c(distanceTT,
                                                          daysBike,
                                                          daysTT,
                                                          TTa,
                                                          TTb))
info[, value := round(value)]
info  
# png("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/assets/images/BikeTrip2022/Info.png", height = 300*3, width = 500*3, bg = NA)
# grid.table(info, theme=ttheme_minimal(base_colour="#f0e3cb", base_size = 20), rows=rep("", nrow(info)))
# # formattable(info)
# dev.off()  

setwd(wdout2)
write(kable(info), "BikeTrip2025_stats.md")



