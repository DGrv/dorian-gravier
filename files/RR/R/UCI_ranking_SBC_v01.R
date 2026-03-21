# setup
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))

# Args --------------------------------------------------------------------



args <- commandArgs(trailingOnly=TRUE)


if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2026/Swiss_Bike_Cup/STAGES/#1_Tamaro/Ranking/auto/")
  stageid <- 1
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

uci



if(nrow(sc)>0) {
  setnames(sc, c("UCI.ID", "Rang", "Pkt."), c("UCI_ID", p0("Stage", stageid, "SwissCycling_Ranking"), "SC_Points"))
}
setnames(uci, c("UCI.ID", "Rank", "Points", "Category"), c("UCI_ID", p0("Stage", stageid, "UCI_Ranking"),
                                                 p0("Stage", stageid, "UCI_Points"),
                                                 p0("Stage", stageid, "UCI_RankingType")))

if(nrow(sc)>0) {
all <- dtjoin(uci[, c("UCI_ID", "Name", p0("Stage", stageid, "UCI_Ranking"),
                      p0("Stage", stageid, "UCI_Points"),
                      p0("Stage", stageid, "UCI_RankingType"), "Nationality"), with =F],
              sc[, c("UCI_ID", p0("Stage", stageid, "SwissCycling_Ranking"), "SC_Points"), with = F])
} else {
  all <- uci[, c("UCI_ID", "Name", p0("Stage", stageid, "UCI_Ranking"),
                 p0("Stage", stageid, "UCI_Points"),
                 p0("Stage", stageid, "UCI_RankingType"), "Nationality"), with =F]
}
setnames(all, "Nationality", "Nat")

# replace name RankingType
# all[, .N, c(p0("Stage", stageid, "UCI_RankingType"))]

all[get(p0("Stage", stageid, "UCI_RankingType")) == "EliteM", p0("Stage", stageid, "UCI_RankingType") := "Men Elite"]
all[get(p0("Stage", stageid, "UCI_RankingType")) == "EliteW", p0("Stage", stageid, "UCI_RankingType") := "Women Elite"]
all[get(p0("Stage", stageid, "UCI_RankingType")) == "JuniorM", p0("Stage", stageid, "UCI_RankingType") := "Men Junior"]
all[get(p0("Stage", stageid, "UCI_RankingType")) == "JuniorW", p0("Stage", stageid, "UCI_RankingType") := "Women Junior"]


write.csv(all, p0("STAGE", stageid, "__Ranking.csv"), row.names = F, fileEncoding = "utf-8", na = "")
