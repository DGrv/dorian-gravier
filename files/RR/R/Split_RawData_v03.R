

# setup
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))




# Args --------------------------------------------------------------------


cat(green("Tool to transform RawData.csv to 1 csv file per split:\n\t- $1 is filename:\n\t- $2 is keep bib, 1 or 0\n"))

args <- commandArgs(trailingOnly=TRUE)


if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2026/Zurich_City_Triathlon_2026/BU/rr_backup_Zurich_City_Triathlon_2025_20260414-154314/")
  # input <- "RawDataunique.csv"
  input <- "RawData.csv"
  keepbib <- 1 
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
  wd <- gsub("\\\\", "/", wd)
  
  debug.easy(length(args[2])==0, "Please give a filename to process.")
  
  input <- args[2]
  if( length(args[3])==0 ) {
    keepbib <- 1   
  } else {
    keepbib <- args[3]
  }
}



cat(yellow("\n[INFO] - wd:\t", wd))
cat(yellow("\n[INFO] - file:\t", input))
cat(yellow("\n[INFO] - Keep Bib:\t", keepbib, "\n"))
setwd(wd)


data <- fread(input)

data

setnames(data, names(data), gsub("^RD_", "", names(data)))

tp <- u(data$TimingPoint)



if( nrow(data[DeviceID == "Manual"]) ) {
  cat(red("[DEBUG] - You have Manual detection in your data - take care !!!! \n"))
  cat(red("[DEBUG] - You have Manual detection in your data - take care !!!! \n"))
  cat(red("[DEBUG] - You have Manual detection in your data - take care !!!! \n"))
  cat(red("[DEBUG] - You have Manual detection in your data - take care !!!! \n"))
  cat(red("[DEBUG] - You have Manual detection in your data - take care !!!! \n"))
}

data[DeviceID == "Manual"]
data <- data[DeviceID != "Manual"]



cat("\n")
data[, .N, .(TimingPoint, DeviceID)]


# if no bib add it, certainly come from ses
if( !"Bib" %in% names(data) ) {
  temp <- fread("participants.csv")
  setnames(temp, "ID", "PID")
  data <- dtjoin(data, temp[, .(PID, Bib)])
  data[, Time := Time/10000] # important otherwise time is wrong
}

# remove markers 9999
data <- data[!is.na(Bib)]



data[TimingPoint == "", TimingPoint := "MANUAL"]
data[, LoopID := NULL] # otherwise it is taking the rules
data[, Channel := NULL] # otherwise it is taking the rules
# setnames(data, "?..Invalid", "Invalid")


# # create fake one
# add1 <- data[TimingPoint == "RUN_LAP_YOUTH"][, Time := Time + 60 +40]
# add2 <- data[TimingPoint == "RUN_LAP_OLYMPIC"][, Time := Time -20]
# data <- rbind(data, add1, add2)


data <- data[order(Time)]

data[, ID := NULL] # making mess if you import again


# Participants ------------------------------------------------------------


    # desactivate if you do not want this, you have to adapt it 
    # desactivate if you do not want this, you have to adapt it 
    # desactivate if you do not want this, you have to adapt it 
    # desactivate if you do not want this, you have to adapt it 
    keepbib <- 0




    # if( keepbib == 0 ) {
      
      
        
        apilist <- data.table(Year=2025:2026, url =
                                c("https://api.raceresult.com/307885/YXBE3LZQSHBOXB6V1FHF7HR5CYOIOZMC",
                                  "https://api.raceresult.com/360525/W3PHTM9OLCCHTBRL1252599SE8WK1BM0"))
        
        lcol <- c("Contest", "Bib")
        databib <- data.table()
        
        for(i in seq_along(apilist$url)) {
          temp <- RRgetDataAPI(urlapi = apilist$url[i], lcol)
          temp[, Year := apilist$Year[i]]
          databib <- rbind(databib, temp)
        }
        
        databib <- u(databib[order(Year, Contest, Bib)])
        
      
        # # get bib from Event 2024
        # # data/list?fields=Contest,Bib&listformat=json
        # url <- "https://api.raceresult.com/322776/QJQRM6AS6ABDD8GW950PBVYUDAOLJGAS"
        # parti <- data.table(jsonlite::fromJSON(url(url), flatten = TRUE))
        # setnames(parti, names(parti), c("Contest","Bib"))
        # parti <- parti[order(Contest, Bib)]
        # 
        # # replace bib with other event 
        # # replace bib with other event 
        # # Event 2025
        # # data/list?fields=Contest,Bib&listformat=json
        # url <- "https://api.raceresult.com/322777/1OT530IS3XNIRXH2LRC5PG895DTWCB9O"
        # new <- data.table(jsonlite::fromJSON(url(url), flatten = TRUE))
        # setnames(new, names(new), c("Contest","Bib2"))
        # new <- new[order(Contest, Bib2)]
        # new <- new[Contest %in% u(parti$Contest)]
        
        # u1 <- u(parti$Bib)
        # u2 <- u(new$Bib2)
        
        db1 <- databib[Year == u(Year)[1]]
        db2 <- databib[Year == u(Year)[2]]
        setnames(db2, "Bib", "Bib2")
        
        db1 <- db1[Contest > 0 & Contest <100]
        db2 <- db2[Contest > 0 & Contest <100]
        
                  # only for Zc3
                  db1 <- db1[Contest <20][Contest != 11 & Contest != 10]
                  db2 <- db2[Contest <20][Contest != 9 & Contest != 10]
                  
                  db1[Contest==6, Contest := 11]
                  db1[Contest==9, Contest := 6]
        
        
        db1[,.N, Contest]
        db2[,.N, Contest]
        
        
        db1 <- db1[!is.na(Bib)]
        db2 <- db2[!is.na(Bib2)]
        
        db1 <- db1[!is.na(Contest)]
        db2 <- db2[!is.na(Contest)]
        
        db1 <- db1[Contest %in% u(db2$Contest)]
        db2 <- db2[Contest %in% u(db1$Contest)]
        db1 <- db1[Contest %in% u(db2$Contest)]
        
        db1 <- db1[order(Contest, Bib)]
        db2 <- db2[order(Contest, Bib2)]
        
        u1 <- u(db1$Bib)
        u2 <- u(db2$Bib2)
        
        
        
        for(c in u(db2$Contest) ) {
          
          Idb1 <- db1[,.I[Contest == c]]
          Idb2 <- db2[,.I[Contest == c]]
          
          for( i in 1:(min( length(Idb1), length(Idb2) ) ) ) {
            if( db1[Idb1[i]]$Contest == db2[Idb2[i]]$Contest ) {
              db2[Idb2[i], Bib := db1[Idb1[i]]$Bib]
            }
          }
        }
        db2
        db2
        
        
        # seqfor <- seq_along(u1)[1:(min(length(u1),length(u2)))]
        # # db2 <- db2[1:(min(length(u1),length(u2)))] # reduce db2 to the number of bib in db1
        # j = 1
        # for( i in seqfor ) {
        #   if( db1$Contest[i] == db2$Contest[j] ) {
        #     db2[j, Bib := db1$Bib[i]]
        #     j <- j+1
        #   }
        #   
        # }
        # db2
        # db2
        
        dataBU <- copy(data)
        # data <- copy(dataBU)


        data <- dtjoin(data, db2[!is.na(Bib2)])
        data[, Bib := NULL]
        setnames(data, "Bib2", "Bib")
        data <- data[!is.na(Bib)]
        data[, Transponder := Bib]
        
        data[, .(BibMin=min(Transponder), BibMax = max(Transponder)), Contest]
        
        data[, Contest := NULL]
    
        # check
        id <- 1415
        data[Bib == id]
        db2[Bib2 == id]
        
        data[,.N, Bib]
      
    
    # }







# format ------------------------------------------------------------------


data[, PID := NULL]
data <- data[, c("Invalid", 
                 "DeviceID", 
                 "Bib", 
                 "Transponder", 
                 "Time",
                 "TimingPoint", 
                 "Hits", 
                 "RSSI"), with = F]

setnames(data,c("Invalid", 
                "DeviceID", 
                "Bib", 
                "Transponder", 
                "Time",
                "TimingPoint", 
                "Hits", 
                "RSSI"),
         c("RD_Invalid", 
                "RD_DeviceID", 
                "RD_Bib", 
                "RD_Transponder", 
                "RD_Time", 
                "RD_TimingPoint", 
                "RD_Hits", 
                "RD_RSSI"))





    
# Export data -------------------------------------------------------------

# data2 <- data[data[DeviceID == "D-5025", .I[Time==min(Time)], Bib]$V1]
# data2[, Time := 9*60*60+52*60]
# data2[, .N, Bib]
# data <- copy(data2)

create.dir(wd, ifelse(keepbib == 0, "Extracted_RawData_switched-bibs", "Extracted_RawData"), "wd2")

write.table(data[, .N, .(RD_TimingPoint, RD_DeviceID)], "Summary_rawdata.csv", sep="\t", row.names = F, quote = F)

for (i in seq_along(tp)) {
  temp <- data[RD_TimingPoint == tp[i]]
  # if(keepbib == 0) {
  #   temp[, Bib := NULL]
  # }
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




