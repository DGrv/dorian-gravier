# Setup ----------------------------------------------------------------
  
  
  library(plotKML)
  library(ggplot2)
  theme_set(theme_bw())
  library(formattable)
  library(geosphere)
  library(gridExtra)
  library(data.table)
  library(jsonlite)
  #library(rayshaderanimate)
  library(RJSONIO)
  
  wd <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files"
  outjs <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/assets/js/Personal/gpx_biketrip2022.js"
  if( !dir.exists(wd) ) {
    wd <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files"
    outjs <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/assets/js/Personal/gpx_biketrip2022.js"
  }
  setwd(wd)

  # wildcamping position  
  # readGPX("C:/Users/doria/Downloads/Zelt.gpx")$waypoints
  tent <- data.table(readGPX("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Zelt.gpx")$waypoints)
  all <- list()
  for(i in 1:nrow(tent)){
    temp <- list(type = "Feature",
                 properties = list(popupContent = tent[i]$name),
                 geometry = list(type = "Point", coordinates = c(tent[i]$lon, tent[i]$lat)))
    all <- c(all, list(temp))
  }
  sleepjson <- paste0("var sleep =", toJSON(all, auto_unbox = T))
  sleepjson

  
  
  # functions
  printfast <- function(plot, name, height=400, width=500, ps=12, qualityprint=100, ext = "jpg", wdfunction = getwd()) {
    
    setwd(wdfunction)
    
    if(ext %in% c("jpg", ".jpg", "jpeg", ".jpeg")) {
      jpeg(filename=name, quality=qualityprint, pointsize = ps, height=height, width=width)
      print(
        plot
      )
      dev.off()
      graphics.off()
    }
    
    if(ext %in% c("png", ".png")) {
      png(filename=name, pointsize = ps, height=height, width=width)
      print(
        plot
      )
      dev.off()
      graphics.off()
    }
    
    
  }
  


# get data ----------------------------------------------------------------

  lis <- data.table(path = list.files(wd, pattern = "\\.gpx", full = T, recursive = T))
  lis <- lis[!path %like% "gpx.reg"]
  lis <- lis[!path %like% "_site"]
  lis <- lis[path %like% "Bike_trip_2022|Stop"]
  lis[, path2 := paste0("../", gsub(paste0(dirname(wd), "/"), "", path)) ]
  lis[, dir := dirname(path2) ]
  lisdir <- unique(lis$dir)
  lisdir
  

# output ------------------------------------------------------------------

  write("// create file", file = outjs)
  for(i in seq_along(lisdir)) {
    if( lisdir[i] != "files/gpx" ) {
      if( basename(lisdir[i]) == "Project" ) {
        varname <- paste0(basename(dirname(lisdir[i])), basename(lisdir[i]))
      } else {
        varname <- basename(lisdir[i])
      }
  
      lis2 <- lis[dir == lisdir[i]]
  
      for( j in 1:nrow(lis2)) {
        if( j == 1) {
          write(paste0("var ", varname, " = ['", lis2[j, path2], "',"), file = outjs, append = T)
        } else if( j == nrow(lis2)) {
          write(paste0("'", lis2[j, path2], "']\n"), file = outjs, append = T)
        } else {
          write(paste0("'", lis2[j, path2], "',"), file = outjs, append = T)
        }
      }
    }
  }
  
  write(sleepjson, file = outjs, append = T)

  
  

# GPX ---------------------------------------------------------------------

  
  files <- lis[!dir %like% "Stop"]$path
  
  all <- data.table()
  for (i in 1:length(files)) {
    print(files[i])
    route <- data.table(readGPX(files[i])$tracks[[1]][[1]])
    route[, file := files[i]]
    route[, dist := 0]
    route[, extensions:=NULL]
    route[2:nrow(route), dist := distHaversine(route[,.(lon, lat)])/1000]
    all <- rbind(all, route)
  }
  all[, time2 := strptime(substr(time, 1, 10), format = "%Y-%m-%d")]
  all[, ele := as.numeric(ele)]
  all[, ele2 := ele-data.table::shift(ele)]
  all[, ele2type := "Ascent"]
  all[ele2<=0, ele2type := "Descent"]
  all
  all[, distfs := cumsum(dist)]
  all

  
  distanceTT <- round(sum(all$dist, na.rm = T))
  distanceTT  
  daysTT <- as.numeric(round(max(all$time2)-min(all$time2)))
  daysTT
  daysBike <- length(unique(all$time2)) 
  daysBike    
  TTa <- sum(all[ele2type == "Ascent"]$ele2, na.rm = T)
  TTa
  TTb <- sum(all[ele2type == "Descent"]$ele2, na.rm = T)
  TTb
    
    
  # create plots  
  b <- ggplot(all, aes(time2, dist))+stat_summary(fun = "sum", geom = "bar")+xlab("Date")+ylab("Distance (km)")+labs(title="Distance per day")+theme(text = element_text(size =15))+scale_y_continuous(sec.axis=dup_axis())
  
  c <- ggplot(all, aes(time2, ele2))+stat_summary(aes(fill=ele2type),fun = "sum", geom = "bar")+xlab("Date")+ylab("Elevation (m)")+labs(title="Ascent and descent per day")+theme(text = element_text(size =15))+scale_y_continuous(sec.axis=dup_axis())
  
  a <- ggplot(all, aes(distfs, ele))+geom_line()+ylab("Altitude (m)")+xlab("Distance (km)")+labs(title="Elevation profile for the bike trip")+theme(text = element_text(size =15))+scale_y_continuous(sec.axis=dup_axis())
  a
  printfast(a, "Elevation.jpg", 300,1200, wdfunction = "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/picture/BikeTrip2022")
  printfast(b, "Distance.jpg", 300,1200, wdfunction = "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/picture/BikeTrip2022")
  printfast(c, "Ascent.jpg", 300,1200, wdfunction = "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/picture/BikeTrip2022")

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
  png("C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/picture/BikeTrip2022/Info.png", height = 300, width = 500, bg = "#424242")
  grid.table(info, theme=ttheme_minimal(base_colour="#f0e3cb", base_size = 20), rows=rep("", nrow(info)))
  # formattable(info)
  dev.off()  
  
  