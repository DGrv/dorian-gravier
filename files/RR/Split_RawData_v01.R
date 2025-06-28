

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





