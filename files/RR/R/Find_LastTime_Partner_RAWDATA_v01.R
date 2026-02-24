
# setup
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
Sys.setlocale('LC_ALL', 'German')

source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")

library(lubridate)
library(hms)


wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250430__Innsbruck_Alpine_Trailrun_Festival/Code/")
setwd(wd)

# in API -> Custom
# rawdata/get
# times/excelexport
# Results/get

cat(red("[INFO] - remove rawdata.txt if you wanna download them again"))
checkifrawdataexists <- ifelse( file.exists("rawdata.txt"), F, T )

data <- readRR12(APIrawdata = "https://api.raceresult.com/298211/3KAPEF2S246MUHWLIUAENM3RTKXD107S",
                 APItimes = "https://api.raceresult.com/298211/R051E1H9OEQN9QJBZV6Q1CPLWJX4F3MY",
                 APIresults = "https://api.raceresult.com/298211/BKEMVYHGYLXS1JPRZIA71D2G1T4JLM7P",
                 getrawdata = checkifrawdataexists)
setorder(data, Time)

write.csv(data[, .N, Passing.DeviceID][order(Passing.DeviceID)], "Devices_used.csv", row.names = F)

searchbib <- 15334



nmore <- 10
data[Bib == searchbib]
tp <- tail(data[Bib == searchbib], 1)$TimingPoint
data[TimingPoint == tp][, .I[Bib == searchbib]]
lineids <- data[TimingPoint == tp][, .I[Bib == searchbib]]
# lineids <- data[, .I[TimingPoint %like% "FINISH" & Bib == searchbib]]
out <- data[TimingPoint == tp][(min(lineids)-nmore):(max(lineids)+nmore)]
print(out, topn=nmore+1)









