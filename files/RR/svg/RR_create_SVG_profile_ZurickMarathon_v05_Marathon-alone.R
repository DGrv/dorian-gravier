

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


# GPX --------------------------------------------------------------------

# data <- read.gpx(rP("file:///C:/Users/doria/Downloads/gdrive/RR/2024/20240810_SwissAlps100/Course/Swiss%20Alps%20100%20-%20160KM.gpx"), type="trk")
data <- read.gpx(rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250413__ZuerichMarathon/Course/zhm2025marathon.gpx"), type="trk")

# Calculate dist btw points
data[, dist:=0]
data[2:nrow(data), dist := distHaversine(data[,.(lon, lat)])/1000]
data[, dist := cumsum(dist)]

# correction distance if gpx is longer than expected
if( exists("dist.wanted") ) {
  ratio.correction <- max(data$dist)/dist.wanted
  data[, dist := dist/ratio.correction]
} 

# trim ele
if( exists("ylim1") ) {
  data[1, ele := ylim1]
  data[nrow(data), ele := ylim1]
} else {
  data[1, ele := 0]
  data[nrow(data), ele := 0]
}



# TimingPoints ------------------------------------------------------------

# cd <- data.table(read.table("clipboard", sep="\t", header=TRUE))
cd <- structure(list(Split = c("Bürkliplatz - 4 km", "Bürkliplatz - 8 km",
                               "Quaibrücke - 8.3 km", "Bellerivestrasse - 10 km", "Seestrasse - 15.8 km",
                               "Meilen - 20 km", "Half Marathon - 21.1 km", "Meilen - 22.1 km",
                               "Küsnacht - 30 km", "Küsnacht Goldbach - 31.2 km", "Quaibrücke - 36 km",
                               "Mythenquai - 37.2 km", "Sihlstrasse - 40 km", "Bürkliplatz - 40.9 km",
                               "Quaibrücke - 42 km"), dist = c(4, 8, 8.3, 10, 15.8, 20, 21.1,
                                                             22.1, 30, 31.2, 36, 37.2, 40, 40.9, 42)), row.names = c(NA, -15L
                                                             ), class = c("data.table", "data.frame"))
cd

data[, Split := NULL]
data[, Split := ""]
# assign them depending on dist
for(i in 1:nrow(cd)){
  t <- which.min(abs(data$dist - cd$dist[i]))
  data[t, Split := cd$Split[i]]
}
data[,.N, Split]



# Plots -------------------------------------------------------------------

if( !exists("nylabel") ) {
  nylabel <- 0
}
if( !exists("breaksx") ) {
  breaksx <- 10
}

# Create the elevation profile plot
p <- ggplot(data, aes(x = dist, y = ele)) +
  geom_polygon(fill="blue")+
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
  geom_point(data=data[Split!=""], size=3)+
  geom_label_repel(data=data[Split!=""],aes(label = Split), vjust = 0, hjust= 0, nudge_y = nylabel, nudge_x=-2, direction = "y", size=3)+
  scale_x_continuous(expand = c(0, 0), limits = c(0, NA), breaks = seq(0, max(data$dist), by = breaksx))+  # Remove space before 0 on x-axis
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
setwd(rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250413__ZuerichMarathon/Course/svg/v05_Marathon"))
ggsave("Marathon.svg", plot = p2, device = "svg", width = 4000, height = 1000, units = "px")
ggsave("MarathonBlack.svg", plot = p, device = "svg", width = 4000, height = 1000, units = "px")


# Modification  ------------------------------------------------------------------

t <- readLines("Marathon.svg")
t <- gsub("#0000FF", "url(#linear-gradient)", t)
t <- gsub('"', "'", t)
t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)
t <- gsub("<defs>", "<defs><linearGradient id='linear-gradient' x1='0%' x2='20%' y1='0%' y2='0%'><stop offset='100%' stop-color='rgba(20, 136, 202,0.8)'></stop><stop offset='100%' stop-color='rgba(175, 223, 250,0.4)'></stop></linearGradient>", t)
t <- gsub("<rect width='100%' height='100%' style='stroke: none; fill: #FFFFFF;'/>", "<rect width='100%' height='100%' style='stroke: none; fill: none;'/>", t)
t <- gsub("<rect x='(.*)' y='(.*)' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: #FFFFFF; fill: #FFFFFF;' />",
          "<rect x='\\1' y='\\2' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: none; fill: none;' />", t)

write.table(t, "Marathon.svg", row.names = F, col.names = F, quote = F)

t <- readLines("MarathonBlack.svg")
t <- gsub("#0000FF", "url(#linear-gradient)", t)
t <- gsub('"', "'", t)
t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)
t <- gsub("<defs>", "<defs><linearGradient id='linear-gradient' x1='0%' x2='20%' y1='0%' y2='0%'><stop offset='100%' stop-color='rgba(20, 136, 202,0.8)'></stop><stop offset='100%' stop-color='rgba(175, 223, 250,0.4)'></stop></linearGradient>", t)
t <- gsub("<rect width='100%' height='100%' style='stroke: none; fill: #FFFFFF;'/>", "<rect width='100%' height='100%' style='stroke: none; fill: none;'/>", t)
t <- gsub("<rect x='(.*)' y='(.*)' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: #FFFFFF; fill: #FFFFFF;' />",
          "<rect x='\\1' y='\\2' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: none; fill: none;' />", t)

write.table(t, "MarathonBlack.svg", row.names = F, col.names = F, quote = F)

