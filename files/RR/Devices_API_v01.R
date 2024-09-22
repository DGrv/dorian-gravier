apikey <- "846.dccb7479c667d522bbfe79d4f815251f0780317462a2f1a1d7e5de258efa3a79ca96e6facc7b6ce67d63d590f6c71854"

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

resp2b <- data.table(jsonlite::fromJSON(resp_body_string(resp2), flatten = T)$Devices)
resp2b

rm(req1, req2)



RRdevices <- resp2b[, .(DeviceID, 
                  DeviceType,
                  BatteryCharge,
                  Temperature,
                  Connected,
                  Received = as.POSIXct(gsub("T", " ", gsub("Z", "", Received)), format = "%F %T"),
                  RealTime = as.POSIXct(gsub("T", " ", gsub("Z", "", RealTime)), format = "%F %T"),
                  UTCOffset,
                  FileNo,
                  TimeZoneName,
                  RecordsCount,
                  lon = Position.Longitude, 
                  lat = Position.Latitude, 
                  Power = DecoderStatus.HasPower,
                  ReadHealthy = DecoderStatus.ReaderIsHealthy,
                  Antennas = DecoderStatus.Antennas,
                  ReaderStatus = TrackboxStatus.ReaderStatus)]
RRdevices
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
RRdevices



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