
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


library(plotKML)
library(rgdal)


# temp <- data.table(read.csv("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/austria.csv"))
# temp <- temp[gpx != "gpx"]
# temp[gpx %like% "epinal"]
# temp <- unique(temp)
# temp <- temp[order(country)]
# temp[, ID := 1:.N, country]
# temp[, code := paste0("curl -o C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/gpx/", country, "_", ID, ".gpx ", gpx)]
# temp
# writeLines(temp$code, "C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/Download_gpx.bat")



ff <- data.table(filepath =list.files("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/gpx", full.names = T, pattern = "gpx"))
# ff <- data.table(filepath =list.files("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/gpx", full.names = T, pattern = "austria"))
ff[, filename := basename(filepath)]
ff[, country := tstrsplit(filename, "_")[[1]]]
ff[, .N, country]


# for(j in 1:length(ff$filepath)) {
# 
#   cat(j, "/", length(ff$filepath), "\n")
#   
#   data <- data.table(readGPX(ff$filepath[j])$waypoints)
#   data
#   data <- data[lon != "NA"]
#   data[, coord := paste0(lon, lat)]
#   data
#   if(nrow(data) > 1){
#     for(i in 2:nrow(data)) {
#       if( data[i]$coord == data[1]$coord ) {
#         data[i, lat := data[i-1]$lat]
#         data[i, lon := data[i-1]$lon]
#       }
#     }
#   }
#   data
#   data[, name:= gsub(" )", ")", name)]
#   data[, name:= gsub("^ *| *$", "", name)]
#   data2 <- unique(data[, .(lon, lat)])
#   for(i in 1:nrow(data2)) {
#     data2[i, desc := paste0(data[lon == data2[i]$lon & lat == data2[i]$lat]$name, collapse = "\n")]
#   }
#   data2[, name := tstrsplit(desc, "\n", fill = "")[1]]
#   data2
#   write.csv(data2, paste0("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/gpx_converted/", gsub("gpx", "csv", ff$filename[j])))
# 
# 
# }
# 

# # add url
# for(j in 1:length(ff$filepath)) {
#   
#   cat(j, "/", length(ff$filepath), "\n")
#   
#   temp <- data.table(readLines(ff$filepath[j]))
#   
#   temp[V1 %like% "Full text"]
#   url <- gsub('.*href=\\"(.*)\\">.*', "\\1", temp[V1 %like% "Full text"]$V1)
#   url
#   
#   data <- data.table(read.csv(paste0("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/gpx_converted/", gsub("gpx", "csv", ff$filename[j]))))
#   data[, X := NULL]
#   data[, link := url]
#   write.csv(data, paste0("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/gpx_converted/", gsub("gpx", "csv", ff$filename[j])))
#   
# }



lc <- u(ff$country)

lc



for(i in seq_along(lc)) {
  
  cat("Start Country:", lc[i])
  
  lf <- list.files("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/gpx_converted", full.names = T, pattern = lc[i])
  # lf[7891]
  # fread(lf[7891])
  
  
  all2 <-  rbindlist(lapply(lf, function(file) {
    dt = fread(file, fill = TRUE)
    # further processing/filtering
  }))
  
  all2BU <-  copy(all2)
  
  all2[, nch := nchar(desc)]
  all2
  all2 <- all2[all2[, .I[nch == max(nch)], .(name, lat, lon)]$V1]
  
  
  all2 <- u(all2)
  
  all2[, V1 := NULL]
  # str(all2)
  all2[, lon := as.numeric(lon)]
  all2[, lat := as.numeric(lat)]
  all2 <- all2[!is.na(lat)]
  all2 <- all2[!is.na(lon)]
  setnames(all2, "link", "url") 
  all2 <- all2[order(name, url)]
  all2 <- all2[, .SD[1], .(name, lat, lon, desc)]
  

  latslongs <- SpatialPointsDataFrame(coords=all2[, .(lon, lat)], data=all2[, .(desc, name, url)], proj4string =CRS("+proj=longlat + ellps=WGS84")) 
  newfile <- p0("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/", str_to_title(lc[i]), ".gpx")
  writeOGR(latslongs, dsn=newfile,
           dataset_options="GPX_USE_EXTENSIONS=yes",layer="waypoints",driver="GPX", overwrite_layer = T, )
  data <- data.table(x = readLines(newfile))
  data <- data[grep("extension", x, invert = T)]
  data[, x := gsub("ogr:url", "url", x)]
  data[, x := gsub(" \\<url", " <url", x)]
  write.table(data$x, newfile, quote = F, row.names = F, col.names = F)
  
  latslongs2 <- SpatialPointsDataFrame(coords=all2[, .(lon, lat)], data=all2[, .(name)], proj4string =CRS("+proj=longlat + ellps=WGS84")) 
  newfile <- p0("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/thecrag/", str_to_title(lc[i]), "_QGIS.gpx")
  writeOGR(latslongs2, dsn=newfile,
           dataset_options="GPX_USE_EXTENSIONS=yes",layer="waypoints",driver="GPX", overwrite_layer = T, )
  rm(all2)
  
  cat("\nDone\n\n")
  
}




# conver <- data.table(x = readLines(newfile))
# # conver <- conver[grep("extension", x, invert = T)]
# conver[, x := gsub("\\<ogr:url>", "<url>", x)]
# conver[, x := gsub("\\<\\/ogr:url>", "</url>", x)]
# write.table(conver$x, newfile, quote = F, row.names = F, col.names = F)





