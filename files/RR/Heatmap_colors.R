

# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')

library(fields)

writeClipboard(tim.colors(40))
[1] "#00008F" "#0000A9" "#0000C3" "#0000DD" "#0000F8" "#0011FF" "#002BFF" "#0045FF" "#005FFF" "#0079FF" "#0091FF" "#00ABFF" "#00C5FF"
[14] "#00DFFF" "#00FAFF" "#14FFEB" "#2EFFD1" "#47FFB8" "#61FF9E" "#7BFF85" "#94FF6B" "#AEFF51" "#C8FF37" "#E1FF1E" "#FCFF03" "#FFE800"
[27] "#FFCF00" "#FFB500" "#FF9B00" "#FF8200" "#FF6900" "#FF4F00" "#FF3500" "#FF1B00" "#FF0100" "#E60000" "#CD0000" "#B30000" "#990000"
[40] "#800000"