

# setup
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))


# SETUP -------------------------------------------------------------------

suppressWarnings(suppressMessages(library(geosphere)))
suppressWarnings(suppressMessages(library(svglite)))  # To save as SVG
suppressWarnings(suppressMessages(library(ggrepel)))


args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250822__Matterhorn_Ultraks/BU/rr_backup_Matterhorn_Ultraks_20250810-160600/gpx/")
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
  wd <- gsub("\\\\", "/", wd)
}
cat(yellow("\n[INFO] - wd:   ", wd, "\n"))
setwd(wd)





# User choices ------------------------------------------------------------


# comment if you do not know

# ylim1 <- 350
# ylim2 <- 550
# dist.wanted <- 110
# nylabel <- 100
# breaksx <- 5

ll$ContestName <- c("K110", "K85", "K65", "K42", "K35", "K25", "K15")
ll <- data.table(gpx=c("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/gpx/IATF25_K110_250423.gpx",
                       "file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/gpx/IATF25_K85_250423.gpx",
                       "file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/gpx/IATF25_K65_250423.gpx",
                       "file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/gpx/IATF25_K42.gpx",
                       "file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/gpx/IATF25_K35.gpx",
                       "file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/gpx/IATF25_K25.gpx",
                       "file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/gpx/IATF25_K15.gpx"),
                 Name = factor(ll$ContestName, levels = ll$ContestName),
                 dist.wanted = c(NA), # let NA for letting calculate the dist from gpx
                 
                 # color from color contest in event
                 # color = c("rgba(0,0,0,0.8)", #rgba(205, 20, 29,0.8)
                 #          "rgba(236, 42, 48,0.8)",
                 #          "rgba(248, 153, 68, 0.8)",
                 #          "rgba(250, 239, 53, 0.8)"
                 # ),
                 
                 breaksx=c(10, 10, 10, 5, 5, 5, 5),
                 nylabel=1000,
                 nxlabel=c(-5, -5, -4, -2, -2, -1, -1),
                 ContestID=c(8,1,2,3, 13, 4, 5))

BUpath <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/BU/rr_backup_Innsbruck_Alpine_Trailrun_Festival_2025_20250429-224212/")

# GPX --------------------------------------------------------------------

data <- data.table()
for(i in 1:nrow(ll)) {
  
  dt <- read.gpx(rP(ll$gpx[i]), type="trk")
  
  dt[, Name := ll$Name[i]]
  
  # Calculate dist btw points
  dt[, dist:=0]
  dt[2:nrow(dt), dist := distHaversine(dt[,.(lon, lat)])/1000]
  dt[, dist := cumsum(dist)]
  
  cat(yellow("[INFO] - dist gpx="), red(round(max(dt$dist), 2)), yellow("dist.wanted="), blue(ll$dist.wanted[i]), "\n")
  cat(yellow("[INFO] - dist gpx="), red(round(max(dt$dist), 2)), yellow("dist.wanted="), blue(ll$dist.wanted[i]), "\n")
  cat(yellow("[INFO] - dist gpx="), red(round(max(dt$dist), 2)), yellow("dist.wanted="), blue(ll$dist.wanted[i]), "\n")
  cat(yellow("[INFO] - dist gpx="), red(round(max(dt$dist), 2)), yellow("dist.wanted="), blue(ll$dist.wanted[i]), "\n")
  cat(yellow("[INFO] - dist gpx="), red(round(max(dt$dist), 2)), yellow("dist.wanted="), blue(ll$dist.wanted[i]), "\n")
  cat(yellow("[INFO] - dist gpx="), red(round(max(dt$dist), 2)), yellow("dist.wanted="), blue(ll$dist.wanted[i]), "\n")
  
  # correction distance if gpx is longer than expected
  if( !is.na(ll$dist.wanted[i]) ) {
    cat(red("[INFO] - Make dist ratio correction with dist.wanted"))
    ratio.correction <- max(dt$dist)/ll$dist.wanted[i]
    dt[, dist := dist/ratio.correction]
  }
  
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

data[data[, .I[dist==max(dist)], Name]$V1]



# TimingPoints ------------------------------------------------------------



# Contest -----------------------------------------------------------------

contest <- data.table(read.csv(p0(BUpath, "Contests.csv"), sep = "\t", header = T, fileEncoding = "utf-8"))
contest
contest <- contest[Name != ""]
contest[, Name := ifelse(is.na(NameShort), Name, NameShort)]
contest[, Start := hms::as_hms(Start)]
contest[, Dist := round(Length, 2)]
setnames(contest, "ID", "Contest")


# get color contest
contest[, ColorHEX := gsub(".*\\#(.{6}).*", "#\\1", Attributes)]
contest[, color := hex2rgba(ColorHEX, 0.8)]
ll <- dtjoin(ll, contest[, .(Name, color)])


# splits ------------------------------------------------------------------

splits <- data.table(read.csv(p0(BUpath, "splits.csv"), sep = "\t", header = T, fileEncoding = "utf-8"))
splits <- splits[, .(Contest, Name, TimingPoint, Distance, OrderPos, Label)]
splits <- splits[TimingPoint != ""]
splits


# bind contest and split
contest <- contest[Name %in% ll$ContestName]
contest
setnames(splits, c("Name", "Label"), c("SplitName", "Split"))
cd <- dtjoin(contest[, .(Contest, Name)], splits)
cd[, Split := gsub(",", ".", Split)]
cd[, Split := gsub(" km", "km", Split)]
cd[, Split := gsub(" ca. ", " - ", Split)]
cd[, dist := Distance / 1000 / 10000]

cd[cd[, .I[dist==max(dist)], Name]$V1] # Wichtig should feet the Contest.ength

cd <- cd[!grep("start|finish|spotter", SplitName, ignore.case = T)]
cd[cd[, .I[dist==max(dist)], Name]$V1]
cd[, .N, .(Name)]


data[, Split := NULL]
data[, Split := ""]
# assign them depending on dist
temp <- copy(data)
rm(data)
data <- data.table()

for(j in seq_along(ll$ContestName)) {
  if(length(u(cd$Name))==1) {
    cd2 <- copy(cd)
    temp2 <- copy(temp)
  } else {
   cd2 <- cd[Name == ll$ContestName[j]]
   temp2 <- temp[Name == ll$ContestName[j]]
  }
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

ll$ColorCID <- c("#FFFF00", "#0000FF", "#00FF00", "#FF0000", "#FF6600", "#6600FF", "#FF0066")

for(i in seq_along(ll$ContestName)) {
  # Create the elevation profile plot
  p <- ggplot(data[Name == ll$Name[i]], aes(x = dist, y = ele)) +
    geom_polygon(fill=ll$ColorCID[i])+
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
    theme(plot.margin = margin(r=10, t=10))+ # default = margin(t = 5.5, r = 5.5, b = 5.5, l = 5.5, unit = "pt")
    geom_point(data=data[Name == ll$Name[i]][Split!=""], size=3)+
    geom_label_repel(data=data[Name == ll$Name[i]][Split!=""],aes(label = Split), vjust = 0, hjust= 0, nudge_y = ll$nylabel[i], nudge_x=ll$nxlabel[i], direction = "y", size=3)+
    scale_x_continuous(expand = c(0, 0), limits = c(0, NA), breaks = seq(0, max(data$dist), by = ll$breaksx[i]))+  # Remove space before 0 on x-axis
    labs(x = "Km", y = "Elevation (m)", title=ll$ContestName[i])
  p
    
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
  create.dir(wd, "svg", "wdsvg")
  ggsave(p0(ll$ContestName[i],".svg"), plot = p2, device = "svg", width = 4000, height = 1000, units = "px")
  ggsave(p0(ll$ContestName[i],"Black.svg"), plot = p, device = "svg", width = 4000, height = 1000, units = "px")
  
  
  # Modification  ------------------------------------------------------------------
  
  
  t <- readLines(p0(ll$ContestName[i],".svg"))
  t <- gsub(ll$ColorCID[i], p0("url(#linear-gradient", i, ")"), t)
  t <- gsub('"', "'", t)
  t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)
  t <- c(t[1:2], p0("<defs><linearGradient id='linear-gradient", i, "' x1='0%' x2='", '"&[GradientLimit(', ll$ContestID[i], ')]&"%', "' y1='0%' y2='0%'><stop offset='100%' stop-color='", ll$color[i], "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.2)'></stop></linearGradient></defs>"), t[3:length(t)])
  t <- gsub("<rect width='100%' height='100%' style='stroke: none; fill: #FFFFFF;'/>", "<rect width='100%' height='100%' style='stroke: none; fill: none;'/>", t)
  t <- gsub("<rect x='(.*)' y='(.*)' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: #FFFFFF; fill: #FFFFFF;' />",
            "<rect x='\\1' y='\\2' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: none; fill: none;' />", t)
  
  write.table(t, p0(ll$ContestName[i],".svg"), row.names = F, col.names = F, quote = F)
  
  t <- readLines(p0(ll$ContestName[i],"Black.svg"))
  t <- gsub(ll$ColorCID[i], p0("url(#linear-gradient", i, ")"), t)
  t <- gsub('"', "'", t)
  t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)
  t <- c(t[1:2], p0("<defs><linearGradient id='linear-gradient", i, "' x1='0%' x2='", '"&[GradientLimit(', ll$ContestID[i], ')]&"%', "' y1='0%' y2='0%'><stop offset='100%' stop-color='", ll$color[i], "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.2)'></stop></linearGradient></defs>"), t[3:length(t)])
  t <- gsub("<rect width='100%' height='100%' style='stroke: none; fill: #FFFFFF;'/>", "<rect width='100%' height='100%' style='stroke: none; fill: none;'/>", t)
  t <- gsub("<rect x='(.*)' y='(.*)' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: #FFFFFF; fill: #FFFFFF;' />",
            "<rect x='\\1' y='\\2' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: none; fill: none;' />", t)
  
  write.table(t, p0(ll$ContestName[i],"Black.svg"), row.names = F, col.names = F, quote = F)
  
}


cat(green("--- END ---"))
