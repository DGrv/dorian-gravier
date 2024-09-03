

# setup
rm(list = ls())
rootpath <- 'D:/BU_Work/Maxi_BU/20240812/Shared_Dorian/' 
Sys.setlocale('LC_ALL', 'German')
suppressWarnings(suppressMessages(source(paste0(rootpath, "Dorian/BM_Function_v01.r"), encoding="utf-8")))

# display.brewer.all()
suppressWarnings(suppressMessages(library(kableExtra)))

args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/Drive/RR/20240629__ISSF_Target_Sprint_World_Cup_2024/BU/backup_ISSF_Target_Sprint_World_Cup_2024_SUI_Hombrechtikon_20240701-162533__Before_modification/")
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
}
cat(yellow("\n[INFO] - wd:   ", wd, "\n"))
setwd(wd)

data <- data.table(read.csv2("output_list.csv", header = F))
kbl(data) %>%
  kable_styling() %>%
  # row_spec(1:nrow(data), bold = T, color = "white", background = "#2E2D2B") %>% 
  row_spec(data[,.I[V1 %like% "-------"]], bold = T, color = "white", background = "#D7261E") %>% 
  row_spec(data[,.I[V1 %like% "ORDER|FILTERS|FIELDS"]], color = "black", bold = T, background = "#EEE8CD") %>% 
  row_spec(data[,.I[V1 %like% " ---- "]], bold = T, color = "black", background = "#FFD700") %>% 
  row_spec(data[,.I[V1 %like% "LineDynamicFormat"]], color = "black", bold = T, background = "#7FFFD4") %>% 
  save_kable("output_list.html", self_contained = T)

cat(green("\nKable DONE :)\n"))

