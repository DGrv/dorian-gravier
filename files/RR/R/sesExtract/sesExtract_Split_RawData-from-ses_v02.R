




# data --------------------------------------------------------------------

setwd(wd)
input <- "rawdata.csv"
keepbib <- 1


data <- data.table(read.csv(input, sep="\t"))
data

data[, .N, TimingPoint]
setnames(data, 
         c("Invalid","ID","DeviceID","TimingPoint","Hits","RSSI","LoopID","ChannelID","Time","OrderID","Transponder"), c("RD_Invalid","RD_ID","RD_DeviceID","RD_TimingPoint","RD_Hits","RD_RSSI","RD_LoopID","RD_ChannelID","RD_Time","RD_OrderID","RD_Transponder"))

tp <- u(data$RD_TimingPoint)

cat("\n")
data[, .N, .(RD_TimingPoint, RD_DeviceID)]


data[RD_TimingPoint == "", RD_TimingPoint := "MANUAL"]
data[, RD_LoopID := NULL] # otherwise it is taking the rules
data[, RD_Channel := NULL] # otherwise it is taking the rules


# # create fake one
# add1 <- data[TimingPoint == "RUN_LAP_YOUTH"][, Time := Time + 60 +40]
# add2 <- data[TimingPoint == "RUN_LAP_OLYMPIC"][, Time := Time -20]
# data <- rbind(data, add1, add2)


data <- data[order(RD_Time)]

data[, RD_ID := NULL] # making mess if you import again


# Participants ------------------------------------------------------------


# # desactivate if you do not want this, you have to adapt it 
# # desactivate if you do not want this, you have to adapt it 
# # desactivate if you do not want this, you have to adapt it 
# # desactivate if you do not want this, you have to adapt it 
# if( keepbib == 0 ) {
#   
#     # get bib from Event 2024
#     # data/list?fields=Contest,Bib&listformat=json
#     url <- "https://api.raceresult.com/274390/VGWNLC91B6TV49ZLPNOPXXUG8SBX5G32"
#     parti <- data.table(jsonlite::fromJSON(url(url), flatten = TRUE))
#     setnames(parti, names(parti), c("Contest","RD_Bib"))
#     parti <- parti[order(Contest, RD_Bib)]
#     
#     # replace bib with other event 
#     # replace bib with other event 
#     # Event 2025
#     # data/list?fields=Contest,Bib&listformat=json
#     url <- "https://api.raceresult.com/323259/KAL5O4PHTJ2A1XYSSP82ARVX7Z2Y958D"
#     new <- data.table(jsonlite::fromJSON(url(url), flatten = TRUE))
#     setnames(new, names(new), c("Contest","RD_Bib2"))
#     new <- new[order(Contest, RD_Bib2)]
#     new <- new[Contest %in% u(parti$Contest)]
#     
#     u1 <- u(parti$RD_Bib)
#     u2 <- u(new$RD_Bib2)
#     
#     
#     j = 1
#     for( i in seq_along(u1)) {
#       if( parti$Contest[i] == new$Contest[j] ) {
#         new[j, RD_Bib := parti$RD_Bib[i]]
#         j <- j+1
#       }
#       
#     }
#     new
#     parti
#     
#     data <- dtjoin(data, new[!is.na(RD_Bib)])
#     data[, RD_Bib := NULL]
#     setnames(data, "RD_Bib2", "RD_Bib")
#     data <- data[!is.na(RD_Bib)]
#     data[, Contest := NULL]
#     data
# 
#     id <- 505
#     data[RD_Bib == id]
#     new[RD_Bib2 == id]
# 
# }

# Export data -------------------------------------------------------------

create.dir(wd, "Extracted_RawData", "wd2")

write.table(data[, .N, .(RD_TimingPoint, RD_DeviceID)], "Summary_rawdata.csv", sep="\t", row.names = F, quote = F)

for (i in seq_along(tp)) {
  temp <- data[RD_TimingPoint == tp[i]]
  if(keepbib == 0) {
    temp[, RD_Bib := NULL]
  }
  if( nrow(temp) > 0 ) {
    write.csv(temp, path_sanitize(p0(gsub(" ", "_", tp[i]), ".csv")), quote=F, row.names = F)
  }
}


# # Or Push online ----------------------------------------------------------
# 
# library(httr)
# library(furrr)
# plan(multisession)  # or multicore on Linux/Mac
# 
# # create api with custom=rawdata/addmanual
# 
# api <- "http://192.168.1.201/_307885/api/ZWF3Y1548A48G8FJWDYSFK7AQI1EHGJ8"
# 
# data[, push := p0(api, "?TimingPoint=", TimingPoint, "&bib=", Bib, "&time=", Time)]
# results <- future_map(data$push, ~GET(.x))


# headers <- add_headers(
#   `User-Agent` = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)",
#   `Accept` = "text/html",
#   `Accept-Language` = "en-US,en;q=0.9"
# )
# 
# results <- future_map(data$push, function(url) {
#   # Sys.sleep(runif(1, 0.2, 0.5))  # avoid being blocked
#   GET(url, headers)
# })

# for(i in 1:nrow(data)) {
#   Sys.sleep(runif(1, 0.2, 0.6))  # slight delay per request
#   GET(data$push[i], add_headers(`User-Agent` = "Mozilla/5.0"))
#   # system(p0("curl -s ", data$push[i], " > /dev/null 2>&1 &"))
# }



