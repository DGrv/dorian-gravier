

# setup
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))


# SETUP -------------------------------------------------------------------

library(geosphere)
library(svglite)  # To save as SVG
library(ggrepel)

wd <- rP("file:///C:/Users/doria/Downloads")
setwd(wd)


# User choices ------------------------------------------------------------


# comment if you do not know

ylim1 <- 350
ylim2 <- 550
dist.wanted <- 42.2
nylabel <- 100
breaksx <- 5
lName <- c("Marathon", 
           "Halbmarathon",
           "10km"
)
ll <- data.table(gpx=c("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250413__ZuerichMarathon/Course/zhm2025marathon.gpx",
                       "file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250413__ZuerichMarathon/Course/zhm2025hm.gpx",
                       "file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250413__ZuerichMarathon/Course/zhm202510km.gpx"),
                 Name = factor(lName, levels = lName),
                 dist.wanted = c(42.2,
                                 21.1,
                                 10),
                 color = c("rgba(20, 136, 202,0.8)",
                           "rgba(149, 193, 31,0.8)",
                           "rgba(229, 0, 91,0.8)"
                 ),
                 breaksx=c(5, 5, 2),
                 nylabel=100,
                 nxlabel=c(-2, -1, -0.5))



# GPX --------------------------------------------------------------------

data <- data.table()
for(i in 1:nrow(ll)) {
  
  dt <- read.gpx(rP(ll$gpx[i]), type="trk")
  
  dt[, Name := ll$Name[i]]
  
  # Calculate dist btw points
  dt[, dist:=0]
  dt[2:nrow(dt), dist := distHaversine(dt[,.(lon, lat)])/1000]
  dt[, dist := cumsum(dist)]
  
  # correction distance if gpx is longer than expected
  # if( exists("dist.wanted") ) {
  ratio.correction <- max(dt$dist)/ll$dist.wanted[i]
  dt[, dist := dist/ratio.correction]
  # } 
  
  # trim ele
  if( exists("ylim1") ) {
    dt[1, ele := ylim1]
    dt[nrow(dt), ele := ylim1]
  } else {
    dt[1, ele := 0]
    dt[nrow(dt), ele := 0]
  }
  
  
  data <- rbind(data, dt)
  
}
data



# TimingPoints ------------------------------------------------------------

# cd <- data.table(read.table("clipboard", sep="\t", header=TRUE))
cd <- structure(list(Split = c("Bürkliplatz - 4 km", "Bürkliplatz - 8 km", 
                               "Quaibrücke - 8.3 km", "Bellerivestrasse - 10 km", "Seestrasse - 15.8 km", 
                               "Meilen - 20 km", "Half Marathon - 21.1 km", "Meilen - 22.1 km", 
                               "Küsnacht - 30 km", "Küsnacht Goldbach - 31.2 km", "Quaibrücke - 36 km", 
                               "Mythenquai - 37.2 km", "Sihlstrasse - 40 km", "Bürkliplatz - 40.9 km", 
                               "Quaibrücke - 42 km", "Bellerivestrasse - 1.7 km", "Wendepunkt HM - 7.5 km", 
                               "Küsnacht - 8.8 km", "Küsnacht Goldbach - 10 km", "Quaibrücke - 15 km", 
                               "Mythenquai - 16.2 km", "Sihlstrasse - 19.1 km", "Bürkliplatz - 20 km", 
                               "Quaibrücke - 20.9 km", "Quaibrücke - 3.9 km", "Mythenquai - 5 km", 
                               "Sihlstrasse - 8 km", "Bürkliplatz - 8.9 km", "Quaibrücke - 9.8 km"
), dist = c(4, 8, 8.3, 10, 15.8, 20, 21.1, 22.1, 30, 31.2, 36, 
          37.2, 40, 40.9, 42, 1.7, 7.5, 8.8, 10, 15, 16.2, 19.1, 20, 20.9, 
          3.9, 5, 8, 8.9, 9.8), Name = c("Marathon", "Marathon", "Marathon", 
                                         "Marathon", "Marathon", "Marathon", "Marathon", "Marathon", "Marathon", 
                                         "Marathon", "Marathon", "Marathon", "Marathon", "Marathon", "Marathon", 
                                         "Halbmarathon", "Halbmarathon", "Halbmarathon", "Halbmarathon", 
                                         "Halbmarathon", "Halbmarathon", "Halbmarathon", "Halbmarathon", 
                                         "Halbmarathon", "10km", "10km", "10km", "10km", "10km")), row.names = c(NA, 
                                                                                                                 -29L), class = c("data.table", "data.frame"))
cd

data[, Split := NULL]
data[, Split := ""]
# assign them depending on dist
temp <- copy(data)
rm(data)
data <- data.table()

for(j in seq_along(lName)) {
  cd2 <- cd[Name == lName[j]]
  temp2 <- temp[Name == lName[j]]
  for(i in 1:nrow(cd2)) {
    t <- which.min(abs(temp2$dist - cd2$dist[i]))
    temp2[t, Split := cd2$Split[i]]
  }
  data <- rbind(data, temp2)
}

data[Split != "", .N, .(Name, Split)]

# Plots -------------------------------------------------------------------

# if( !exists("nylabel") ) {
#   nylabel <- 0
# }
# if( !exists("breaksx") ) {
#   breaksx <- 10
# }

lcolor <- c("#FFFF00", "#0000FF", "#00FF00", "#FF0000", "#FF6600", "#6600FF")

for(i in seq_along(lName)) {
  # Create the elevation profile plot
  p <- ggplot(data[Name == ll$Name[i]], aes(x = dist, y = ele)) +
    geom_polygon(fill=lcolor[i])+
    geom_line(linewidth = 0.2)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*1), x = dist - (0.005*1)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*2), x = dist - (0.005*2)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*3), x = dist - (0.005*3)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*4), x = dist - (0.005*4)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*5), x = dist - (0.005*5)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*6), x = dist - (0.005*6)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*7), x = dist - (0.005*7)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*8), x = dist - (0.005*8)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*9), x = dist - (0.005*9)), size = 0.1)+
    theme(
      # panel.border = element_blank(),
      # panel.grid.major = element_blank(),
      # panel.grid.minor = element_blank(),
      # plot.background = element_rect(fill = "#353535", color = "#353535"),
      # panel.background = element_rect(fill = "#353535"),
      axis.ticks.length = unit(0.1, "inches"))+
    geom_point(data=data[Name == ll$Name[i]][Split!=""], size=3)+
    geom_label_repel(data=data[Name == ll$Name[i]][Split!=""],aes(label = Split), vjust = 0, hjust= 0, nudge_y = ll$nylabel[i], nudge_x=ll$nxlabel[i], direction = "y", size=3)+
    scale_x_continuous(expand = c(0, 0), limits = c(0, NA), breaks = seq(0, max(data$dist), by = ll$breaksx[i]))+  # Remove space before 0 on x-axis
    labs(x = "Km", y = "Elevation (m)")
    
  if( exists("ylim2") ) {
    p <- p+coord_cartesian(ylim=c(NA, ylim2))
  }
  p
  p2 <- p + theme(
      text = element_text(color = "white"),
      axis.text.y = element_text(colour = "white"),
      axis.text.x = element_text(colour = "white"),
      axis.ticks.y = element_line(color = "white"),
      axis.ticks.x = element_line(color = "white"))
  p2
  
  # Save as SVG
  setwd(rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250413__ZuerichMarathon/Graphics/svg/v05_All"))
  ggsave(p0(lName[i],".svg"), plot = p2, device = "svg", width = 4000, height = 1000, units = "px")
  ggsave(p0(lName[i],"Black.svg"), plot = p, device = "svg", width = 4000, height = 1000, units = "px")
  
  
  # Modification  ------------------------------------------------------------------
  
  
  t <- readLines(p0(lName[i],".svg"))
  t <- gsub(lcolor[i], p0("url(#linear-gradient", i, ")"), t)
  t <- gsub('"', "'", t)
  t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)
  t <- c(t[1:2], p0("<defs><linearGradient id='linear-gradient", i, "' x1='0%' x2='", '"&[GradientLimit(', i, ')]&"%', "' y1='0%' y2='0%'><stop offset='100%' stop-color='", ll$color[i], "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.2)'></stop></linearGradient></defs>"), t[3:length(t)])
  t <- gsub("<rect width='100%' height='100%' style='stroke: none; fill: #FFFFFF;'/>", "<rect width='100%' height='100%' style='stroke: none; fill: none;'/>", t)
  t <- gsub("<rect x='(.*)' y='(.*)' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: #FFFFFF; fill: #FFFFFF;' />",
            "<rect x='\\1' y='\\2' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: none; fill: none;' />", t)
  
  write.table(t, p0(lName[i],".svg"), row.names = F, col.names = F, quote = F)
  
  t <- readLines(p0(lName[i],"Black.svg"))
  t <- gsub(lcolor[i], p0("url(#linear-gradient", i, ")"), t)
  t <- gsub('"', "'", t)
  t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)
  t <- c(t[1:2], p0("<defs><linearGradient id='linear-gradient", i, "' x1='0%' x2='", '"&[GradientLimit', i, ']&"%', "' y1='0%' y2='0%'><stop offset='100%' stop-color='", ll$color[i], "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.2)'></stop></linearGradient></defs>"), t[3:length(t)])
  t <- gsub("<rect width='100%' height='100%' style='stroke: none; fill: #FFFFFF;'/>", "<rect width='100%' height='100%' style='stroke: none; fill: none;'/>", t)
  t <- gsub("<rect x='(.*)' y='(.*)' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: #FFFFFF; fill: #FFFFFF;' />",
            "<rect x='\\1' y='\\2' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: none; fill: none;' />", t)
  
  write.table(t, p0(lName[i],"Black.svg"), row.names = F, col.names = F, quote = F)
  
}
