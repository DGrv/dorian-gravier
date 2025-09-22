

# setup
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))

setwd(rP("file:///C:/Users/doria/Downloads"))

data <- data.table(read.csv(rP("file:///C:/Users/doria/Downloads/History.csv")))
data <- data[Field == "Bib"]
data <- data[Timestamp %like% "2025-09-12"]
data <- data[order(ID, Timestamp)]
data[, Timestamp := as.POSIXct(Timestamp, "yyyy-mm-dd HH:MM:SS")]
data
data[,New.Value := as.numeric(New.Value)]
data <- data[New.Value<10000]
data <- data[data[, .I[Timestamp == max(Timestamp)], ID]$V1]

data


data[, .N, .(ID, New.Value)][,.N,New.Value][N>1]

write.csv(data[, .(ID, Bib=New.Value)], "import.csv", row.names = F, quote=F)
