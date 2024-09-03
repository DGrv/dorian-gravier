
# setup
rootpath <- 'D:/BU_Work/Maxi_BU/20240812/Shared_Dorian/' 
Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'Dorian/BM_Function_v01.r), encoding='utf-8')




library(jsonlite)


# RR variables ------------------------------------------------------------

wd <- "file:///C:/Users/doria/Downloads/Drive/RR/Zurick_Marathon/BU/Search_AG/"

file.TeamScore <- "Team%20Scores.lvs"
file.SpecialRankings <- "Special%20Results.lvs"
file.Rankings <- "Rankings.lvs"
file.UDF <- "User%20Defined%20Fields_Fcts..lvs"
output.folder <- wd


ts <- data.table(fromJSON(rP(p0(wd, file.TeamScore))))
t <-  "LapModeLocation LapTimes LapTimesCountLemansAsLap LapTimesIgnoreAfter LapTimesIgnoreBefore LapTimesLemans LapTimesMinLapTime LapTimesPenaltyLapsResult LapTimesPenaltyTimeResult LapTimesSubtractT0 LapTimesZeroStart MaxFemale MaxTeams MaxTotal MinFemale MinTotal RealTime ResultMode1 ResultMode2 ResultMode3 ResultMode4 SortDesc1 SortDesc2 SortDesc3 TimeFormat UseTies"
remove.dt.columns.paste.console(t, ts)
setcolorder(ts, c("ID", "Name", "Filter"))
ts

sr <- readLines(rP(p0(wd, file.SpecialRankings)))
sr <- sub(";", "#", sr)
sr <- sub(";", "#", sr)
sr <- sub(";", "#", sr)
sr <- sub(";", "#", sr)
sr <- sub(";", "#", sr)
sr <- gsub('"', "'", sr)
out1 <- rP(p0(dirname(p0(wd, file.SpecialRankings)), "/temp.lvs"))
out1
writeLines(sr, out1)
sr <- data.table(read.csv(out1, sep="#", h=F))
names(sr) <- c("ID", "Name", "TF", "Rounding", "TP", "Calculation")
sr
sr
t <-  "TF Rounding     TP"
remove.dt.columns.paste.console(t, sr)


ranking <- data.table(fromJSON(rP(p0(wd, file.Rankings))))
t <-  "SortDesc ContestSort UseTies"
remove.dt.columns.paste.console(t, ranking)
ranking
ranking[, Group := unlist(lapply(Group, function (x) p0(x, collapse=",")))]
ranking[, Sort := unlist(lapply(Sort, function (x) p0(x, collapse=",")))]
ranking

# af <- data.table(fromJSON(rP("file:///C:/Users/doria/Downloads/Drive/RR/SwissBikeCup/02_Tama/Search_AG/Additional%20Fields.lvs")))
# t <-  "Label Mandatory MaxLen MinLen Placeholder  Type Default Enabled Config"
# remove.dt.columns.paste.console(t, af)
# setcolorder(af, c(2, 1))

uf<- data.table(fromJSON(rP(p0(wd, file.UDF))))
uf[, Note := NULL]
uf[, sep := "-----"]
setcolorder(uf, c(1, 3, 2))
uf
# uf[, test := unlist(lapply(str_match_all(uf$Expression, "\\[(.*?)\\]"), function(x) p0(x[,2], collapse = " / ")))]

# contest <- readLines(rP("file:///C:/Users/doria/Downloads/Drive/RR/SwissBikeCup/02_Tama/Search_AG/Contests.lvs"))
# clean.RR.json <- function(vector) {
#   vector <- gsub('\\\\', '', vector)
#   vector <- gsub('"\\{', '{', vector)
#   vector <- gsub('\\}"', '}', vector)
#   # vector <- gsub('\\|', ' - ', vector)
#   vector <- vector[!vector %like% '"Name"']
#   return(vector)
# }
# contest <- clean.RR.json(contest)
# contest <- fromJSON(contest)
# contest


setwd(rP(output.folder))
write.table(ts, "TeamScore_prettify.csv", row.names = F, quote = F, sep = "\t")
write.table(sr, "SpecialRankings_prettify.csv", row.names = F, quote = F, sep = "\t")
write.table(ranking, "Rankings_prettify.csv", row.names = F, quote = F, sep = "\t")
write.table(uf, "UDF_prettify.csv", row.names = F, quote = F, sep = "\t")


