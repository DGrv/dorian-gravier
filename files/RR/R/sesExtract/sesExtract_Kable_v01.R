

# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))

# display.brewer.all()
suppressWarnings(suppressMessages(library(kableExtra)))

args <- commandArgs(trailingOnly=TRUE)

if (length(args)==0) {
  wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/2025__SwissBikeCup/BU/rr_backup_Skoda_Swiss_Bike_Cup_2025_20241206-170409/")
} else{
  wd <- gsub("/mnt/c", "C:", args[1])
}
cat(yellow("\n[INFO] - wd:   ", wd, "\n"))
setwd(wd)

lcsv <- c("output_list.csv", "output_list_selectors.csv")

for (i in seq_along(lcsv)) {
  data <- data.table(read.csv2(lcsv[i], header = F, encoding = "UTF-8"))
  kbl(data) %>%
    kable_styling() %>%
    # row_spec(1:nrow(data), bold = T, color = "white", background = "#2E2D2B") %>% 
    row_spec(data[,.I[V1 %like% "-------"]], bold = T, color = "white", background = "#D7261E") %>% 
    row_spec(data[,.I[V1 %like% "ORDER|FILTERS|FIELDS"]], color = "black", bold = T, background = "#EEE8CD") %>% 
    row_spec(data[,.I[V1 %like% " ---- "]], bold = T, color = "black", background = "#FFD700") %>% 
    row_spec(data[,.I[V1 %like% "LineDynamicFormat"]], color = "black", bold = T, background = "#7FFFD4") %>% 
    row_spec(data[,.I[V1 %like% "SELECTORS"]], color = "black", bold = T, background = "#03fc84") %>% 
    save_kable(gsub("csv$", "html", lcsv[i]), self_contained = T)
}

cat(green("\nKable DONE :)\n"))

