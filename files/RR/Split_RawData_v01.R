

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
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/2025______SwissBikeCup/STAGES/#3_Savognin/")
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


# # create fake one
# add1 <- data[RD_TimingPoint == "RUN_LAP_YOUTH"][, RD_Time := RD_Time + 60 +40]
# add2 <- data[RD_TimingPoint == "RUN_LAP_OLYMPIC"][, RD_Time := RD_Time -20]
# data <- rbind(data, add1, add2)


data <- data[order(RD_Time)]

data


# Export data -------------------------------------------------------------


create.dir(wd, "Extracted_RawData", "wd2")

for (i in seq_along(tp)) {
  temp <- data[RD_TimingPoint == tp[i]]
  if(keepbib == 0) {
    temp[, RD_Bib := NULL]
  }
  if( nrow(temp) > 0 ) {
    write.csv(temp, p0(gsub(" ", "_", tp[i]), ".csv"), quote=F, row.names = F)
  }
}


# Or Push online ----------------------------------------------------------

library(httr)
library(furrr)
plan(multisession)  # or multicore on Linux/Mac

# create api with custom=rawdata/addmanual

api <- "http://192.168.1.201/_307885/api/ZWF3Y1548A48G8FJWDYSFK7AQI1EHGJ8"

data[, push := p0(api, "?TimingPoint=", RD_TimingPoint, "&bib=", RD_Bib, "&time=", RD_Time)]
results <- future_map(data$push, ~GET(.x))


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




