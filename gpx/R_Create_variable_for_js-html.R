library(data.table)

wd <- "D:/DG-Papers/GitHub/Website/dorian.gravier.github.io/gpx"
setwd(wd)

lis <- data.table(path = list.files(wd, full = T, recursive = T))
lis[, path2 := gsub("D:/DG-Papers/GitHub/Website/dorian.gravier.github.io/", "", path) ]
lis[, dir := dirname(path2) ]
lisdir <- unique(lis$dir)


write("// create file", file = "Name_var_js-html_tocopy_in_leaflet.txt")
for(i in seq_along(lisdir)) {
  if( basename(lisdir[i]) == "Project" ) {
    varname <- paste0(basename(dirname(lisdir[i])), basename(lisdir[i]))
  } else {
    varname <- basename(lisdir[i])
  }

  lis2 <- lis[dir == lisdir[i]]

  for( j in 1:nrow(lis2)) {
    if( j == 1) {
      write(paste0("var ", varname, " = ['", lis2[j, path2], "',\n"), file = "Name_var_js-html_tocopy_in_leaflet.txt", append = T)
    } else if( j == nrow(lis2)) {
      write(paste0("'", lis2[j, path2], "']\n"), file = "Name_var_js-html_tocopy_in_leaflet.txt", append = T)
    } else {
      write(paste0("'", lis2[j, path2], "',"), file = "Name_var_js-html_tocopy_in_leaflet.txt", append = T)
    }
  }

}
