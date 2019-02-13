library(data.table)

wd <- "D:/DG-Papers/GitHub/Website/dorian.gravier.github.io/gpx"
if( !dir.exists(wd) ) {
  wd <- "C:/Users/gravier/Downloads/GitHub/dorian.gravier.github.io/gpx"
}
setwd(wd)

lis <- data.table(path = list.files(wd, full = T, recursive = T))
lis[, path2 := gsub(paste0(dirname(wd), "/"), "", path) ]
lis[, dir := dirname(path2) ]
lisdir <- unique(lis$dir)




write("// create file", file = "Name_var_js-html_tocopy_in_leaflet.txt")
for(i in seq_along(lisdir)) {
  if( lisdir[i] != "gpx" ) {
    if( basename(lisdir[i]) == "Project" ) {
      varname <- paste0(basename(dirname(lisdir[i])), basename(lisdir[i]))
    } else {
      varname <- basename(lisdir[i])
    }

    lis2 <- lis[dir == lisdir[i]]

    for( j in 1:nrow(lis2)) {
      if( j == 1) {
        write(paste0("var ", varname, " = ['", lis2[j, path2], "',"), file = "Name_var_js-html_tocopy_in_leaflet.txt", append = T)
      } else if( j == nrow(lis2)) {
        write(paste0("'", lis2[j, path2], "']\n"), file = "Name_var_js-html_tocopy_in_leaflet.txt", append = T)
      } else {
        write(paste0("'", lis2[j, path2], "',"), file = "Name_var_js-html_tocopy_in_leaflet.txt", append = T)
      }
    }
  }
}

leaf <- readLines(paste0(dirname(wd), "/leaflet.md"))
leaf1 <- leaf[1:grep("// VARIABLE START", leaf)]
leaf2 <- leaf[grep("// VARIABLE END", leaf):length(leaf)]

var <- readLines("Name_var_js-html_tocopy_in_leaflet.txt")
leafnew <- c(leaf1, var, leaf2)
writeLines(leafnew, paste0(dirname(wd), "/leaflet.md"))
