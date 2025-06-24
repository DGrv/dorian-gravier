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
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/2025______SwissBikeCup/STAGES/#3_Savognin/Ranking/")
  stageid <- 4
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
  wd <- gsub("\\\\", "/", wd)
  stageid <- args[2]
}
cat(yellow("\n[INFO] - wd:\t", wd))
setwd(wd)

# list csv ----------------------------------------------------------------

data <- data.table(path = list.files(wd, pattern = ".*\\.csv$", full = T))
data[, filename := basename(path)]
data[filename %like% "UCI_", RankingType := "UCI"]
data[filename %like% "SC_", RankingType := "SC"]

sc <- data.table()
uci <- data.table()

for(j in seq_along(u(data$RankingType)) ) {
  
  ll <- data[RankingType == u(RankingType)[j]]
  
  for (i in seq_along(ll$path)) {
    
    temp <- data.table(read.csv(ll$path[i], encoding = "UTF-8"))
    temp[, filename := ll$filename[i]]
    temp[, Category := gsub(".*_(.*).csv", "\\1", filename)]
    if( u(data$RankingType)[j] == "SC") {
      sc <- rbind(sc, temp)
    } else {
      uci <-  rbind(uci, temp)
    }
    
  
  }
}


setnames(sc, c("UCI.ID", "Rang", "Pkt."), c("UCI_ID", p0("Stage", stageid, "SwissCycling_Ranking"), "SC_Points"))
setnames(uci, c("UCI.ID", "Rank", "Points", "Category"), c("UCI_ID", p0("Stage", stageid, "UCI_Ranking"),
                                                 p0("Stage", stageid, "UCI_Points"),
                                                 p0("Stage", stageid, "UCI_RankingType")))

all <- dtjoin(uci[, c("UCI_ID", "Name", p0("Stage", stageid, "UCI_Ranking"),
                      p0("Stage", stageid, "UCI_Points"),
                      p0("Stage", stageid, "UCI_RankingType"), "Nationality"), with =F],
              sc[, c("UCI_ID", p0("Stage", stageid, "SwissCycling_Ranking"), "SC_Points"), with = F])
setnames(all, "Nationality", "Nat")


write.csv(all, p0("STAGE", stageid, "__Ranking.csv"), row.names = F)
replace.NA.csv(p0("STAGE", stageid, "__Ranking.csv"), pattern = "NA", replacement = "")
