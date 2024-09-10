
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')



library(plotKML)
library(rgdal)



# download gpx ------------------------------------------------------------


wd <- "C:/Users/doria/Downloads/Outdoor/Topo/thecrag/v03"
create.dir(wd, "gpx", "wdgpx")
wdgpx
country <- "CH"
create.dir(wdgpx, country, "wdgpx2")

# download ----------------------------------------------------------------

data <- data.table(read.csv(p0(wd, "/thecrag_v03/CH.csv")))
data <- u(data)
data <- data[gpx != "gpx"]
data[, row := 1:.N]
data[, file := p0(country, "_", row, ".gpx")]
data[, code := p0("curl -o ", wdgpx2, file, " ", gpx)]
data
writeLines(data$code, p0("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/v03/Download_", country, ".bat"))




lf <- list.files(wd, full.names = T, pattern = "csv")
lf
scrapy <-  rbindlist(lapply(lf, function(file) {
  dt = fread(file, fill = TRUE)
  # further processing/filtering
}))
scrapy
scrapy <- scrapy[links %like% "gpx"]
scrapy <- unique(scrapy)
scrapy[, country := gsub("https://www.thecrag.com/de/klettern/(.*?)/.*", "\\1", links)]
scrapy
scrapy[, ID := 1:.N, country]
scrapy[, filename := p0(country, "_", ID, ".gpx")]
scrapy[, code := paste0("curl -o ", wdgpx, filename, " ", links)]
scrapy
# writeLines(scrapy$code, p0(wd, "Download_gpx.bat"))



# list gpx ----------------------------------------------------------------



ff <- data.table(filepath =list.files(wdgpx, full.names = T, pattern = "gpx"))
# ff <- data.table(filepath =list.files("C:/Users/doria/Downloads/Outdoor/Topo/thecrag/v02/gpx", full.names = T, pattern = "austria"))
ff[, filename := basename(filepath)]
ff[, country := tstrsplit(filename, "_")[[1]]]
ff[, .N, country]

create.dir(wd, "gpx_converted", "wdgpxc")

for(j in 1:length(ff$filepath)) {

  cat(j, "/", length(ff$filepath), "\n")

  data <- data.table(readGPX(ff$filepath[j])$waypoints)
  data
  data <- data[lon != "NA"]
  data[, coord := paste0(lon, lat)]
  data
  if(nrow(data) > 1){
    for(i in 2:nrow(data)) {
      if( data[i]$coord == data[1]$coord ) {
        data[i, lat := data[i-1]$lat]
        data[i, lon := data[i-1]$lon]
      }
    }
  }
  data
  data
  data[, name:= gsub(" )", ")", name)]
  data[, name:= gsub("^ *| *$", "", name)]
  data2 <- unique(data[, .(lon, lat)])
  data2
  for(i in 1:nrow(data2)) {
    data2[i, desc := paste0(data[lon == data2[i]$lon & lat == data2[i]$lat]$name, collapse = "\n")]
  }
  data2[, name := tstrsplit(desc, "\n", fill = "")[1]]
  data2
  
  # Add url
  temp <- data.table(readLines(ff$filepath[j]))
  temp[V1 %like% "Full text"]
  url <- gsub('.*href=\\"(.*)\\">.*', "\\1", temp[V1 %like% "Full text"]$V1)
  data2[, X := NULL]
  data2[, link := url]
  data2
  
  
  # add where
  data2[, name := p0(scrapy[filename == basename(ff$filepath[j])]$where, " -- ", name)]
  
  
  # export
  write.csv(data2, paste0(wdgpxc, gsub("gpx", "csv", ff$filename[j])))
  
  
  
  
  

}






lc <- u(ff$country)
lc


for(i in seq_along(lc)) {
  
  cat("Start Country:", lc[i])
  
  lf <- list.files(wdgpxc, full.names = T, pattern = lc[i])
  # lf[7891]
  # fread(lf[7891])
  
  
  all2 <-  rbindlist(lapply(lf, function(file) {
    dt = fread(file, fill = TRUE)
    # further processing/filtering
  }))
  
  all2BU <-  copy(all2)
  all2 <- copy(all2BU)
  all2[, V1 := NULL]
  all2
  all2[,.N, .(name, lat, lon)][N > 1]
  all2 <- all2[, .(.N, link = paste0(link, collapse= ";"), desc = paste0(desc, collapse= "\r\n")), .(lon, lat, name)]
  all2
  
  # remove name from desc to get desc == ""
  all2[, name2 := name]
  all2[, name2 := gsub("\\*", "\\\\*", name2)]
  all2[, name2 := gsub("\\+", "\\\\+", name2)]
  all2[, name2 := gsub("\\(", "\\\\(", name2)]
  all2[, name2 := gsub("\\)", "\\\\)", name2)]
  all2[, desc := gsub(name2, "", desc), by = name] # need this to avoid error with the name, it will be considered as regex ...
  all2
  
  # dupli.desc <- all2[,.N, .(name, lat, lon, link)][N > 1]$name
  # 
  # all2[c(desc == "" & name %in% dupli.desc)]
  # all2 <- all2[!c(desc == "" & name %in% dupli.desc)]
  all2[, name2 := NULL]
  # all2[, N := p0("A", 1:.N), .(lon, lat, name)]
  # all2
  # all2 <- dcast.data.table(all2, lon+lat+name+link~N, value.var = "desc", fill = "")
  # all2
  # all2[, desc := p0(name, A1, A2, A3, A4)]
  all2[, desc := p0(name, desc)]
  
  
  # all2 <- all2[all2[, .I[nch == max(nch)], .(name, lat, lon)]$V1]
  all2
  
  # all2 <- u(all2)
  
  all2[, lon := as.numeric(lon)]
  all2[, lat := as.numeric(lat)]
  all2 <- all2[!is.na(lat)]
  all2 <- all2[!is.na(lon)]
  all2
  setnames(all2, "link", "url")
  all2 <- all2[order(name, url)]
  # all2 <- all2[, .SD[1], .(name, lat, lon, desc)]
  
  all2[,.N, .(name, lat, lon)][N > 1] # 0
  all2[,.N, .(lat, lon)][N > 1] # 0
  all2[lat == all2[,.N, .(lat, lon)][N > 1][1]$lat & lon == all2[,.N, .(lat, lon)][N > 1][1]$lon]
  
  all2[, ndesc := nchar(desc)]
  all3 <- all2[all2[, .I[ndesc == max(ndesc)], .(lat, lon)]$V1]
  
  # ggplot(all2, aes(lon, lat))+geom_point()
  # ggplot(all3, aes(lon, lat))+geom_point()
  

  latslongs <- SpatialPointsDataFrame(coords=all3[, .(lon, lat)], data=all3[, .(desc, name, url)], proj4string =CRS("+proj=longlat + ellps=WGS84")) 
  newfile <- p0(wd, str_to_title(lc[i]), ".gpx")
  writeOGR(latslongs, dsn=newfile,
           dataset_options="GPX_USE_EXTENSIONS=yes",layer="waypoints",driver="GPX", overwrite_layer = T)
  data <- data.table(x = readLines(newfile, encoding = "UTF8"))
  data[grep("extensions>", x)]
  data <- data[grep("extensions>", x, invert = T)]
  data[, x := gsub("ogr:url", "url", x)]
  data
  
  data[, x := gsub("  <url", "<url", x)]
  write.table(data$x, newfile, quote = F, row.names = F, col.names = F)
  
  latslongs2 <- SpatialPointsDataFrame(coords=all2[, .(lon, lat)], data=all2[, .(name)], proj4string =CRS("+proj=longlat + ellps=WGS84")) 
  newfile <- p0(wd, str_to_title(lc[i]), "_QGIS.gpx")
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





