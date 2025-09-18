

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
  wd <- rP("file:///C:/Users/doria/Downloads/")
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


data <- data.table(read.csv(input))

tp <- u(data$RD_TimingPoint)

cat("\n")
data[, .N, .(RD_TimingPoint, RD_DeviceID)]


data[RD_TimingPoint == "", RD_TimingPoint := "MANUAL"]
data[, RD_LoopID := NULL] # otherwise it is taking the rules
data[, RD_Channel := NULL] # otherwise it is taking the rules
setnames(data, "ï..RD_Invalid", "RD_Invalid")


# # create fake one
# add1 <- data[TimingPoint == "RUN_LAP_YOUTH"][, Time := Time + 60 +40]
# add2 <- data[TimingPoint == "RUN_LAP_OLYMPIC"][, Time := Time -20]
# data <- rbind(data, add1, add2)


data <- data[order(RD_Time)]

data[, RD_ID := NULL] # making mess if you import again


# Participants ------------------------------------------------------------


    # desactivate if you do not want this, you have to adapt it 
    # desactivate if you do not want this, you have to adapt it 
    # desactivate if you do not want this, you have to adapt it 
    # desactivate if you do not want this, you have to adapt it 
    keepbib <- 0
    if( keepbib == 0 ) {
      
        # get bib from Event 2024
        # data/list?fields=Contest,Bib&listformat=json
        url <- "https://api.raceresult.com/322776/QJQRM6AS6ABDD8GW950PBVYUDAOLJGAS"
        parti <- data.table(jsonlite::fromJSON(url(url), flatten = TRUE))
        setnames(parti, names(parti), c("Contest","RD_Bib"))
        parti <- parti[order(Contest, RD_Bib)]
        
        # replace bib with other event 
        # replace bib with other event 
        # Event 2025
        # data/list?fields=Contest,Bib&listformat=json
        url <- "https://api.raceresult.com/322777/1OT530IS3XNIRXH2LRC5PG895DTWCB9O"
        new <- data.table(jsonlite::fromJSON(url(url), flatten = TRUE))
        setnames(new, names(new), c("Contest","RD_Bib2"))
        new <- new[order(Contest, RD_Bib2)]
        new <- new[Contest %in% u(parti$Contest)]
        
        u1 <- u(parti$RD_Bib)
        u2 <- u(new$RD_Bib2)
        
        
        j = 1
        for( i in seq_along(u1)) {
          if( parti$Contest[i] == new$Contest[j] ) {
            new[j, RD_Bib := parti$RD_Bib[i]]
            j <- j+1
          }
          
        }
        new
        parti
        
        data <- dtjoin(data, new[!is.na(RD_Bib)])
        data[, RD_Bib := NULL]
        setnames(data, "RD_Bib2", "RD_Bib")
        data <- data[!is.na(RD_Bib)]
        data[, Contest := NULL]
        data[, RD_Transponder := RD_Bib]
    
        # check
        id <- 1415
        data[RD_Bib == id]
        new[RD_Bib2 == id]
        
        data[,.N, RD_Bib]
        
    
    }
    
# Export data -------------------------------------------------------------

# data2 <- data[data[RD_DeviceID == "D-5025", .I[RD_Time==min(RD_Time)], RD_Bib]$V1]
# data2[, RD_Time := 9*60*60+52*60]
# data2[, .N, RD_Bib]
# data <- copy(data2)

create.dir(wd, "Extracted_RawData", "wd2")

write.table(data[, .N, .(RD_TimingPoint, RD_DeviceID)], "Summary_rawdata.csv", sep="\t", row.names = F, quote = F)

for (i in seq_along(tp)) {
  temp <- data[RD_TimingPoint == tp[i]]
  # if(keepbib == 0) {
  #   temp[, RD_Bib := NULL]
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




