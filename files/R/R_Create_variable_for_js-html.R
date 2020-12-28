# Setup ----------------------------------------------------------------
  
  library(data.table)

  wd <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files"
  outjs <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/js/Personal/gpx.js"
  if( !dir.exists(wd) ) {
    wd <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files"
    outjs <- "C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/js/Personal/gpx.js"
  }
  setwd(wd)


# get data ----------------------------------------------------------------

  lis <- data.table(path = list.files(wd, pattern = ".gpx", full = T, recursive = T))
  lis <- lis[!path %like% "gpx.reg"]
  lis[, path2 := gsub(paste0(dirname(wd), "/"), "", path) ]
  lis[, dir := dirname(path2) ]
  lisdir <- unique(lis$dir)

# output ------------------------------------------------------------------

  write("// create file", file = outjs)
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
          write(paste0("var ", varname, " = ['", lis2[j, path2], "',"), file = outjs, append = T)
        } else if( j == nrow(lis2)) {
          write(paste0("'", lis2[j, path2], "']\n"), file = outjs, append = T)
        } else {
          write(paste0("'", lis2[j, path2], "',"), file = outjs, append = T)
        }
      }
    }
  }


