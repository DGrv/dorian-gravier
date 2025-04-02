

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
ylim2 <- 475
# dist.wanted <- 42.2
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
                    ))


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

# # cd <- data.table(read.table("clipboard", sep="\t", header=TRUE))
# cd <- structure(list(Split = c("Bürkliplatz - 4 km", "Bürkliplatz - 8 km",
#                                "Quaibrücke - 8.3 km", "Bellerivestrasse - 10 km", "Seestrasse - 15.8 km",
#                                "Meilen - 20 km", "Half Marathon - 21.1 km", "Meilen - 22.1 km",
#                                "Küsnacht - 30 km", "Küsnacht Goldbach - 31.2 km", "Quaibrücke - 36 km",
#                                "Mythenquai - 37.2 km", "Sihlstrasse - 40 km", "Bürkliplatz - 40.9 km",
#                                "Quaibrücke - 42 km"), dist = c(4, 8, 8.3, 10, 15.8, 20, 21.1,
#                                                              22.1, 30, 31.2, 36, 37.2, 40, 40.9, 42)), row.names = c(NA, -15L
#                                                              ), class = c("data.table", "data.frame"))
# cd
# 
# data[, Split := NULL]
# data[, Split := ""]
# # assign them depending on dist
# for(i in 1:nrow(cd)){
#   t <- which.min(abs(data$dist - cd$dist[i]))
#   data[t, Split := cd$Split[i]]
# }
# data[,.N, Split]




# Plots -------------------------------------------------------------------

if( !exists("nylabel") ) {
  nylabel <- 0
}
if( !exists("breaksx") ) {
  breaksx <- 10
}

lcolor <- c("#FFFF00", "#0000FF", "#00FF00", "#FF0000", "#FF6600", "#6600FF")

# Create the elevation profile plot
p <- ggplot(data, aes(x = dist, y = ele, fill = Name)) +
  geom_polygon()+
  geom_line(linewidth = 0.2)+
  scale_fill_manual(values = lcolor, guide = "none")+
  # scale_fill_discrete()+
  # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*1), x = dist - (0.005*1)), size = 0.1)+
  # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*2), x = dist - (0.005*2)), size = 0.1)+
  # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*3), x = dist - (0.005*3)), size = 0.1)+
  # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*4), x = dist - (0.005*4)), size = 0.1)+
  # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*5), x = dist - (0.005*5)), size = 0.1)+
  # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*6), x = dist - (0.005*6)), size = 0.1)+
  # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*7), x = dist - (0.005*7)), size = 0.1)+
  # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*8), x = dist - (0.005*8)), size = 0.1)+
  # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*9), x = dist - (0.005*9)), size = 0.1)+
  # geom_point(data=data[Split!=""], size=3)+
  # geom_label_repel(data=data[Split!=""],aes(label = Split), vjust = 0, hjust= 0, nudge_y = nylabel, nudge_x=-2, direction = "y", size=3)+
  theme_set(theme_bw())+
  scale_x_continuous(expand = c(0, 0), limits = c(0, NA), breaks = seq(0, max(data$dist), by = breaksx))+  # Remove space before 0 on x-axis
  labs(x = "", y = "")+
  facet_wrap(Name~., scales = "free_x")
p
  
if( exists("ylim2") ) {
  p <- p+coord_cartesian(ylim=c(NA, ylim2))
}
p

# Save as SVG
ggsave("temp.svg", plot = p, device = "svg", width = 4000, height = 1000, units = "px")


# Modification  ------------------------------------------------------------------

t <- readLines("temp.svg")
t <- gsub('"', "'", t)
for(i in 1:nrow(ll)){
  t %like% lcolor[i]
  t <- gsub(lcolor[i], p0("url(#linear-gradient", i, ")"), t)
  t <- c(t[1:2], p0("<defs><linearGradient id='linear-gradient", i, "' x1='0%' x2='", '"&[GradientLimit', i, ']&"%', "' y1='0%' y2='0%'><stop offset='100%' stop-color='", ll$color[i], "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.2)'></stop></linearGradient></defs>"), t[3:length(t)])
  # t[, raw2:= gsub("<defs>(.*)",
  #                 p0("<defs><linearGradient id='linear-gradient' x1='0%' x2='20%' y1='0%' y2='0%'><stop offset='100%' stop-color='", ll$color[i], "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.4)'></stop></linearGradient>\1"),
  #                 raw2)]
}
t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)


write.table(t, "temp.svg", row.names = F, col.names = F, quote = F)
# file.remove("temp.svg")

