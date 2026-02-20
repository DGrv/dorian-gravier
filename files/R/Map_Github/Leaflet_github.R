

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

wdout <- rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/html_output/")




# read gpx ----------------------------------------------------------------

ll <- rbind(data.table(path = list.files(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Bike_trip_2022/"), pattern = "gpx$", full = T, recursive = T)),
            data.table(path = list.files(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Bike_trip_2025/"), pattern = "gpx$", full = T, recursive = T)))
        

ll2 <- data.table(path = list.files(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Leaflet/"), pattern = "gpx$", full = T, recursive = T))
ll <- rbind(ll, ll2)
ll[, file := basename(path)]
ll[, What := basename(dirname(path))]

ll[, colorID := .GRP, What]
ll[, .N, colorID]
ll[, color := brewer.pal(n = length(u(ll$colorID)), name = "Set1")[colorID]]
# ll[, color := qualitative_hcl(length(u(ll$colorID)), palette = "Dark 3")[colorID]]
ll[, .N, .(colorID, color)]

ll[, desc := p0(file, '<br><a target="_blank" href="https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/gpx/', What, "/", file, ' download>Download</a>')]
ll <- ll[!What %like% "time|Project|Stop"]
ll[, .N, What]
ll[What %like% "Bike", What := "Bike"]
ll[, .N, What]

data <- data.table()
for (i in seq_along(ll$path)) {
  cat(i, "- Try:", ll$file[i])
  temp <- read.gpx(ll$path[i], type="trk")
  temp[, file := ll$file[i]]
  temp[, What := ll$What[i]]
  data <- rbind(data, temp, fill = T)
  cat(green(" - Read done\n"))
}
data[, uname := p0(file, " - ", name)]
dataBU <- copy(data)
# # Old
# data <- data.table()
# for(i in seq_along(ll)) {
#   temp <- read.gpx(ll[i], type="wpt")
#   data <- rbind(data, temp)
# }
# brewer.pal(n = 2, name = "Set1")


source(p0(rootpath, "Map_Github/Map_providers.R"))

# Add layers --------------------------------------------------------------

groupLayers <- c(u(ll$What), "Huts", "Wild Camping")


u(data$uname)
for(i in seq_along(u(data$name)) ) {
  
  data1 <- st_as_sf(x = data[uname == u(data$uname)[i]],                         
                    coords = c("lon", "lat"))
  data2 <- data1 %>%
    st_combine() %>%
    st_cast(to = "LINESTRING") %>%
    st_sf()
  
  ll2 <- ll[file == data[uname == u(data$uname)[i]]$file[1]]
  
  m <- m %>%
    addPolylines(data = data2,
                 group = ll2$What,
                 color = ll2$color,
                 popup = ll2$desc,
                 opacity=1,
                 weight=4
                 # label = ~name
                 )
}

# icon/hutte.png
hutte <- data.table(read.csv(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/DAV_hutte_coord.csv")))
hutte[, popup := p0(Name, '<br><a href="', link, '">Infos</a>')]

zelt <- read.gpx(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/gpx/Zelt.gpx"), type = "wpt")


rrIcons <- iconList(
  hut = makeIcon(
    iconUrl = "https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/icon/hutte.png",
    iconWidth = 36,
    iconHeight = 36
  ),
  camp = makeIcon(
    iconUrl = "https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/icon/camping.png",
    iconWidth = 36,
    iconHeight = 36
  )
)

m <- m %>%
  addMarkers(data = hutte, lng = ~lon, lat = ~lat,
                   group = "Huts",
                   # color = "#ff3355",
                   icon = rrIcons["hut"],
                   popup = ~popup
                   # popupOptions = popupOptions(autoClose = TRUE, offset=c(0, -10)),
                   # opacity = 1,
                   # radius = 4,
                   # fillOpacity = 0.5
                   ) %>%
  addMarkers(data = zelt, lng = ~lon, lat = ~lat,
                   group = "Wild Camping",
                   # color = "#ff3355",
                   icon = rrIcons["camp"]
                   # popup = ~SplitName,
                   # popupOptions = popupOptions(autoClose = TRUE, offset=c(0, -30)),
                   # opacity = 1,
                   # radius = 4,
                   # fillOpacity = 0.5
                   )


# output ------------------------------------------------------------------

# m <- setView(map=m, lng=(max(data$lon)-min(data$lon))/2+min(data$lon),
#              lat=(max(data$lat)-min(data$lat))/2+min(data$lat),
#              zoom = 6, options = )

m <-  m %>% 
  setView(5.142, 44.536,  zoom = 6) %>%
  addLayersControl(
    baseGroups = mapGroups, 
    overlayGroups = groupLayers,
    options = layersControlOptions(collapsed=TRUE)) %>%
  addFullscreenControl() %>%
  addHash() %>%
  addSearchOSM() %>%
  addControlGPS() %>%
  hideGroup("Huts")


# %>% 
      # hideGroup(groupslayer[3:length(groupslayer)]) #hide all groups except the 1st and 2nd )
cat("\nLeaflet ready")

setwd(wdout)

export.gpx2(data[What == "Bike"],
            rP("file:///C:/Users/doria/Downloads/Outdoor/Gpx/All_Bikes_for_gpxstudio.gpx"), 
            layer.type = "trk",
            segment.column.name = "uname")


outfilename <- "Leaflet.html"

saveWidget(m, file=outfilename)


# change few thing in the html

t <- readLines(outfilename)
idwidget <- gsub('<script type\\="application/htmlwidget-sizing" data-for\\="(.*)">\\{"viewer".*', "\\1", t[length(t)-2])

# change meta that is good phones 
# t[t %like% "<meta"]
t <- gsub(t[t %like% "<meta"], '<meta charset="utf-8" />\n<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no" />', t)

t <- gsub("<title>leaflet</title>", p0("<title>", gsub(".html", "", outfilename), "</title>"), t)



# Mouse position ---------------------------------------------------------


tadd <- readLines(rP("file:///C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/RR/Javascript/Copy_MousePosition_v01.html"))
tadd <- gsub("\\#idwidget", p0("#", idwidget), tadd)
t <- c(t[1:(length(t)-2)], tadd, t[(length(t)-1):length(t)])
write.table(t, outfilename, row.names = F, col.names = F, quote = F)



cat("\nLeaflet DONE :)\n")




