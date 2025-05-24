
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))



args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250525__CyclotourDuLeman/BU/rr_backup_Cyclotour_du_Leman_20250519-103810/")
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
}

cat(yellow("\n[INFO] - wd:   ", wd, "\n"))
setwd(wd)

af <- data.table(read.csv("customFields.csv", encoding = "UTF-8", sep="\t"))
afv <- data.table(read.csv("customFieldValues.csv", encoding = "UTF-8", sep="\t"))
setnames(afv, "FieldID", "ID")
pa <- data.table(read.csv("participants.csv", encoding = "UTF-8", sep="\t"))
setnames(pa, "ID", "PID")
pa[, PID := as.integer(PID)]
pa <- pa[is.na(PID) == F]
pa
af
afv

af <- dtjoin(afv, af[, .(ID, Name)])
af2 <- dcast.data.table(af, PID~Name, value.var="Value")

pa2 <- dtjoin(pa, af2)
pa2

write.csv(pa2, "participants_full.csv", row.names = F, fileEncoding="utf-8")
