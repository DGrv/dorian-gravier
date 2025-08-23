
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))

suppressWarnings(suppressMessages(library(leaflet)))
suppressWarnings(suppressMessages(library(leaflet.extras)))
suppressWarnings(suppressMessages(library(httr2)))
suppressWarnings(suppressMessages(library(htmlwidgets)))


apikey <- readLines(rP("file:///C:/Users/doria/Downloads/secret/apiRR.txt"))[1]

# repeat {
# Add custom header
req1 <- request("https://rest.devices.raceresult.com/token") |> 
  req_headers("apikey" = apikey) |> 
  req_body_raw(body = "", type = "application/json")

resp1 <- req_perform(req1)
# resp1 |> rdataesp_raw()  


resp1b <-  resp1 |> resp_body_json() |> unlist() |> t() |> data.table()
resp1b

# req2 <- request("https://rest.devices.raceresult.com/customers/846/devices?connected=true") |> 
req2 <- request("https://rest.devices.raceresult.com/customers/846/devices") |>
  req_auth_bearer_token(resp1b$access_token)

resp2 <- req_perform(req2)

# debug
writeLines(resp_body_string(resp2), rP("file:///C:/Users/doria/Downloads/resp2.json"))

resp2b <- data.table(jsonlite::fromJSON(resp_body_string(resp2), flatten = T)$Devices)
resp2b

rm(req1, req2)


resp2b
resp2b[is.na(DeviceID)==T]
RRdevices <- resp2b[, .(DeviceID = ifelse(is.na(DeviceID)==T, System.DeviceID, DeviceID), 
                  DeviceType,
                  DeviceName =  ifelse(is.na(DeviceID)==T, System.DeviceName, DeviceName),
                  BatteryCharge,
                  Temperature = ifelse(is.na(DeviceID)==T, System.Temperature, Temperature),
                  Connected = ifelse(is.na(DeviceID)==T, ifelse(ConnStatus==0, F, T), Connected),
                  Received = as.POSIXct(gsub("(.*)\\..*", "\\1",ifelse(is.na(DeviceID)==T, gsub("T", " ", gsub("Z", "", Time.Received)), gsub("T", " ", gsub("Z", "", Received))))),
                  RealTime = as.POSIXct(gsub("(.*)\\..*", "\\1",ifelse(is.na(DeviceID)==T, gsub("T", " ", gsub("Z", "", Time.Time)), gsub("T", " ", gsub("Z", "", RealTime))))),
                  UTCOffset,
                  FileNo,
                  TimeZoneName,
                  Firmware = ifelse(is.na(DeviceID)==T, System.Firmware, DecoderStatus.Firmware),
                  RecordsCount,
                  time = Time.Time,
                  flag = Position.Flag,
                  lon = Position.Longitude, 
                  lat = Position.Latitude, 
                  Power = DecoderStatus.HasPower,
                  ReadHealthy = DecoderStatus.ReaderIsHealthy,
                  Antennas = DecoderStatus.Antennas,
                  ReaderStatus = TrackboxStatus.ReaderStatus)]
RRdevices <- RRdevices[,DeviceType2 := substr(DeviceID, 1, 1)]
RRdevices
RRdevicesBU <- copy(RRdevices)
# RRdevices <- copy(RRdevicesBU)
RRdevices[DeviceType2=="U", .N, Connected]

        RRdevices[DeviceID %in% c("T-20342")]
        resp2b[DeviceID %in% c("T-20342", "T-23792")]
        resp2b[DeviceID %in% c("T-20342")][, names(resp2b)[names(resp2b) %like% "Connected"], with =F]
        
        
temp <- resp2b[, .(DeviceID, Received, Time.Received, RealTime, Time.Time)]
# temp[, Received2 := gsub("(.*)\\..*", "\\1",ifelse(is.na(DeviceID)==T, gsub("T", " ", gsub("Z", "", Time.Received)), gsub("T", " ", gsub("Z", "", Received))))]
temp[, RealTime2 := ifelse(is.na(DeviceID)==T, gsub("T", " ", gsub("Z", "", Time.Time)), gsub("T", " ", gsub("Z", "", RealTime)))]
temp[, Received2 := as.POSIXct(gsub("(.*)\\..*", "\\1",ifelse(is.na(DeviceID)==T, gsub("T", " ", gsub("Z", "", Time.Received)), gsub("T", " ", gsub("Z", "", Received)))), format = "%F %T")]
# temp[, RealTime2 := ifelse(is.na(DeviceID)==T, as.POSIXct(gsub("T", " ", gsub("Z", "", Time.Time)), format = "%F %T"), as.POSIXct(gsub("T", " ", gsub("Z", "", RealTime)), format = "%F %T"))]
temp



# cdl <- c("T-21172",
#          "T-21154",
#          "T-21112",
#          "T-21030",
#          "T-21051",
#          "T-21122",
#          "T-20967",
#          "T-21046",
#          "T-21179",
#          "T-21083",
#          "T-21144",
#          "T-21079")
# RRdevices[DeviceID %in% cdl]



RRdevices <- RRdevices[is.na(DeviceID)==F]
dGMT <- RRdevices[TimeZoneName == "GMT"]$DeviceID
RRdevices[TimeZoneName == "GMT", RealTime := RealTime + 7200]
RRdevices[TimeZoneName == "GMT", Received := Received + 7200]
RRdevices[is.na(Power), Power := FALSE]
RRdevices[Connected == FALSE, DeviceID := p0(DeviceID, " - Disconnected")]
RRdevices[, popup := p0(DeviceID,
                    "<br>Power: ",  Power,
                    "<br>", BatteryCharge, 
                    "%<br>LastRec: ", Received, "<br>Rsta: ", ReaderStatus)]
RRdevices <- RRdevices[Received > "2025-01-01"]

RRdevices[, .N, DeviceType]
RRdevices[Connected == T]





# test 2 days ago
RRdevices[Received > "2025-05-16"]


setorder(RRdevices, -Connected)

RRdevices[, color := ifelse(Connected == FALSE, 
                        "red", 
                        ifelse(DeviceType == "Decoder",
                               "green", 
                               "blue"))]
RRdevices[, icon := ifelse(Connected == FALSE, 
                       'close',
                       ifelse(Power == TRUE,
                              'battery-charging', 
                              ifelse(BatteryCharge > 75, 
                                     'battery-full', 
                                     ifelse(BatteryCharge > 50, 
                                            'battery-half',
                                            'battery-empty'))))]



# check providers https://leaflet-extras.github.io/leaflet-providers/preview/
m <- leaflet() %>%
  addProviderTiles('OpenTopoMap', options = providerTileOptions(maxZoom = 19),
                   group = "OpenTopoMap") %>%
  addTiles(urlTemplate = "https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg",
           attribution = '&copy; <a href="https://www.geo.admin.ch/de/about-swiss-geoportal/impressum.html#copyright">swisstopo</a>',
           group = "SwissTopo") %>%
  addTiles(urlTemplate = "https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.swissimage/default/current/3857/{z}/{x}/{y}.jpeg",
           attribution = '&copy; <a href="https://www.geo.admin.ch/de/about-swiss-geoportal/impressum.html#copyright">swisstopo</a>',
           group = "SwissTopo Sat")


# output ------------------------------------------------------------------

groupslayer <- c("DevicesOnline", "DevicesOffline")

m <-  m %>%
  # addMarkers(data = tp, lng = ~lon, lat = ~lat, popup = ~TimingPoint, label = ~TimingPoint, group = "TimingPoints") %>%
  # addMarkers(data = RRdevices[Connected == T], lng = ~lon, lat = ~lat, popup = ~DeviceID, label = ~DeviceID, group = "DevicesOnline",
  #            icon= icons(iconUrl ="https://github.com/DGrv/dorian-gravier/blob/master/files/RR/Images/loc_green_small.png?raw=true",
  #                        iconAnchorX=11, iconAnchorY=25)) %>%
  # addMarkers(data = RRdevices[Connected == F], lng = ~lon, lat = ~lat, popup = ~DeviceID, label = ~DeviceID, group = "DevicesOnline",
  #            icon= icons(iconUrl = "https://github.com/DGrv/dorian-gravier/blob/master/files/RR/Images/loc_red_small.png?raw=true",
  #                        iconAnchorX=11, iconAnchorY=25)) %>%
  # setView((max(RRdevices$lon, na.rm = T)-min(RRdevices$lon, na.rm = T))/2+min(RRdevices$lon, na.rm = T),
  #         (max(RRdevices$lat, na.rm = T)-min(RRdevices$lat, na.rm = T))/2+min(RRdevices$lat, na.rm = T), 
  #         zoom = 12) %>%
  setView(7.998, 46.683, zoom=7) %>%
  addLayersControl(
    baseGroups = c("OpenTopoMap", "SwissTopo", "SwissTopo Sat"), 
    overlayGroups = groupslayer,
    options = layersControlOptions(collapsed=FALSE)) 
# %>% 
  # hideGroup(groupslayer[c(3,5:length(groupslayer))]) #hide all groups except the 1st and 2nd )


for( i in 1:length(RRdevices$DeviceID)) {
  if( RRdevices$Connected[i] ){
    cat("Conne", i)
    m <-  m %>%
      addAwesomeMarkers(data = RRdevices[DeviceID == RRdevices$DeviceID[i]],
                        icon=awesomeIcons(
                          icon = RRdevices$icon[i],
                          iconColor = 'black',
                          library = 'ion',
                          markerColor = RRdevices$color[i]),
                        lng = ~lon, lat = ~lat, popup = ~popup, label = ~DeviceID, group = "DevicesOnline")
  } else {
    m <-  m %>%
      addAwesomeMarkers(data = RRdevices[DeviceID == RRdevices$DeviceID[i]],
                        icon=awesomeIcons(
                          icon = RRdevices$icon[i],
                          iconColor = 'black',
                          library = 'ion',
                          markerColor = RRdevices$color[i]),
                        lng = ~lon, lat = ~lat, popup = ~popup, label = ~DeviceID, group = "DevicesOffline")
  }
}



m <-  m %>%  addFullscreenControl() %>%
  addHash() %>%
  addSearchOSM() %>%
  # addDrawToolbar() %>%
  # addStyleEditor() %>%
  addControlGPS()


cat(green("\n\nLeaflet ready"))

setwd(rP("file:///C:/Users/doria/Downloads"))
saveWidget(m, file="RRdevices.html")

cat(green("\nLeaflet DONE :)\n"))
