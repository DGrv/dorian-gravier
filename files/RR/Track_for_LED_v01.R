

tp
ll
data0

theme_set(theme_void())
# theme_set(theme(plot.background = element_rect(fill = "black"),
#                 panel.background = element_rect(fill="black"),
#                 panel.grid.major = element_line(color = 'black'),
#                 panel.grid.minor = element_line(color = 'black'),
#                 axis.text=element_text(color="black")))

setwd(wd)
create.dir(wd, "TrackPNG", "wd2")

for(i in 1:length(u(data0$file)) ) {
  
  tempTP <- tp[grepl("start|Finish", TimingPoint, ignore.case = T)]
  debug.easy(nrow(tempTP) > 1, "several finish ? nrow > 1")
  
  temp <- data0[file == u(file)[i]]
  temp[, latSF := tempTP$lat]
  temp[, lonSF := tempTP$lon]
  temp[, latdiff := abs(latSF-lat)]
  temp[, londiff := abs(lonSF-lon)]
  tempTP[, lat := temp[latdiff == min(latdiff)]$lat]
  tempTP[, lon := temp[londiff == min(londiff)]$lon]
  
  
  a <- ggplot(temp, aes(lon, lat))+
    geom_path(size=4, color = "#0E3A2F")+
    geom_point(data = tempTP[grepl("start|Finish", TimingPoint, ignore.case = T)], size = 30, color = "#0E3A2F")+
    geom_point(data = tempTP[grepl("start|Finish", TimingPoint, ignore.case = T)], size = 15, color = "#78FAAE")
  a
  
  fout <- p0(gsub(".gpx$", ".png", u(data0[file == u(file)[i]]$file)))
  printfast(a, fout, ext = "png", height = 600, width = 600*1.41) # 1.41 is ration lat lon
  
  
  system(p0('magick "', fout, '" -background white -alpha background -alpha off -bordercolor white -border 1 -transparent white "', fout, '"'))

}
