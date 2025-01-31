

# SETUP -------------------------------------------------------------------



# library(xlsx)
library(ggplot2)
library(data.table)
library(stringr)
library(stringi)
library(dplyr)
library(GrpString)
library(knitr)
library(dataCompareR)
library(tableHTML)
library(clipr) # to read clipboard
library(crayon)
library(DBI) # database
library(odbc) # database
# library(gmailr)
#library(rgdal) 
library(colorDF)

# Sys.setlocale('LC_ALL', 'German')
Sys.getenv()
Sys.getlocale()
# Sys.setlocale("LC_ALL", "English.utf8")
# Sys.setenv(LANG = "en")
Sys.setlocale("LC_ALL", "German.1252")
Sys.setenv(LANG = "en")

# options data.table print
options(datatable.print.class = T,    # Change global options of data.table
        datatable.print.trunc.cols = F,
        datatable.print.nrows = 50)



# ColorDF -----------------------------------------------------------------

    # # get the them to modifiy them 
    # dput(get_colorDF_theme("bw"))
    
    dori <- list(terminal = "dark",
                 sep = " | ", 
                 digits = 2, 
                 fg_na = "darkgoldenrod1", 
                 highlight = list(bg = "yellow"), 
                 col.names = list(fg="tomato", align = "center", decoration = "italic"), 
                 row.names = list(fg = "grey50"), 
                 col.types = NULL,
                 autoformat = TRUE,
                 type.styles = list(integer = list(is.numeric = TRUE, align = "right", fg="darkseagreen1"),
                                    character = list(align = "left"), 
                                    numeric = list(is.numeric = TRUE, align = "right", fg="darkolivegreen1", digits = 3),
                                    identifier = list(decoration = "bold", align = "right"),
                                    logical = list(fg_true = "chartreuse3", fg_false = "brown3", align = "left"), 
                                    factor = list(is.numeric = FALSE, align = "left"),
                                    match = list(fg_match = "darkorchid1", fg = "grey"), 
                                    pval = list(fg_sign = "hotpink1",fg = "grey", sign.thr = 0.05, is.pval = TRUE), 
                                    default = list(align = "left"))
    )
    # add theme
    add_colorDF_theme(dori, id = "dori", description = "blabla")
    # get the options
    # colorDF_options()
    # set the options
    options(colorDF_theme="dori", colorDF_n = 10)
    
    # # test 
    # temp
    # colorDF(temp)
    
    # make it permanent for data.table
    # print.data.table <- colorDF:::print_colorDF
    # remove 
    # rm(print.data.table)

# PATH --------------------------------------------------------------------


datapath <- paste0(rootpath, "Firmen_Listen_EAN/Listen/csv/")
exportpath <- paste0(rootpath, "Firmen_Listen_EAN/Export/")
importpath <- paste0(rootpath, "Firmen_Listen_EAN/Import/")
formattedpath <- paste0(rootpath, "Firmen_Listen_EAN/Listen/Formatted/")
computer.name <- basename(dirname(dirname(rootpath)))



# Hcode -------------------------------------------------------------------

read.csv.wawi <- function(datapath, check.names = T, warn = T) {
  
  temp <- data.table(read.csv(datapath, sep=";", dec = ",", header = T, check.names = check.names))
  # JTL-wawi version 1.6
  if("GTIN" %in% names(temp)) {
    old <- c("Eigene.ID", "Identifizierungsspalte.Vaterartikel", "Onlineshop..BS.Maxi...Onlineshop.aktiv", "Auf.Lager", "Durchschnittlicher.Einkaufspreis..netto.", "Brutto.VK")
    new <- c("Serie", "VID", "Online.Shop.Aktiv", "Lager", "EK", "VK")
    setnames(temp, old, new, skip_absent=T)
  }
  # JTL-wawi version 1.5
  if("EAN.Barcode" %in% names(temp)) {
    old <- c("EAN.Barcode", "Vaterartikel.ArtNr", "Shop.BS.Maxi.Webshop.aktiv", "Lagerbestand.Gesamt", "EK.Netto..für.GLD.", "Std..VK.Brutto")
    new <- c("GTIN", "VID", "Online.Shop.Aktiv", "Lager", "EK", "VK")
    setnames(temp, old, new, skip_absent=T)
  }
  
  if( "GTIN" %in% names(temp) ){
    temp[, GTIN := gsub(" ", "", as.character(format(as.numeric(GTIN), scientific = F)))]
    if( nrow(temp[nchar(GTIN) != 13]) > 1 ) {
      if( warn == T) {
        cat("\n", bgMagenta("[DEBUG]"), " - You have GTIN with different number of character than 13\n\n")
        print(kable(temp[, .N, nchar(GTIN)]))
      }
    }
  }
  return(temp)
}

          # Hcode.table <- read.csv.wawi(paste0(datapath, "JTL_DB_Status_v02.csv"))
          # 
          # # dput(read_clip_tbl())
          # 
          # Hcode.table <- data.table(Hcode.table)
          # Hcode.table[, S := gsub("\\.", "", as.character(S))]
          # Hcode.table[, W := gsub("\\.", "",as.character(W))]
          # Hcode.table[is.na(S), S := ""]
          # Hcode.table[is.na(W), W := ""]
          # 
          # d <- format(Sys.time(),"%Y%m%d")
          # wyear <- substr(d, 1, 4)
          # if( as.numeric(substr(d, 5, 6)) > 6 ) {
          #   syear <- as.numeric(substr(d, 1, 4)) + 1
          # } else {
          #   syear <- substr(d, 1, 4)
          # }
          # 
          # Hcode.table[nchar(S) == 3, S := paste0("0", S)]
          # Hcode.table[nchar(W) == 3, W := paste0("0", W)]
          # Hcode.table[S != "", S := paste0(syear, substr(S, 3, 4), substr(S, 1, 2))]
          # Hcode.table[W != "", W := paste0(wyear, substr(W, 3, 4), substr(W, 1, 2))]
          # Hcode.table
          # 
          # ggplot(Hcode.table, aes(as.POSIXct(strptime(S, format = "%Y%m%d")), Hersteller))+geom_point()+xlab("Date")+scale_y_discrete(limits=rev)+labs(title="New season for Sommer")
          # ggplot(Hcode.table, aes(as.POSIXct(strptime(W, format = "%Y%m%d")), Hersteller))+geom_point()+xlab("Date")+scale_y_discrete(limits=rev)+labs(title="New season for Winter")



# ggplot ------------------------------------------------------------------

scale_fill_Publication <- function(...){
  
  discrete_scale("fill","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
  
}

scale_colour_Publication <- function(...) {
  
  discrete_scale("colour","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
  
}

turnXaxis <- function(...) {
  
  theme(axis.text.x = element_text(angle = 90, hjust = 1), ...)
  
}


noXlabel <- function(...) {
  
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())
  
}

noYlabel <- function(...) {
  
  theme(axis.title.y=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank())
  
}

statMean <- function(...) {
  
  stat_summary(fun.y="mean", size=1, geom="point")
  
}

statSd <- function(...) {
  
  stat_summary(fun.data="mean_sdl", fun.args = list(mult = 1), geom="errorbar", width=0.1)
  
}

hm_color <- function(...) {
  
  scale_fill_gradientn(colours=tim.colors(64))
  
}
hm_redblue <- function(steps = 11) {
  
  # http://www.sthda.com/french/wiki/couleurs-dans-r
  scale_fill_gradientn(colours=brewer.pal(n = steps, name = "RdBu"))
  
}

orderX <- function(vector) {
  
  scale_x_discrete(limits = vector)  
  
}

geom_histogram_line <- function(bins = bins) {
  
  # set color in ggplot
  stat_bin(geom = "line", position = "dodge", bins = bins)
  
}

fontBig <- function() {
  theme(text = element_text(size = 20),
        plot.caption = element_text(size=12,  face="italic", hjust=0, lineheight = 1))
}

theme_set(theme_bw())
# theme_set(theme_bw(base_size=20)) # change default font size





theme_Publication <- function(base_size=14, base_family="helvetica") {
  
  (theme_foundation(base_size=base_size, base_family=base_family)
   + theme(plot.title = element_text(face = "bold",
                                     size = rel(1.2), hjust = 0.5),
           text = element_text(),
           panel.background = element_rect(colour = NA),
           plot.background = element_rect(colour = NA),
           panel.border = element_rect(colour = NA),
           axis.title = element_text(face = "bold",size = rel(1)),
           axis.title.y = element_text(angle=90,vjust =2),
           axis.title.x = element_text(vjust = -0.2),
           axis.text = element_text(), 
           axis.line = element_line(colour="black"),
           axis.ticks = element_line(),
           panel.grid.major = element_line(colour="#f0f0f0"),
           panel.grid.minor = element_blank(),
           legend.key = element_rect(colour = NA),
           legend.position = "bottom",
           legend.direction = "horizontal",
           legend.key.size= unit(0.2, "cm"),
           legend.margin = unit(0, "cm"),
           legend.title = element_text(face="italic"),
           plot.margin=unit(c(10,5,5,5),"mm"),
           strip.background=element_rect(colour="#f0f0f0",fill="#f0f0f0"),
           strip.text = element_text(face="bold")
   ))
  
}


# Small function ----------------------------------------------------------

str_extract_all_bind <- function(variable, pattern) {
  # source : https://stackoverflow.com/a/66910086/2444948
  return(apply(str_extract_all(variable, pattern, simplify = T), 1, paste, collapse=" "))
}


sleepbar <- function(times) {
  
  # Initializes the progress bar
  pb <- txtProgressBar(min = 0,      # Minimum value of the progress bar
                       max = times, # Maximum value of the progress bar
                       style = 3,    # Progress bar style (also available style = 1 and style = 2)
                       width = 50,   # Progress bar width. Defaults to getOption("width")
                       char = "=")   # Character used to create the bar
  for(i in 1:times) {
    Sys.sleep(1)
    setTxtProgressBar(pb, i)
  }
  close(pb)
  
}


expand.table <- function(DATA, expand.vector, name.new.variable) {
  
  debug.easy(length(name.new.variable) != 1, "'name.new.variable' should be length 1.")
  
  DATAnew <- data.table()
  
  for(i in seq_along(expand.vector) ) {
    
    DATA2 <- copy(DATA)
    DATA2[, new := expand.vector[i]]
    setnames(DATA2, "new", name.new.variable)
    DATAnew <- rbind(DATAnew, DATA2)
    
  }
  
  return(DATAnew)
  
}


error <- function() {
  cat(bgRed("      ┌──────────────────────────────────────────────────────────────────────────────┐\n"))
  cat(bgRed("      │                                                                              │\n"))
  cat(bgRed("      │       *** ******     ***    *** * ***                 *********        *     │\n"))
  cat(bgRed("      │       *              *  *   *      **     *******        *    *        *     │\n"))
  cat(bgRed("      │      ******          ****    *******    **      **       ******        *     │\n"))
  cat(bgRed("      │      *               * ***   *   **     *        *       *** *         *     │\n"))
  cat(bgRed("      │      *               *   *** *    ***    *      **       *    ***      *     │\n"))
  cat(bgRed("      │      *****           *       *      **    ******         *      *            │\n"))
  cat(bgRed("      │                                                                         *    │\n"))
  cat(bgRed("      └──────────────────────────────────────────────────────────────────────────────┘\n"))

}

create.dir<-function (wd, newdir, newwd) {  
  #' Create directory, set working directory and keep path as object
  #'
  #' @param wd Source directory where to create your directory
  #' @param newdir Name of your new directory (string)
  #' @param newwd Name of the object storing the path of the new directory (string)
  #' @return The sum of \code{x} and \code{y}
  #' @examples
  #' create.dir(wd, "Output_client", "wdout")
  
  dir.create(file.path(wd, newdir), showWarnings = FALSE)
  assign(newwd, file.path(wd, newdir, "/"), envir = .GlobalEnv)
  setwd(get(newwd))
}

leading0 <- function ( vect, digits ) {
  
  if( !is.numeric(vect) ){
    # cat("", bgMagenta("[DEBUG]"), " - Your vector should be numeric.")
    vect <- sprintf(paste0("%0", digits, "d"), as.numeric(vect))
  } else {
    vect <- sprintf(paste0("%0", digits, "d"), vect)
  }
  
  return(vect)
  
}

p0 <- function(...) {
  return(paste0(...))
}

rP <- function(path) {
  path <- gsub("%20", " ", path)
  path <- gsub("file:///", "", path)
  return(path)
}

debug.easy <- function(logical, message, toprint) {
  
  if( logical ) {
    if( !missing(toprint) ) {
      print(toprint)
    }
    stop(cat("", bgMagenta("[DEBUG]"), " - ", message, "\n"))
  }
  
}

bi <- function(v1, v2) {
  return(paste0(v1, " | ", v2))
}

grepcol <- function(pattern, data, rev=F) {
  
  if( length(pattern) == 1) {
    if( rev ) {
      a <- names(data)[!grepl(pattern, names(data))]
    } else {
      a <- names(data)[grepl(pattern, names(data))]
    }
  } else {
    if( rev ) {
      a <- names(data)[!names(data) %in% pattern]
    } else {
      a <- names(data)[names(data) %in% pattern]
    }
  }
  
  return( a )
}

get.name.Robject <- function(month) {
  deparse(match.call()$month)
}

u <- function(object) {
  return(unique(object)[order(unique(object))])
}

if0 <- function(x, y = "") {
  return(ifelse(x > 0, bgRed(x, y), bgGreen(black( x, y))))
}

quotemeta <- function(string) {
  
  # to escape regex character
  # https://stackoverflow.com/a/14838753/2444948
  str_replace_all(string, "(\\W)", "\\\\\\1")
}

WaitEnter <- function(question) {
  cat(question)
  # to wait input from user as enter or anything except Q
  cat ("Press [enter] to continue. Type Q to quit.")
  line <- readline()
  if(line == "Q") stop()
}

WaitYorN <- function(question) {
  # to wait input from user as enter or anything except Q
  cat (question, "[Y/N]")
  line <- readline()
  if(!line %in% c("y", "Y")) stop()
}

find_matching_pattern <- function(string, vector.pattern) {
  
  # actually you cann use usually str_extract or str_extract_all
  # ff[, p0("ID" , 1:5) := transpose(str_extract_all(filepath, "\\d{6}"))]
  
  temp <- str_extract(string, vector.pattern)
  return(temp[!is.na(temp)])
         
}

gettimestamp <- function(long=T) {
  if( long == T) {
    return(format(Sys.time(),"%Y%m%d-%H%M"))
  } else {
    return(format(Sys.time(),"%Y%m%d"))
  }
}

gsub.s <- function(x) {
  gsub("^ *| *$", "", x)
}

printfast <- function(plot, name, height=400, width=500, ps=12, qualityprint=100, ext = "jpg", wdfunction = getwd()) {
  
  setwd(wdfunction)
  
  if(ext %in% c("jpg", ".jpg", "jpeg", ".jpeg")) {
    jpeg(filename=name, quality=qualityprint, pointsize = ps, height=height, width=width)
    print(
      plot
    )
    dev.off()
    graphics.off()
  }
  
  if(ext %in% c("png", ".png")) {
    png(filename=name, pointsize = ps, height=height, width=width)
    print(
      plot
    )
    dev.off()
    graphics.off()
  }
  
  
}

slugify <- function(x, non_alphanum_replace="", space_replace="_", tolower=TRUE) {
  
  # source: https://rdrr.io/github/cannin/slugify/src/R/slugify.R
  
  x <- gsub("[^[:alnum:] ]", non_alphanum_replace, x)
  x <- trimws(x)
  x <- gsub("[[:space:]]", space_replace, x)
  
  if(tolower) { x <- tolower(x) }
  
  return(x)
}

list.files.only <- function(path, full = T) {
  lf <- list.files(path, full = full)
  ld <- list.dirs(path)
  if(length(ld) == 1) {
    return(lf)
  } else {
    return(lf[-which(lf %in% ld)])
  }
}

grep.return <- function(pattern, vector, invert = F) {
  
  return(vector[grep(pattern, vector, invert = invert)])
  
}

grep.string <- function(vector, collapse = "|") {
  
  cat("[Info] - Use of grep:\n- 'grep -s string *' to search in current directory, not recursively.\n- 'grep -sE string *' to search in current directory, not recursively with regex.- 'grep -RlE 'word1|word2' *.doc' to search recursively, with regex, output in list.\n\n")
  return(paste0(vector, collapse = collapse))
  
}

create.import.liste <- function(data, filename) {
  
  listean <- data.table()
  for(i in 1:nrow(data)) {
    if("Lager" %in% names(data)) {
      lager <- data$Lager[i]
    } else {
      lager <- data$Lagerbestand..gesamt.[i]
    }
    for(j in 1:lager) {
      listean <- rbind(listean, data$GTIN[i])
    }
  }
  write.table(listean$x, filename, quote = F, row.names = F, col.names = F)
  
}




# data.table --------------------------------------------------------------

remove.return.data.table <- function(data) {
  for(i in 1:ncol(data)) {
    data[, names(data)[i] := gsub("\n", "", get(names(data)[i]))]
  }
  data[]
}

replace.all.dt <- function(DATA, pattern, replacement) { 
  
  cols <- names(DATA)
  DATA[, (cols) := lapply(.SD, function(x) gsub(pattern, replacement, x)), .SDcols = cols]

  # for (i in 1:ncol(data)) {
  #   # if(j == 9) {browser()}
  #   data[, names(data)[i] := gsub(pattern, replacement, get(names(data)[i]))]
  #   # wh <- grep(pattern, data[[j]])
  #   # set(data,
  #   #     wh,
  #   #     j,
  #   #     gsub(pattern,
  #   #          replacement,
  #   #          data[wh, ..j])
  #   # )
  # }
  
  # source help : https://stackoverflow.com/questions/8161836/how-do-i-replace-na-values-with-zeros-in-an-r-dataframe
  
}

update.DT <- function(DATA1, DATA2, join.variable, overwrite.variable, overwrite.with.variable) {
  
  if( missing( overwrite.with.variable )) {
    overwrite.with.variable <- overwrite.variable
    cat("", yellow("[INFO]"), " - your 'overwrite.with.variable' will be 'overwrite.variable', since you did not defined it.\n\n")
  }
  
  DATA1[DATA2, c(overwrite.variable) := mget(p0("i.", overwrite.with.variable)), on = join.variable][]
  
}

replace.NA.csv <- function(listcsv, pattern, replacement) {
  
  cat("\n", yellow("[INFO]"), " - Using readLines, so you have to be sure that you use the good pattern !!!!! do not replace for example just NA, with 'NA', but use the separator - e.g. ';NA;'\n")
  
  for(i in seq_along(listcsv)) {

    temp <- readLines(listcsv[i])
    temp <- gsub(pattern, replacement, temp) 
    writeLines(temp, listcsv[i])
    
  }
  
  cat("\nNA replaced.\n")
}

write.csv.wawi <- function(data, datapath) {
  
  
  tryCatch({
    write.table(data, datapath, row.names = F, sep = ";", dec = ",")
  }, error=function(e) {
    write.table(data, datapath, row.names = F, sep = ";", dec = ",")
  })
  Sys.sleep(2)
  tryCatch({
    invisible(capture.output(replace.NA.csv(datapath, pattern = ";NA|^NA;|NA;NA", replacement = ";")  ))
  }, error=function(e) {
    invisible(capture.output(replace.NA.csv(datapath, pattern = ";NA|^NA;|NA;NA", replacement = ";")  ))
  })
  
  # check if it will be read normally
  temp <- data.table(read.csv(datapath, sep=";", dec = ",", header = T))
  temp2 <- data.table(read.csv(datapath, sep=";", dec = ",", header = T, quote = "\\\""))
  
  first.line.error <- which(temp[[1]] != temp2[[1]])[1]
  temp3 <- temp[first.line.error]

  first.line.error2 <- readLines(datapath)[first.line.error]
  
  if( nrow(temp) != nrow(temp2) ) {
    cat("\n")
    print(temp3)
    cat("\n")
    cat("\n")
    print(first.line.error2)
    stop(p0("\n\n", bgMagenta("[DEBUG]"), " - You have strange quotes somewhere (e.g. \'' or \\\"), check line ", first.line.error, " your file will not be read correctly by Wawi (check print above)\nYou can replace them like this \t\t      data[, Bezeichnung := gsub('\\\"', '', Bezeichnung)]  \n"))
    
  }
}

dtjoin <- function(x, y, type = "left") {
  
  if( !type %in% c("left", "inner", "right", "full", "semi", "anti")) {
    stop("", bgMagenta("[DEBUG]"), " - Wrong type, please use : ", paste0(c("left", "inner", "right", "full", "semi", "anti"), collapse = ", "))
  }
  
  if(type == "left") {
    temp <- data.table(left_join(x, y))
  }
  
  if(type == "inner") {
    temp <- data.table(inner_join(x, y))
  }
  
  if(type == "right") {
    temp <- data.table(right_join(x, y))
  }
  
  if(type == "full") {
    temp <- data.table(full_join(x, y))
  }
  
  if(type == "semi") {
    temp <- data.table(semi_join(x, y))
  }
  
  if(type == "anti") {
    temp <- data.table(anti_join(x, y))
  }
  
  return(temp)
  
}

class.DT.Dorian <- function(data) {
  typ <- setDT(lapply(data, class))
  temp <- data.table(variable = names(typ), value = data.table(t(typ))$V1)
  return(temp)
}

fill.category.empty.line <- function(data, which.variable.category, empty.variable) {
  
  # Function that is creating Category columns when you have data like Nordisk with category separated verticaly:
  # Build right now only for 2 categories
  # 
  # 
  #   |Item.No.     |Item.Name                  |Specification.Color |Universe |Category |
  #   |:------------|:--------------------------|:-------------------|:--------|:--------|
  #   |SPIRIT       |                           |                    |         |         |
  #   |Spirit Tents |                           |                    |         |         |
  #   |148055       |Asgard Tech Mini Tent Sand |Sand                |Spirit   |Tents    |
  #   |148062       |Kari Mini Tarp Sand        |Sand                |Spirit   |Tents    |
  #   |148051       |Ydun Tech Mini Tent Sand   |Sand                |Spirit   |Tents    |
  #
  # to
  # 
  #   |Item.No.     |Item.Name                  |Specification.Color |Universe |Category |K1     |K2           |
  #   |:------------|:--------------------------|:-------------------|:--------|:--------|:------|:------------|
  #   |SPIRIT       |                           |                    |         |         |SPIRIT |             |
  #   |Spirit Tents |                           |                    |         |         |SPIRIT |Spirit Tents |
  #   |148055       |Asgard Tech Mini Tent Sand |Sand                |Spirit   |Tents    |SPIRIT |Spirit Tents |
  #   |148062       |Kari Mini Tarp Sand        |Sand                |Spirit   |Tents    |SPIRIT |Spirit Tents |
  #   |148051       |Ydun Tech Mini Tent Sand   |Sand                |Spirit   |Tents    |SPIRIT |Spirit Tents |
  
  
  data[, K1 := ""]
  data[, K2 := ""]
  
  data[1, K1 := get(which.variable.category)]
  
  for(i in 2:nrow(data)) {
    if( data[i, get(empty.variable)] == "" ) {
      if( data[i-1, get(empty.variable)] == "" ) {
        data[i, K1 := data$K1[i-1]]
        data[i, K2 := get(which.variable.category)]
      } else {
        if( data[i+1, get(empty.variable)] != "" ) { # change here 08.03.24 to work with only 1 Kat
          data[i, K2 := ""]
          data[i, K1 := get(which.variable.category)]
        } else {
          data[i, K1 := data$K1[i-1]]
          data[i, K2 := get(which.variable.category)]
        }
      }
    } else {
      data[i, K1 := data$K1[i-1]]
      data[i, K2 := data$K2[i-1]]
    }
    # if(i > 355) {
    #   print(data[1:i, .(which.variable.category, empty.variable, K1, K2)])
    #   WaitEnter()
    # }
  }
  
  ((data))
  
  data <- data[get(empty.variable) != ""]
  
  print(data[,.N,.(K1, K2)])
  
  assign("data", data, env = .GlobalEnv)
  
}

remove.dt.columns.paste.console <- function(vector, data) {
  data[, u(str_split(gsub("^ *|(?<= ) | *$", "", vector, perl = T), " ")[[1]]) := NULL]
}

rolling.value.if.empty <- function(data, list.col) {
  
  # list.col is a string vector
  
  for(j in seq_along(list.col)) {
    for(i in 2:nrow(data)) {
      if( any(is.na(data[i][[list.col[j]]]), data[i][[list.col[j]]] == "") )  {
        # data[i][[list.col[j]]] <- data[i-1][[list.col[j]]]
        data[i, c(list.col[j]) := data[i-1][[list.col[j]]]][]
      }
    }
  }
  
}

dtjoin.fuzzy <- function(DATA1, DATA2, on1 = "col.DATA", on2 = "col.DATA2", .max_dist = 100) {
      
  require(fuzzyjoin)
  
  # will search on2 in each on1 like grepl and give a distance. Then a small calcul to see which would be the best depending on the number of character of each and boom you got it.
  # on2 should be the one to look in on1
  
  # debug.easy(mean(nchar(DATA2[[on2]])) > mean(nchar(DATA1[[on1]])), "on2 should be the one to look in on1, seems to have more characters in general")
  
  by1 <- eval(parse(text = p0("c(", on1, " = '", on2, "')")))
  DATA <- data.table(stringdist_left_join(DATA1, DATA2, by = by1, method = "lcs", max_dist = .max_dist, distance_col = 'str.diff')) # use distance 0 = total match actually
  
  # browser()
  # check <- "A7554A"
  DATA[, str.diff.on2 := str.diff - abs(nchar(get(on2)) - nchar(get(on1)))]
  # DATA[ID0  %like%  check & filename2 %like% check, .(ID0, filename2, str.diff, str.diff.on2)]
  DATA <- DATA[DATA[, .I[str.diff.on2 == min(str.diff.on2)], on2]$V1] # get best match based on on1
  # DATA[ID0  %like% check & filename2 %like% check, .(ID0, filename2, str.diff, str.diff.on2)]
  
  # order depending on length of variables
  DATA <- DATA[order(-nchar(get(on1)), -nchar(get(on2)))]
  # j <- DATA[, .I[ID0 %like% check & filename2 %like% check]]
  temp <- copy(DATA)
  DATA0 <- data.table()
  for(i in 1:nrow(DATA)) {
    # filter on on2, if match perfect assign the on2 to on1 and remove it from the rest of the table        
    if( all(DATA[[on2]][i] %in% temp[[on2]], DATA[[on2]][i] %like% DATA[[on1]][i] ) ) {
      DATA0 <- rbind(DATA0, DATA[i])
      temp <- temp[!get(on2) %in% DATA[[on2]][i]]
    } else {
      # important to keep this to get multiples images in Kinder
      if( nrow(DATA[get(on2) == DATA[[on2]][i]]) == 1) {
        DATA0 <- rbind(DATA0, DATA[i])
      } else {
        temp <- temp[-1]
      }
    }
  }      
  
  DATA0[, c(on1, on2, "str.diff", "str.diff.on2") := NULL]
  
  return(DATA0)
  
}



# read - write ------------------------------------------------------------

readAll <- function(listfile, fill = F, skip = 0, header = T) {
  
  lst <- lapply(listfile, fread, skip=skip, header = header, integer64 = "character", encoding = "UTF-8")
  tryCatch({
    # give a list of file and read them all and rbind
    lst <- mapply(cbind, lst, file=basename(listfile), SIMPLIFY=F)
    dt <- rbindlist(lst, fill = fill)
    return(dt)
  }, error=function(e) {
      info <- data.table(filename = listfile, ncol = unlist(lapply(lst, ncol)))
      print(info)
      assign("info", info, envir = .GlobalEnv)
      debug.easy(T, "Not same number of column check the Robject 'info' (assigned) ")
      
  })
  
  
}

read.maxi <- function(info, datapath = datapath, Firma) { 
  
  info[, filename := rP(filename)]
  info[, filename.no.ext := gsub(".xlsx$", "", basename(filename))]
  info[, filename.no.ext := gsub(".csv$", "", filename.no.ext)]
  
  debug.easy(length(Hcode) > 1, "You have 2 Hcode !!!!")
  
  # Set working directory
  wd <- dirname(dirname(info$filename[1]))
  setwd(wd)
  
  assign("wd", wd, envir = .GlobalEnv)
  
  create.dir(wd, "Formatted", "wdout")
  assign("wdout", wdout, envir = .GlobalEnv)
  setwd(wd)
  
  new.name <- p0(wdout, "/", gsub(" ", "_", Firma), "_", p0(info$Serie, collapse = "-"), ".csv")
  new.name.V <- gsub(".csv", "_VATER.csv", new.name)
  new.name.K <- gsub(".csv", "_KINDER.csv", new.name)
  assign("new.name", new.name, envir = .GlobalEnv)
  assign("new.name.V", new.name.V, envir = .GlobalEnv)
  assign("new.name.K", new.name.K, envir = .GlobalEnv)
  
  # browser()
  
  data <- data.table()
    for(i in 1:nrow(info)) {
      temp <- data.table(read.csv(p0(datapath, info$filename.no.ext, ".csv"), sep = ";", skip = info$n.row.to.skip[i], encoding = "UTF-8"))
      temp[, Serie := info$Serie[i]]
      # temp[, file := basename(info$filename[i])]
      data <- rbind(data, temp, fill = T)
    }
  
  # file.copy(info$filename, rP(p0(rootpath, "Firmen_Listen_EAN/Listen/Used_to_Import_BU_Rscript_Automated")), overwrite = T)
  
  
  replace.all.dt(data, "\"", "''")
  replace.all.dt(data, "\n|</b>|<br>|<.*?>|^ *| *$", "")
  
  data[]
  
  return(data)
}






# check maxi --------------------------------------------------------------

clean.info.nummer.name.Maxi <- function(data = dataK) {
  
  data[, Artikelname := gsub(" - $", "", Artikelname)]
  data[grep("-NA", Artikelnummer), Artikelname := gsub(" - NA", "", Artikelname)]
  data[grep("-NA", Artikelnummer), Artikelnummer := gsub("-NA", "", Artikelnummer)]
  
  data[, Artikelnummer := gsub("-$", "", Artikelnummer)]
  data[grep("-\\.", Artikelnummer), Artikelname := gsub(" - \\.", "", Artikelname)]
  data[grep("-\\.", Artikelnummer), Artikelnummer := gsub("-\\.", "", Artikelnummer)]
  data[grep("--", Artikelnummer), Artikelnummer := gsub("--", "-", Artikelnummer)]
  
  data[, Artikelname := gsub(" - $", "", Artikelname)]
  data[, Artikelname := gsub(" - NA$", "", Artikelname)]
  data[, Artikelname := gsub(" -  - ", " - ", Artikelname)]
  data[, Artikelname := gsub(" -  -  - ", " - ", Artikelname)]
  data[, Artikelname := gsub(" - NA - ", " - ", Artikelname)]
  data[, Artikelname := gsub(" - - ", " - ", Artikelname)]
  data[, Artikelname := gsub(" - NA$", "", Artikelname)]
  data[, Artikelname := gsub(" - $", "", Artikelname)]
  data
}

create.artikelnummer.Maxi <- function(data = data, var.artikelnummer, var.code) {
  
  browser()
  data <- dtjoin(data, data[, .N, .(var.artikelnummer, var.code)][, p0(var.code, ".code") := leading0(1:.N, 3), .(var.artikelnummer)][, N := NULL][])
  cat("", yellow("[INFO]"), " - Size code added\n")
  
}

maxi.check <- function(data, dont.check.1.variation = F) {
  
  
  
  
  # EAN
  debug.easy(length(unique(nchar(data[!is.na(GTIN)]$GTIN))) > 1,
             p0("Your have strange EAN length (number of characters: ",
                p0(unique(nchar(data[!is.na(GTIN)]$GTIN)), collapse = ", "),
                ")"))
  debug.easy(unique(nchar(data[!is.na(GTIN)]$GTIN)) != 13,
             p0("Your EAN code should be length 13 and is ", unique(nchar(data[!is.na(GTIN)]$GTIN))))
  debug.easy(nrow(data[grepl("\\s", GTIN)]) != 0,
             p0("You have spaces in your EAN ... \t\t\t", bgMagenta("[DEBUG]"), " - data[grepl('\\s', EAN)]"))
  
  if( dont.check.1.variation ) {
    debug.easy(nrow(data[!is.na(VID) & Keep.VaterID == F, .N, VID][N == 1] > 0),
             "You have Kinder without variation (N=1) with a VID. They will not be created in the DB ... Remove the VID (NA) - dataall[!is.na(VID),.N, VID][N == 1]       or   \n dataK[VID %in% dataall[!is.na(VID),.N, VID][N == 1]$VID]       or \n  dataV[Artikelnummer %in% dataall[!is.na(VID),.N, VID][N == 1]$VID]")
  }
  # Variation duplicate It will create a new Vater if exists
  debug.easy(nrow(data[!is.na(VID) & Keep.VaterID == F, .N, c("VID", grepcol("Variationswert", data))][N > 1]) > 0,
             "You have duplicate Variation combination, please check this, \nTo Troubelshot run this : \n\ndataall[!is.na(VID) & Keep.VaterID == F, .N, c('VID', grepcol('Variationswert', dataall))][order(VID)][N > 1]\n\ndataall[VID %in% dataall[!is.na(VID) & Keep.VaterID == F, .N, c('VID', grepcol('Variation', dataall))][N > 1]$VID, .N,c('VID', 'Artikelname', grepcol('Variationswert', dataall))][order(Artikelname)]\n\ndata[VID %in% dataall[!is.na(VID) & Keep.VaterID == F, .N, c('VID', grepcol('Variation', dataall))][N > 1]$VID][order(VID)]")
  
  
  # check if end with space, create problem import
  vectorlist <- p0("Variationswert.", 1:4)
  for(i in 1:length(vectorlist)) {
    if( vectorlist[i] %in% names(data) ) {
      debug.easy(nrow(data[grep(" $|^ ", get(vectorlist[i]))]) > 0, p0("You have a ", vectorlist[i], " that begin with space or end with space, please modify :\n\t\tdata[, Colour := gsub('^ *| *$', '', Colour)]\ndataall[grep(' $|^ ', ", vectorlist[i], ")]$", vectorlist[i]))
    }
  }
  
  # Variation
  # this will permit to usually have color and size variation, you need to have in Varia1 a string if Varia2 is a string ---> so let's write None
  if( "Variationswert.1" %in% names(data) ) {
    data[is.na(Variationswert.1), Variationswert.1 := ""]
    # check if Farbe have several value for a Vater and one is "", need to change this "" to a string
    K.with.Var <- data[!is.na(VID), .N, .(VID)][N > 1]
    K.to.change <- data[VID %in% K.with.Var$VID, .N, .(VID, Variationswert.1)][Variationswert.1 == ""]
    nline <- nrow(data[VID %in% K.to.change$VID & Variationswert.1 == ""])
    data[VID %in% K.to.change$VID & Variationswert.1 == "", Variationswert.1 := "None"]
    data[, Variationswert.1 := gsub(" - ", "-", Variationswert.1)]
    if( nline > 0 ) {
      cat("", yellow("[INFO]"), " - Transform ", nline, " lines where Variationwertname.1 was '' but need to be a string since other Var exists for the Parent, became 'None'\n\n")
    }
  }
  
  
  if( "Variationswert.2" %in% names(data) ) {
    data[is.na(Variationswert.2), Variationswert.2 := ""]
    # change this code because 1 Vater like this: the Größe == "", was not changed because you have only 1 N per Varia1
    # K.with.Var <- data[!is.na(VID), .N, .(VID, Variationswert.1)][N > 1] # old code 20211006
    K.with.Var <- data[!is.na(VID) & Variationswert.2 == "", .N, .(VID, Variationswert.1)]
    K.to.change <- data[VID %in% K.with.Var$VID, .N, .(VID, Variationswert.1, Variationswert.2)][Variationswert.2 == ""]
    nline <- nrow(data[VID %in% K.to.change$VID & Variationswert.2 == ""])
    data[VID %in% K.to.change$VID & Variationswert.2 == "", Variationswert.2 := "None"]
    data[Variationswert.2 != "" & Variationswert.1 == "", Variationswert.1 := "None"] 
    data[, Variationswert.2 := gsub(" - ", "-", Variationswert.2)]
    if( nline > 0 ) {
      cat("", yellow("[INFO]"), " - Transform ", nline, " lines where Variationwertname.2 was '' but need to be a string since other Var exists for the Parent, became 'None'\n\n")
    }
  }
  # if( "Variationswert.3" %in% names(data) ) {
  #   data[is.na(Variationswert.3), Variationswert.3 := ""]
  #   # K.with.Var <- data[!is.na(VID), .N, .(VID, Variationswert.1, Variationswert.2)][N > 1]
  #   K.with.Var <- data[!is.na(VID) & Variationswert.2 != "" & Variationswert.3 != "", .N, .(VID, Variationswert.1, Variationswert.2)]
  #   K.to.change <- data[VID %in% K.with.Var$VID, .N, .(VID, Variationswert.1, Variationswert.2, Variationswert.3)][Variationswert.3 == ""]
  #   nline <- nrow(data[VID %in% K.to.change$VID & Variationswert.3 == ""])
  #   data[VID %in% K.to.change$VID & Variationswert.3 == "", Variationswert.3 := "None"]
  #   data[, Variationswert.3 := gsub(" - ", "-", Variationswert.3)]
  #   if( nline > 0 ) {
  #     cat("", yellow("[INFO]"), " - Transform ", nline, " lines where Variationwertname.3 was '' but need to be a string since other Var exists for the Parent, became 'None'\n\n")
  #   }
  # }
  # if( "Variationswert.4" %in% names(data) ) {
  #   data[is.na(Variationswert.4), Variationswert.4 := ""]
  #   # K.with.Var <- data[!is.na(VID), .N, .(VID, Variationswert.1, Variationswert.2, Variationswert.3)][N > 1]
  #   K.with.Var <- data[!is.na(VID) & Variationswert.2 != "" & Variationswert.3 != "" & Variationswert.4 != "", .N, .(VID, Variationswert.1, Variationswert.2, Variationswert.3)]
  #   K.to.change <- data[VID %in% K.with.Var$VID, .N, .(VID, Variationswert.1, Variationswert.2, Variationswert.3, Variationswert.4)][Variationswert.4 == ""]
  #   nline <- nrow(data[VID %in% K.to.change$VID & Variationswert.4 == ""])
  #   data[VID %in% K.to.change$VID & Variationswert.4 == "", Variationswert.4 := "None"]
  #   data[, Variationswert.4 := gsub(" - ", "-", Variationswert.4)]
  #   if( nline > 0 ) {
  #     cat("", yellow("[INFO]"), " - Transform ", nline, " lines where Variationwertname.4 was '' but need to be a string since other Var exists for the Parent, became 'None'\n\n")
  #   }
  # }
  
  # add 20211011 - to avoid remove variation where there is nothing
  # do not do for the first 2 variation ....
  # if( "Variationswert.3" %in% names(data) ) {
  #   keep <- data[GTIN != "" & Variationswert.3 != "", .N, .(VID, ArtikelnameV,  Variationswert.1, Variationswert.2, Variationswert.3)]$VID
  #   data[!VID %in% keep, Variationsname.3 := ""]
  # }
  # if( "Variationswert.4" %in% names(data) ) {
  #   keep <- data[GTIN != "" & Variationswert.4 != "", .N, .(VID, ArtikelnameV,  Variationswert.1, Variationswert.2, Variationswert.3, Variationswert.4)]$VID
  #   data[!VID %in% keep, Variationsname.4 := ""]
  # }
  
  # old code 20210510
  # if( "Variationswert.1" %in% names(data) ) {
  #   data[Variationswert.1 == "", Variationswert.1 := NA]
  # }
  # if( "Variationswert.2" %in% names(data) ) {
  #   data[Variationswert.2 == "", Variationswert.2 := NA]
  #   data[is.na(Variationswert.1) & !is.na(Variationswert.2), Variationswert.1 := "None"]
  # }
  # if( "Variationswert.3" %in% names(data) ) {
  #   data[Variationswert.3 == "", Variationswert.3 := NA]
  #   data[is.na(Variationswert.1) & is.na(Variationswert.2) & !is.na(Variationswert.3), ':=' (Variationswert.1 = "None", Variationswert.2 = "None")]
  # }
  

  
  # EAN
  debug.easy( nrow(data[!is.na(GTIN), .N, GTIN][N > 1]) > 0 ,
              "You have duplicates EAN ... check please \n\n\t\tdataall[, .N, GTIN][!is.na(GTIN)][N > 1]\n\t\tunique(dataall[, .N, GTIN][!is.na(GTIN)][N > 1]$GTIN)\n\t\tdput(unique(dataall[, .N, GTIN][!is.na(GTIN)][N > 1]$GTIN))\n\t\tdataall[GTIN %in% dataall[, .N, GTIN][!is.na(GTIN)][N > 1]$GTIN][order(GTIN)]\n\t\tkable(dataall[GTIN %in% dataall[, .N, GTIN][!is.na(GTIN)][N > 1]$GTIN][order(GTIN), .(GTIN, Artikelname, Artikelnummer)])")
  
  # Price
  data[UVP == "Inf", UVP := NA]
  data[VK == "Inf", VK := NA]
  data[EK == "Inf", EK := NA]
  # data[EK.Netto == "Inf", EK.Netto := NA] # do not activate or you will need to give a lieferant
  
  # Explorer should not be used
  data[, Artikelname := gsub("Explorer|explorer", "Eschplorer", Artikelname)]
  data[, Artikelname := gsub("Xplorer", "Schplorer", Artikelname)]
  
  
  # certainly do not need this anymore - new function replace.all.dt
  if( "Kurzbeschreibung" %in% names(data) ) {
    data[, Kurzbeschreibung := gsub("\n|</b>|<br>|<.*?>|\\\"", " --- ", Kurzbeschreibung)]
  }
  if( "Beschreibung" %in% names(data) ) {
    data[, Kurzbeschreibung := gsub("\n|</b>|<br>|<.*?>|\\\"", " --- ", Beschreibung)]
  }
  
  
  # remove r or TM
  data[, Artikename := gsub("™|®", "", Artikelname)]
  if("ArtikelnameV" %in% names(data)) {
    data[, ArtikenameV := gsub("™|®", "", ArtikelnameV)]
  }
  
  
  data[, Lieferant := Hersteller] 
  data[, "Bestandsführung aktiv" := "Y"]
  
  # to avoid error by importing
  data[is.na(VID) & is.na(UVP), UVP := 0]
  data[is.na(VID) & is.na(EK), EK := 0]
  data[is.na(VID) & is.na(VK), VK := 0]
  
  # remove Kategorie for Kinder otherwise it is making a warning
  if( "Kategorie.Ebene.1" %in% names(data) ) {data[!is.na(VID), Kategorie.Ebene.1 := ""]  }
  if( "Kategorie.Ebene.2" %in% names(data) ) {data[!is.na(VID), Kategorie.Ebene.2 := ""]  }
  if( "Kategorie.Ebene.3" %in% names(data) ) {data[!is.na(VID), Kategorie.Ebene.3 := ""]  }
  if( "Kategorie.Ebene.4" %in% names(data) ) {data[!is.na(VID), Kategorie.Ebene.4 := ""]  }
  if( "Kategorie.Ebene.5" %in% names(data) ) {data[!is.na(VID), Kategorie.Ebene.5 := ""]  }
  if( "Kategorie.Ebene.6" %in% names(data) ) {data[!is.na(VID), Kategorie.Ebene.6 := ""]  }
  
  
  
  check.table.for.wawi(data)
  
  
}

rename.col.names.maxi <- function(DATA) {
  
  # setnames(data, c("Serie", "VK", "EK", "VID"), c("Eigene ID", "Brutto-VK", "Durchschnittlicher Einkaufspreis (netto)", "Identifizierungsspalte Vaterartikel"))
  setnames(DATA, names(DATA), gsub("^Serie$", "Eigene ID", names(DATA)))
  setnames(DATA, names(DATA), gsub("^VK$", "Brutto-VK", names(DATA)))
  setnames(DATA, names(DATA), gsub("^EK$", "Durchschnittlicher Einkaufspreis (netto)",names(DATA)))
  setnames(DATA, names(DATA), gsub("^VID$", "Identifizierungsspalte Vaterartikel",  names(DATA)))
  setnames(DATA, names(DATA), gsub("\\.", " ",  names(DATA)))
  setnames(DATA, names(DATA), gsub("\\___", ".",names(DATA)))
  setnames(DATA, names(DATA), gsub("\\__", "/", names(DATA)))
  setnames(DATA, names(DATA), gsub("\\_", "-", names(DATA)))
  
}

replace.col.names.maxi <- function(data) {
  
  nameori <- deparse(substitute(data))
  nameBU <- p0(nameori, "BU")
  
  assign(nameBU, copy(data), env =  .GlobalEnv)
  
  cat("", yellow("[INFO]"), " - ", nameBU, "assigned - no stranged columns names\n\n")
  
  rename.col.names.maxi(data)
  # setnames(data, names(data), gsub("\\.", " ",names(data)))
  # setnames(data, names(data), gsub("\\___", ".",names(data)))
  # setnames(data, names(data), gsub("\\__", "/",names(data)))
  # setnames(data, names(data), gsub("\\_", "-",names(data)))

  
  # add empty columns if issing in order to fit to the Vorlage for import Vater or Kinder
  collist <- c(
                "Identifizierungsspalte Vaterartikel",
                "ArtikelnameV",
                "GTIN",
                "Artikelnummer",
                "Artikelname",
                "Variationswert 1",
                "Variationswert 2",
                "Variationsname 2",
                "Variationsname 1",
                "Hersteller",
                "Eigene ID",
                "UPC",
                "UVP",
                "Brutto-VK",
                "Durchschnittlicher Einkaufspreis (netto)",
                "Kategorie Ebene 1",
                "Kategorie Ebene 2",
                "Kategorie Ebene 3",
                "Kategorie Ebene 4",
                "Kategorie Ebene 5",
                "Kategorie Ebene 6",
                "Verkaufseinheit",
                "Lieferant",
                "Artikelnummer (Lieferant)",
                "Bestandsführung aktiv",
                "Darstellungsform der Variation 1",
                "Darstellungsform der Variation 2",
                "Darstellungsform der Variation 3",
                "Beschreibung",
                "Kurzbeschreibung",
                "Bild 1 Pfad/URL",
                "Bild 2 Pfad/URL",
                "Bild 3 Pfad/URL",
                "Bild 4 Pfad/URL",
                "Bild 5 Pfad/URL",
                "N")
  
  # do not know what is this for
  old.names.data <- names(data)
  for(i in seq_along(collist)) {
    if( !collist[i] %in% old.names.data ) {
      if( collist[i] %like% "Darstellungsform der Variation") {
        data[, collist[i] := "SWATCHES"]
      } else {
        data[, collist[i] := ""]
      }
    }
  }
  
  
  # remove non wanted columns
  old.names.data <- names(data)
  col2del <- old.names.data[which(!old.names.data %in% collist)]
  cat("", bgMagenta("[DEBUG]"), " - Column", p0(col2del, " - "), "will be removed because not wanted\n")
  data[, c(col2del) := NULL]
  
  
  setcolorder(data, collist)
  assign("collist", collist, env = .GlobalEnv)
  cat("\n", yellow("[INFO]"), " - collist assigned : list of columns needed for Ameise import\n")
  
  debug.easy(any(!names(data) %in% collist), p0("You have too much columns for Ameise batch import ...\n\t\t\tnames(", nameori, ")[!names(", nameori, ") %in% collist]\n"))
  debug.easy(any(!collist %in% names(data)), p0("You have columns missing for Ameise batch import ...\n\t\t\tcollist[!collist %in% names(", nameori, ")]\n"))
  
  
}

check.DB.ameise.v03 <- function(data) {
  
  # old code before 20211005
  # K <- data[!is.na(VID)]
  # V <- data[is.na(VID)] # if you do not use this you will not realize that you update a Kind instead of a Vater without kind
  V <- data[is.na(GTIN)]
  K <- data[!is.na(GTIN)]
  
  assign("K", K, env = .GlobalEnv)
  assign("V", V, env = .GlobalEnv)
  
  
  
  # see which EAN changed
  cat("\n\n", yellow("[INFO]"), " - Analysis on Kinder only GTIN\n")
  cat("-----------------------------------------------------------------------\n\n")
  
  
  temp <- dbK[GTIN %in% K$GTIN]$GTIN
  K.GTIN.no <- K[!GTIN %in% temp]
  K.GTIN.yes <- K[GTIN %in% temp]
  # K.GTIN.no <- K[!GTIN %in% dbK$GTIN]
  # K.GTIN.yes <- K[GTIN  %in% dbK$GTIN]
  
  # benchmark(K.GTIN.no[Artikelnummer %in% dbK$Artikelnummer.db], dbK[Artikelnummer.db %in% K.GTIN.no$Artikelnummer], replications = 1)
  temp <- dbK[Artikelnummer.db %in% K.GTIN.no$Artikelnummer]$Artikelnummer.db
  
  K.GTIN.no.pb.AN <- dtjoin(K.GTIN.no[Artikelnummer %in% temp, .(Artikelnummer, Artikelname, GTIN)], dbK[, .(Artikelnummer = Artikelnummer.db, Artikelname.db = Artikelname, Serie.db = Serie, GTIN.db = GTIN)])
  
  
  
  K.GTIN.up <- dtjoin(K.GTIN.yes[,.(Artikelnummer, GTIN, Artikelname, VID)],
                     dbK[, .(Artikelnummer.db, GTIN, Artikelname.db = Artikelname, VID.db = VID, Hersteller)])
  setcolorder(K.GTIN.up, names(K.GTIN.up)[order(names(K.GTIN.up))])
  K.GTIN.up.pb <- K.GTIN.up[Artikelnummer != Artikelnummer.db]
  K.GTIN.up.pb.V <- K.GTIN.up[VID.db != "" & VID != VID.db]
  K.GTIN.up.pb.V2 <- K.GTIN.up.pb.V[VID != "" & VID.db != ""] # Kinder with wrong link
  # double or more Vater in db for1 Vater in import
  temp <- dtjoin(K.GTIN.up.pb.V[, .(VID, VID.db)], dbK[VID %in% K.GTIN.up.pb.V2$VID.db, .N, VID][, .(N, VID.db = VID)]) # join to get the number of article in db per VID.db
  vater2keep <- temp[temp[, .I[N == max(N)], VID]$V1] # Vater to rename
  vater2delete <- temp[!temp[, .I[N == max(N)], VID]$V1] # Vater to delete
  
  
  double.V.db <- K.GTIN.up.pb.V2[VID %in% K.GTIN.up.pb.V2[, .N, .(VID, VID.db)][,.N, VID][N >1]$VID] # double or more Vater in db for1 Vater in import
  double.V.im <- K.GTIN.up.pb.V2[VID.db %in% K.GTIN.up.pb.V2[, .N, .(VID, VID.db)][,.N, VID.db][N >1]$VID.db] # double or more Vater in db for1 Vater in import
  
  
  double.V.db2 <- dbV[Artikelname %in% dbV[Artikelnummer.db %in% K.GTIN.up.pb.V2$VID.db]$Artikelname & !Artikelnummer.db %in% K.GTIN.up.pb.V2$VID.db, .(Artikelname, VID.db = Artikelnummer.db)] # double or more Vater in db for1 Vater in import but based on name, since renummer vater is based on name and serie
  # Prepare for renummer Vater without those doubles differences
  
  
  # old 20240517
  # K.GTIN.up.pb.V2.modify.Vater <- dtjoin(dbV[Artikelnummer.db %in% K.GTIN.up.pb.V2[!VID.db %in% c(double.V.db$VID.db, double.V.im$VID.db, double.V.db2$VID.db)]$VID.db, .(Artikelname, VID.db = Artikelnummer.db, Serie)],
  #                                        u(K.GTIN.up.pb.V2[, .(Artikelnummer = VID, VID.db)])) 
  # K.GTIN.up.pb.V2.V.delete <- dbV[Artikelnummer.db %in% K.GTIN.up.pb.V2$VID.db, .(Artikelnummer = Artikelnummer.db, Artikelname = p0(Artikelname, "-todelete"))]
  K.GTIN.up.pb.V2.modify.Vater <- dtjoin(dbV[Artikelnummer.db %in% K.GTIN.up.pb.V2[VID.db %in% vater2keep$VID.db]$VID.db, .(Artikelname, VID.db = Artikelnummer.db, Serie)],
                                        u(K.GTIN.up.pb.V2[, .(Artikelnummer = VID, VID.db)]))  
  
  
  K.GTIN.up.pb.V2.modify.Vater2 <- K.GTIN.up.pb.V2.modify.Vater[, .(Artikelname, Artikelnummer, Serie)]
  K.GTIN.up.pb.V2.V.delete <- dbV[Artikelnummer.db %in% vater2delete$VID.db, .(Artikelnummer = Artikelnummer.db, Artikelname = p0(Artikelname, "-todelete"))]
  K.GTIN.up.pb.V2.V.import <- dbK.lager[VID %in% K.GTIN.up.pb.V2$VID.db][, .(GTIN, Lagerbestand = Lager)]
  
  lost.K <- dbK[VID %in% K.GTIN.up.pb.V2$VID.db][!GTIN %in% K$GTIN]
  lost.K.lager <- dbK.lager[VID %in% K.GTIN.up.pb.V2$VID.db][!GTIN %in% K$GTIN]
  notlost.K <- dbK[VID %in% K.GTIN.up.pb.V2$VID.db][GTIN %in% K$GTIN]
  notlost.V.delete <- dbV[Artikelnummer.db %in% notlost.K$VID & !Artikelnummer.db %in% lost.K$VID, .(Artikelnummer = Artikelnummer.db, Artikelname = p0(Artikelname, "-todelete"))]
  V2keep <- dbV[Artikelnummer.db %in% lost.K$VID, .(Artikelnummer.db, Artikelname)]
  
  temp <- dtjoin(dbK[VID %in% lost.K.lager$VID, .(GTIN, VID.db = VID)], K[, .(GTIN, VID)])
  temp[, GTIN := NULL]
  temp <- u(temp)
  
  
  lo.K <- K.GTIN.up.pb.V[VID == ""]
  lo.K.db <- K.GTIN.up.pb.V[VID.db == ""]
  # lo.K.db.delete <- lo.K.db[, .(GTIN, Artikelname = p0(Artikelname.db, "-todelete"))]
  lo.K.db.delete <- lo.K.db[, .(Artikelnummer = Artikelnummer.db, Artikelname = Artikelname.db)]
  lo.K.db.delete[, Artikelname := p0(Artikelname, "-todelete")]
  lo.K.db.import <- dbK.lager[GTIN %in% lo.K.db$GTIN][, .(GTIN, Lagerbestand = Lager)]
  
  # GTIN - Artikelnummer part ---
  cat("\n", yellow(nrow(K)), "Kinder for", yellow(nrow(V)), "Vater in import\n")
  
  cat("\t", yellow( nrow(K.GTIN.no)), "\tKinder in import NOT in db\n")
  cat("\t\t", if0(nrow(K.GTIN.no.pb.AN)), "\tArtikelnummer exists, but not GTIN, error, change nummer", silver("K.GTIN.no.pb.AN\n"))
  cat("\t\t\t- use", cyan("Ameise.import.renummer.Kinder.Serie(DB = which.db, data = K.GTIN.no.pb.AN)"), " - it will add the serie from the db to the Artikelnummer in the db\n")
  
  cat("\t", yellow(nrow(K.GTIN.yes)), "\tKinder in import AND in db\n")
  cat("\t\t", yellow(nrow(K.GTIN.up.pb)), "have a different Artikelnummer ---> Not so bad", silver("K.GTIN.up.pb\n"))
  cat("\t\t", if0(nrow(K.GTIN.up.pb.V)), "have a different VaterID or no VaterID ---> DANGEROUS to update do not know what happend \n")
  cat("\t\t\t", yellow(nrow(lo.K)), "without VaterID in import - lonely Kinder ---> check if it is ok", silver("lo.K\n"))
  cat("\t\t\t", yellow(nrow(lo.K.db)), "are lonely Kinder in db (no VaterID) ---> delete them in db (not big risk, just lager BUT PICTURES !!!)", silver("lo.K.db or lo.K.db.delete\n"))
  cat("\t\t\t\t", nrow(lo.K.db.import), "are in lager", silver("dbK.lager[GTIN %in% lo.K.db$GTIN]\n"))
  
  
  cat("\t\t\t", if0(nrow(K.GTIN.up.pb.V2)), "have different VaterID ---> DANGEROUS, will not be added to todelete !!!", silver("K.GTIN.up.pb.V2\n"))
  cat("\t\t\t\t>", if0(length(u(K.GTIN.up.pb.V2$VID.db))), "Vater >", if0(nrow(dbK[VID %in% K.GTIN.up.pb.V2$VID.db])), "Kinder >", if0(nrow(lost.K)),"will be lost (not in import) >", if0(nrow(lost.K.lager), " DO NOT DELETE"),"in lager", silver("lost.K.lager - \n"))
  cat("\t\t\t\t>", if0(length(u(K.GTIN.up.pb.V2$VID.db))), "Vater >", if0(nrow(dbK[VID %in% K.GTIN.up.pb.V2$VID.db])), "Kinder >", if0(nrow(K.GTIN.up.pb.V2.V.import)),"in lager", silver("dbK.lager[VID %in% K.GTIN.up.pb.V2$VID.db] - K.GTIN.up.pb.V2.V.import\n"))
  cat("\t\t\t\t--------------------Different Options:------------------------------\n")
  
  if( nrow(lost.K.lager) > 0 ) {
    cat("\t\t\t\t|  - Did you use old Vater before in the code with", cyan("update.VaterID.from.db\n"))
    cat("\t\t\t\t|  - Article are in Lager that could be lost if you delete so ignore, import data, delete the empty Vaters", bgBlue("AFTER"), "\n")
  }
  
  # if( nrow(lost.K.lager) == 0 ) {
    
    if( any(c(nrow(double.V.db), nrow(double.V.im), nrow(double.V.db2)) > 0) ) {
      
      cat("\t\t\t\t|  -", red("You have several DOUBLE VATERS"), " either in db (VID:", if0(nrow(double.V.db)), ", or Artikelname:", if0(nrow(double.V.db2)), ") or in im ", if0(nrow(double.V.im)), "), import first, then delete the empty ones with:\n")
      
      if( nrow(double.V.db2) > 0) {
        cat("\t\t\t\t|\t -", silver("double.V.db2"), "is", if0(nrow(double.V.db2)), bgYellow("Not sure what to do here"), ", GTIN from them are not in im but they are link to a Vater with same name, but different serie. Seems you can ignore ...\n")
        
      }
      
      
      cat("\t\t\t\t|\t - Modify the Vaters with most article with", cyan("Ameise.import.renummer.Vater.Serie(DB = which.db, DATA = K.GTIN.up.pb.V2.modify.Vater2)"), "\n")
      cat("\t\t\t\t|\t - Delete the empty ones", bgBlue("AFTER"), "the import with", "JTL-Wawi and a filter\n")
      # cat("\t\t\t\t|\t - Delete the empty ones", bgBlue("AFTER"), "the import with", silver("notlost.V.delete\n"))
      # cat("\t\t\t\t|\t -", cyan("Ameise.import.todelete(DB = which.db, DATA = notlost.V.delete)\n"))
    }
    
    
    
    if( all(c(nrow(double.V.db), nrow(double.V.im), nrow(double.V.db2)) == 0) ) {
      cat("\t\t\t\t - You have NO double Vaters, you can renummer the Vater to avoid to loose the pictures\n")
      cat("\t\t\t\t|\t", cyan("Ameise.import.renummer.Vater.Serie(DB = 'test', data = K.GTIN.up.pb.V2.modify.Vater2)\n"))
    }
  # }
  
  cat("\t\t\t\t-----------------------------------------------------\n\n")
  
  # update what will be deleted
  dbK2 <- dbK[!GTIN %in% lo.K.db$GTIN][!VID %in% K.GTIN.up.pb.V2.V.delete$Artikelnummer]
  dbV2 <- dbV[!Artikelnummer.db %in% K.GTIN.up.pb.V2.V.delete$Artikelnummer] # remove the removed Vaters
  
  num.konflikt.ArtN <- K[Artikelnummer %in% u(dbK2$VID)]
  num.konflikt.ArtN.lo <- num.konflikt.ArtN[is.na(VID)]
  num.konflikt.ArtN.nolo <- num.konflikt.ArtN[!is.na(VID)]
  num.konflikt.ArtN.lo.realV <- dbK2[VID %in% num.konflikt.ArtN.lo$Artikelnummer][,.N, VID][N > 1]
  KeepVater <- num.konflikt.ArtN.lo.realV$VID
  num.konflikt.ArtN.lo.norealV <- dbK2[VID %in% num.konflikt.ArtN.lo$Artikelnummer][,.N, VID][N == 1]
  
  # dbK2[VID %in% num.konflikt.ArtN.lo.norealV$VID]
  
  temp <- dbK2[GTIN %in% K$GTIN]$GTIN
  num.konflikt.GTIN <- K[c(Artikelnummer %in% u(dbK2$VID) & !GTIN %in% temp)]
  num.konflikt <- rbind(num.konflikt.ArtN, num.konflikt.GTIN)
  num.konflikt.V <- dbV[Artikelnummer.db %in% num.konflikt$Artikelnummer]
  num.konflikt.V.delete <- num.konflikt.V[, .(Artikelname, Artikelnummer = Artikelnummer.db)]
  num.konflikt.V.delete[, Artikelname := p0(Artikelname, "-todelete")]
  num.konflikt.K <- dbK[VID %in% num.konflikt$Artikelnummer | Artikelnummer.db %in% num.konflikt$Artikelnummer]
  num.konflikt.Kmi <- num.konflikt.K[!GTIN %in% K$GTIN]
  num.konflikt.Kla <- dbK.lager[VID %in% num.konflikt$Artikelnummer]
  num.konflikt.Kla.import <- num.konflikt.Kla[, .(GTIN, Lagerbestand = Lager)]
  
  cat("\n\t\t", if0(nrow(num.konflikt.ArtN)), "Kinder in import have same nummer as Vater in db")
  cat("\n\t\t\t", if0(nrow(num.konflikt.ArtN.lo)), "are lonely kinder in Import")
  cat("\n\t\t\t\t", if0(nrow(num.konflikt.ArtN.lo.realV)), "are actually wrong lonely Kinder because Artikelnummer of a Vater with several Kinder in db")
  cat("\n\t\t\t\t\t---> use", cyan("dput(KeepVater)\tdata[VID %in% dput(KeepVater), Keep.VaterID := T]"))
  
  cat("\n\t\t\t\t", if0(nrow(num.konflikt.ArtN.lo.norealV)), "have same number of a Vater in with only 1 Kind in db")
  cat("\n\t\t\t\t\t", if0(nrow(num.konflikt.ArtN.lo.norealV)), "have same number of a Vater in with only 1 Kind in db")
  cat("\n\t\t\t", if0(nrow(num.konflikt.ArtN.nolo)), "are not lonely kinder in Import")
  cat(cyan("\n\t\t\t\tdata[GTIN %in% dput(num.konflikt.ArtN$GTIN), .(KeepVater := T, and change the artikelnummer in a way]"))
  cat(silver("\n\t\t\t\tnum.konflikt.ArtN\te.g dput(num.konflikt.ArtN$Artikelnummer)\n"))
  cat("\t\t\t>", if0(nrow(num.konflikt.V)), "Vaters >", 
      if0(nrow(num.konflikt.K)), "Kinders >",
      if0(nrow(num.konflikt.Kmi)), "not in import /", if0(nrow(num.konflikt.Kla)), "in lager\n")
  cat("\t\t\t", silver("num.konflikt.V")," > ", silver("num.konflikt.K"), " > ", silver("num.konflikt.Kmi"), " > ", silver("num.konflikt.Kla\n"))
  
  
  assign("num.konflikt", num.konflikt, env = .GlobalEnv)
  assign("num.konflikt.GTIN", num.konflikt.GTIN, env = .GlobalEnv)
  assign("num.konflikt.ArtN", num.konflikt.ArtN, env = .GlobalEnv)
  assign("KeepVater", KeepVater, env = .GlobalEnv)
  assign("num.konflikt.V", num.konflikt.V, env = .GlobalEnv)
  assign("num.konflikt.V.delete", num.konflikt.V.delete, env = .GlobalEnv)
  assign("num.konflikt.K", num.konflikt.K, env = .GlobalEnv)
  assign("num.konflikt.Kmi", num.konflikt.Kmi, env = .GlobalEnv)
  assign("num.konflikt.Kla", num.konflikt.Kla, env = .GlobalEnv)
  assign("num.konflikt.Kla.import", num.konflikt.Kla.import, env = .GlobalEnv)
  
  
  # todelete <- rbind(lo.K.db.delete, K.GTIN.up.pb.V2.V.delete, num.konflikt.V.delete)
  todelete <- rbind(lo.K.db.delete, num.konflikt.V.delete)
  # toimport <- rbind(lo.K.db.import, K.GTIN.up.pb.V2.V.import, num.konflikt.Kla.import)
  toimport <- rbind(lo.K.db.import, num.konflikt.Kla.import)
  
  assign("todelete", todelete, env = .GlobalEnv)
  assign("toimport", toimport, env = .GlobalEnv)
  
  
  
  assign("K.GTIN.no", K.GTIN.no, env = .GlobalEnv)
  assign("K.GTIN.no.pb.AN", K.GTIN.no.pb.AN, env = .GlobalEnv)
  assign("K.GTIN.yes", K.GTIN.yes, env = .GlobalEnv)
  assign("K.GTIN.up.pb", K.GTIN.up.pb, env = .GlobalEnv)
  assign("K.GTIN.up.pb.V", K.GTIN.up.pb.V, env = .GlobalEnv)
  assign("K.GTIN.up.pb.V2", K.GTIN.up.pb.V2, env = .GlobalEnv)
  assign("K.GTIN.up.pb.V2.modify.Vater", K.GTIN.up.pb.V2.modify.Vater, env = .GlobalEnv)
  assign("K.GTIN.up.pb.V2.modify.Vater2", K.GTIN.up.pb.V2.modify.Vater2, env = .GlobalEnv)
  assign("K.GTIN.up.pb.V2.V.delete", K.GTIN.up.pb.V2.V.delete, env = .GlobalEnv)
  assign("K.GTIN.up.pb.V2.V.import", K.GTIN.up.pb.V2.V.import, env = .GlobalEnv)
  assign("notlost.V.delete", notlost.V.delete, env = .GlobalEnv)
  assign("double.V.db2", double.V.db2, env = .GlobalEnv)
  assign("V2keep", V2keep, env = .GlobalEnv)
  assign("lost.K", lost.K, env = .GlobalEnv)
  assign("lost.K.lager", lost.K.lager, env = .GlobalEnv)
  assign("lo.K", lo.K, env = .GlobalEnv)
  assign("lo.K.db", lo.K.db, env = .GlobalEnv)
  assign("lo.K.db.delete", lo.K.db.delete, env = .GlobalEnv)
  assign("lo.K.db.import", lo.K.db.import, env = .GlobalEnv)
  
  
  cat("\n\n", yellow("[INFO]"), " - Analysis on VATER\n")
  cat("-----------------------------------------------------------------------\n")
  cat("\n")
  
  
  V.no <- V[!Artikelnummer %in% dbV2$Artikelnummer.db] # Vater in import NOT in db
  temp <- dbK2[GTIN %in% K[VID %in% V.no$Artikelnummer]$GTIN]
  V.no.K <- K[VID %in% V.no$Artikelnummer][GTIN %in% temp] # wrong link VaterID 
  
  V.no.K.lo.db <- dbK2[GTIN %in% V.no.K$GTIN][VID == ""] # wrong link VaterID lonely in db
  V.no.K.nolo.db <- dbK2[GTIN %in% V.no.K$GTIN][VID != ""] # wrong link VaterID NOT lonely in db
  
  # dbK2[Artikelnummer.db %in% K$Artikelnummer]
  
  
  cat("\t", yellow(nrow(V.no)), "\tVater in import NOT in db ---> import them first if you do update on GTIN ", silver("V.no\n"))
  cat("\t\t", if0(nrow(V.no.K)), " Kinder with GTIN in db - wrong link VaterID", silver("V.no.K\n"))
  cat("\t\t\t", yellow(nrow(V.no.K.lo.db)), "lonely Kinder in db,", yellow(nrow(V.no.K.lo.db[GTIN %in% lo.K.db.delete$GTIN])), "could be deleted with ", silver("lo.K.db.delete\n"))
  cat("\t\t\t", if0(nrow(V.no.K.nolo.db)), "not lonely Kinder in db ---> Must update VaterID in import or delete VaterID in db", silver("V.no.K.nolo.db \n"))
  
  cat("\t\t\t\t> from", yellow(length(u(V.no.K.nolo.db$VID))), "Vaters >", yellow(nrow(dbK2[VID %in% V.no.K.nolo.db$VID])),"Kinders >", yellow(nrow(dbK.lager[VID %in% V.no.K.nolo.db$VID])), "in lager\n")
  cat(silver("\t\t\t\t\tdbK.lager[VID %in% V.no.K.nolo.db$VID]\n"))
  # cat("\t\t\t\t\tExport it and add -todelete to the name to be able to delete the article\n")
  # cat("\t\t\t\t\t\twrite.csv.wawi(K.GTIN.up.pb.V2.V.delete, datapath = p0(rootpath, '/Firmen_Listen_EAN/Import/yourname.csv'))\n")
  # cat("\t\t\t\t\t\twrite.csv.wawi(lo.K.db.import, datapath = p0(rootpath, '/Firmen_Listen_EAN/Import/yourname_LAGER.csv'))\n")
  assign("V.no", V.no, env = .GlobalEnv)
  assign("V.no.K", V.no.K, env = .GlobalEnv)
  assign("V.no.K.lo.db", V.no.K.lo.db, env = .GlobalEnv)
  assign("V.no.K.nolo.db", V.no.K.nolo.db, env = .GlobalEnv)
  
  
  
  
  cat("\n\n", yellow("[INFO]"), " - Analysis on PRICES\n")
  cat("-----------------------------------------------------------------------\n")
  cat("\n")
  
  PP <- dtjoin(K.GTIN.yes[, .(Artikelname, VK, EK, GTIN)], dbK[, .(Artikelname.db = Artikelname, VK.db = VK, EK.db = EK, GTIN)])
  PPu <- PP[VK != VK.db]
  PPe <- PP[EK != EK.db]
  
  cat("\t", yellow(nrow(PPu)), "\twith different VK", silver("PPu\n"))
  cat("\t", yellow(nrow(PPe)), "\twith different EK", silver("PPe\n"))
  
  assign("PPe", PPe, env = .GlobalEnv)
  assign("PPu", PPu, env = .GlobalEnv)
  
  plot.evo <- ggplot(melt.data.table(PPu, id.vars = "GTIN", measure.vars = c("VK", "VK.db")), aes(variable, value)) + geom_line(aes(group=GTIN))+xlab("Old and new prices")+ylab("Euro")+labs(title="Evolution prices")+orderX(c("VK.db", "VK"))
  print(plot.evo)
  
}

remove.single.article <- function(.dataV, .dataK, DATA) {
  
  namedatav <- deparse(substitute(.dataV)) # https://stackoverflow.com/questions/47904321/deparsesubstitute-returns-function-name-normally-but-function-code-when-cal
  namedatak <- deparse(substitute(.dataK)) # https://stackoverflow.com/questions/47904321/deparsesubstitute-returns-function-name-normally-but-function-code-when-cal
  
  
  # check if UPC created but not in dataK
  if( "UPC" %in% names(DATA) ) {
    debug.easy(!"UPC" %in% names(.dataK), "You forgot to activate and take UPC, some were created from GTIN column !!!")
  }
  
  
  # VID == Artikelnummer
  debug.easy(nrow( DATA[VID %in% .dataV[N != 1]$Artikelnummer & VID == Artikelnummer] ) > 0 , p0("You have VID == Artikelnummer ", silver("data[VID %in% dataV[N != 1]$Artikelnummer & VID == Artikelnummer]")))
  
  
  
  
  
  cat("", yellow("[INFO]"), " - prepare to remove Vater with only 1 Kinder from dataV and if Keep.VaterID is F\n")
  cat("--------------------------------------------------------------------\n")
  temp <- .dataV[N == 1]
  torework <- temp[Artikelnummer %in% DATA[Keep.VaterID == F]$VID]
  Vtokeep <- temp[Artikelnummer %in% DATA[Keep.VaterID == T]$VID]
  cat(nrow(torework), "rows will be removed and\n", nrow(Vtokeep), "will not be changed because already exist in db with variations\t\t\t\t\t\tRobject: torework - Vtokeep\n")
  assign("torework", torework, env = .GlobalEnv)
  assign("Vtokeep", Vtokeep, env = .GlobalEnv)
  
  cat(namedatak, "Artikelnummer will get VID\n\n")
  # dataK[VID %in% torework$Artikelnummer, Artikelnummer := VID]
  .dataK[VID %in% torework$Artikelnummer, VID := NA]
  .dataV <- .dataV[N != 1 | Artikelnummer %in% DATA[Keep.VaterID == T]$VID] # remove waren with no Variation to get it from the dataK
  assign(namedatav, .dataV, env = .GlobalEnv)
  
}

clean.kategorie.tree <- function(data, cols) {
  
  # will check that no Kategorie has defined sub-kategorie and 1 empty, otherwise it is the mess to find product in wawi
  # will update directly your data
  if( length(cols) > 1 ) {
    for( i in 2:length(cols) ) {
      col2ch <- data[, .N, c(cols[1:i])][, .N, c(cols[1:(i-1)])][N > 1]
      # data[1:nrow(data) %in% data[col2ch, on = cols[1:(i-1)], which = T] & get(cols[i]) == ""] # did not finish and never used it
      data[data[, .I %in% data[col2ch, on = cols[1:(i-1)], which = T]] & get(cols[i]) == "", cols[i] := "None"]
    }
  }
  cat("\nPlease check :)\n\n")
  t <- data[, .N, cols]
  setorderv(t, cols = names(t))
  setkeyv(t, cols = cols)
  print(t)
  
}

check.DB.prices <- function(get.new.prices.only.in.lager = F, rootpath2 = rootpath, limit.price = 0.25) {
  
  debug.easy(!exists("K"), "You need to run the function check.DB.ameise.v03 first !!!!")
  
  temp <- dtjoin(K[, .(GTIN, VK.new = VK, EK.new = EK, Artikelname, Hersteller)],     dbK[, .(GTIN, VK.old = VK, EK.old = EK, Lager, VID)])
  temp[, LagerVID := Lager]
  temp[VID != "", LagerVID := sum(Lager), VID]
  temp[Lager != 0 & VID == ""] # check
  
  if( get.new.prices.only.in.lager ) {
    # new.prices <- temp[VK.new != VK.old & Lager != 0][, .(GTIN, Artikelname, VK.old, VK.new, EK.old, EK.new, Lager)] # wrong you need to take in account the VaterID for lager
    cat(bgRed("TAKE CARE - you are using"), bgYellow("only in Lager !!!!"), bgRed("ok with this ????\n"))
    cat(bgRed("TAKE CARE - you are using"), bgYellow("only in Lager !!!!"), bgRed("ok with this ????\n"))
    cat(bgRed("TAKE CARE - you are using"), bgYellow("only in Lager !!!!"), bgRed("ok with this ????\n"))
    cat(bgRed("TAKE CARE - you are using"), bgYellow("only in Lager !!!!"), bgRed("ok with this ????\n"))
    new.prices <- temp[VK.new != VK.old & LagerVID != 0][, .(GTIN, Artikelname, VK.old, VK.new, EK.old, EK.new, Lager, LagerVID, Hersteller)]
  } else {
    new.prices <- temp[VK.new != VK.old][, .(GTIN, Artikelname, VK.old, VK.new, EK.old, EK.new, Lager, LagerVID, Hersteller)]
  }
  
  
  # Goal: avoid to update prices with less than 0.5euro differences
  new.prices[, Almost.same := F]
  # new.prices[,.N, abs(VK.new - VK.old)]
  new.prices[abs(VK.new - VK.old) <= limit.price, Almost.same := T]
  # new.prices[, .N, Almost.same]
  
  
  cat("\n", yellow("[INFO]"), " - ", nrow(new.prices[Almost.same == F]), "Articles have different prices", silver("new.prices\n"))
  cat("\n", yellow("[INFO]"), " - ", nrow(new.prices[Almost.same == T]), "Articles have different almost similar prices (will NOT be in new.prices): below limit.price",limit.price,  "\n\n")
  # cat("If you want to write it: write.csv.wawi(new.prices, p0('file:///L:/Inventur/2021/Neu_preisen/2022_Neu-Preisen_', Firma, '.csv'))")
  assign("new.prices", new.prices, env = .GlobalEnv)
  
  
  tryCatch({
    write.csv.wawi(new.prices, p0(rootpath2, 'Firmen_Listen_EAN/Listen/Formatted/Prices/Log_changes/', Firma, '_', Serie, '_new.prices.csv'))
  }, error=function(e) {
    write.csv.wawi(new.prices, p0(rootpath2, 'Firmen_Listen_EAN/Listen/Formatted/Prices/Log_changes/', Firma, '_', Serie, '_new.prices.csv'))
  })
  
}

remove.new.prices <- function(DATA, new.prices, new.name.K, DB) {
  
  debug.easy(!"LagerVID" %in% names(new.prices), "You miss the column LagerVID")
  if( nrow(new.prices) != 0 ) {
    if( nrow(new.prices[Lager == 0]) == 0) {
      WaitYorN("You have no Artikle with Lager 0, are you sure you used LagerVID instead of Lager ?")
    }
  }
  
  # prices.to.update <- data[`EAN/Barcode` %in% new.prices$EAN]
  prices.to.update <- DATA[GTIN %in% new.prices[Almost.same == F]$GTIN]
  if( nrow(prices.to.update) != 0 & DB == "offi" ){
    if( !u(DATA$`Eigene ID`)[1] %like% "23" ) {
      create.dir(dirname(gsub("Formatted/", "Formatted/Prices/",  new.name.K)), u(DATA$`Eigene ID`)[1], "wdprice")
      write.csv.wawi(prices.to.update, p0(wdprice,  basename(new.name.K)))
    } else {
      write.csv.wawi(prices.to.update, gsub("Formatted/", "Formatted/Prices/", new.name.K))
    }
    old.prices <- DATA[GTIN %in% new.prices$GTIN]
    write.csv.wawi(old.prices, gsub("Formatted/", "Formatted/Prices/Log_changes/", gsub(".csv$", p0("__old-prices-all__", gettimestamp(), ".csv"), new.name.K)))
  }
  
  
  temp <- copy(new.prices)
  # setnames(temp, "EAN", "EAN/Barcode")
  
  # data <- data[!`EAN/Barcode` %in% new.prices$EAN] # before
  update.DT(DATA1 = DATA, 
            DATA2 = temp,
            join.variable = "GTIN",
            overwrite.variable = "UVP",
            overwrite.with.variable = "VK.old")
  update.DT(DATA1 = DATA, 
            DATA2 = temp,
            join.variable = "GTIN",
            overwrite.variable = "Brutto-VK",
            overwrite.with.variable = "VK.old")
  update.DT(DATA1 = DATA, 
            DATA2 = temp,
            join.variable = "GTIN",
            overwrite.variable = "Durchschnittlicher Einkaufspreis (netto)",
            overwrite.with.variable = "EK.old")
  
  
  
  assign("dataall", DATA, env = .GlobalEnv)
  
  # # bind all
  # dpath <- p0(dirname(new.name.K), "/Prices/")
  # # dpath <- "C:/Users/', computer.name, '/Dropbox/Shared_Dorian/Firmen_Listen_EAN/Listen/Formatted/Prices/"
  # lf <- list.files(dpath, pattern = "Prices__*", full.names = T)
  # all <- c()
  # for(i in seq_along(lf)) {
  #   if( i == 1 ) {
  #     temp <- readLines(lf[i])
  #   } else {
  #     temp <- readLines(lf[i])[-1]
  #   }
  #   all <- c(all, temp)
  # }
  # write.table(all, p0(dpath, "All_prices.csv"), row.names = F, col.names = F, quote = F)
  
  
  
  
}

check.table.for.wawi <- function(data){
  
  debug.easy(!all(c("Artikelnummer", "Artikelname", "Variationswert.1", "Variationswert.2") %in% names(data)), "You miss some columns, usually use dataallBU, you need : Artikelnummer, Artikelname, Variationswert.1, Variationswert.2")
  temp <- data[order(Artikelname), .(Artikelnummer, Artikelname, Variationswert.1, Variationswert.2, VID)]
  temp[is.na(Variationswert.1), Variationswert.1 := ""]
  temp[is.na(Variationswert.2), Variationswert.2 := ""]
  temp
  temp[, new := ""]
  temp
  
  temp[!is.na(VID), 2:ncol(temp) := temp[!is.na(VID), 1:(ncol(temp)-1)]]
  temp[Artikelnummer == Artikelname, Artikelnummer := ""]
  
  assign("wawi.check", temp, env =  .GlobalEnv)
  cat("\n", yellow("[INFO]"), " - Robject 'wawi.check' and 'Vaterdupli' assigned. Use 'View(wawi.check)' to check the table.\n")
  
}

format.GTIN <- function(DATA, colname.GTIN, colname.UPC = "", rm = F, du.rm = F, du.ign = F) {
  
  nameDATA <- deparse(substitute(DATA)) # https://stackoverflow.com/questions/47904321/deparsesubstitute-returns-function-name-normally-but-function-code-when-cal
  
  setnames(DATA, colname.GTIN, "GTIN")

  DATA[, GTIN := gsub(" ", "", as.character(format(as.numeric(GTIN), scientific = F)))]
  print(kable(DATA[, .N, nchar(GTIN)]))
  DATA[nchar(GTIN) == 10, GTIN := p0("00", GTIN)]
  DATA[nchar(GTIN) == 11, GTIN := p0("0", GTIN)]
  
  
  if( colname.UPC != "" ) {
    setnames(DATA, colname.UPC, "UPC")
    DATA[is.na(UPC), UPC := ""]
    DATA[nchar(GTIN) == 12 & UPC == "", UPC := GTIN]
  } else {
    DATA[nchar(GTIN) == 12, UPC := GTIN]
  }
  DATA[nchar(GTIN) == 12, GTIN := p0("0", GTIN)]
  DATA[nchar(GTIN) != 13]
  print(kable(DATA[, .N, nchar(GTIN)]))
  
  if( rm ) {
    cat("\n", yellow("[INFO]"), " - Removed ", nrow(DATA[nchar(GTIN) != 13]), " rows with nchar(GTIN) != 13, by assigning to 'data'\n")
    DATA <- DATA[nchar(GTIN) == 13]
    assign(nameDATA, DATA, envir = .GlobalEnv)
  } else {
    cat("\n", yellow("[INFO]"), " - DID NOT Removed ", nrow(DATA[nchar(GTIN) != 13]), " rows with nchar(GTIN) != 13\n")
  }
  
  # browser()
  du <- DATA[, .N, GTIN][N > 1]
  if( du.rm ) {
    cat("", yellow("[INFO]"), " - du.rm=T - remove", length(DATA[, .N, GTIN][N > 1]$GTIN), "duplicate GTIN !!!")
    DATA <- DATA[!GTIN %in% du$GTIN]
    assign(nameDATA, DATA,  env = .GlobalEnv)
  } else {
    if( du.ign ) {
      cat(red("[INFO] - You have duplicates but YOU decide to ignore them with `du.ign`)\n"))
    } else {
      mess <- p0("You have duplicates in your EAN: \t", nameDATA, "[GTIN %in% ", nameDATA, "[, .N, GTIN][N > 1]$GTIN], if you wannw remove them use du.rm = T")
      debug.easy(nrow(du) > 0, mess)
    }
  }
  
  DATA[, Keep.VaterID := F]
  
}

get.variation <- function(DATA = data, size.name, colour.name) {
  
  
  if( hasArg(colour.name)) {
    setnames(DATA, colour.name, "Colour")
    u(DATA$Colour)
    cat("\n")
    DATA[,.N, Colour][order(-N)]
    DATA[, Colour := gsub(' *$|^ *', "", Colour)]
    DATA[, Colour := gsub('  *', " ", Colour)]
    DATA[, Colour := gsub(' - ', "-", Colour)]
    DATA[, Colour := str_to_title(Colour)]
    print(DATA[,.N, Colour][order(-N)][1:20])
    cat("\n")
    print(u(DATA$Colour))
    cat("\n--------------------------------------------------------------------------------------------------------------------------\n")
  }
  
  
  if( hasArg(size.name)) {
    setnames(DATA, size.name, "Size")
    cat("\n")
    
    u(DATA$Size)
    cat("\n")
    DATA[, Size := gsub(' *$|^ *', "", Size)]
    DATA[, Size := gsub('  *', " ", Size)]
    DATA[, Size := gsub('½', ".5", Size)]
    DATA[, Size := gsub(' - ', "-", Size)]
    print(DATA[,.N, Size][order(-N)][1:20])
    cat("\n")
    print(u(DATA$Size))
    cat("\n\n")
  }
  
}

get.price <- function(DATA = data, EK.name, VK.name, rm.na = F) {
  
  ori.name <- deparse(substitute(DATA))
  
  setnames(DATA, c(EK.name, VK.name), c("EK", "VK"))
  DATA[, VK.old := VK]
  DATA[, EK.old := EK]

  cols <- c("VK", "EK")
  
  
  
  DATA[, (cols) := lapply(.SD, function(x) gsub(" |-|#N/A|€|#NV", "", x)), .SDcols = cols]
  
  
  if( sum(str_count(DATA$VK, ",") + str_count(DATA$EK, ","), na.rm = T) > 0 ){
    
    pos.vir <- min(
      str_locate(stri_reverse(DATA[ which(str_count(DATA$VK, ",") > 0)]$VK), ",")[,1],
      str_locate( stri_reverse(DATA[ which(str_count(DATA$EK, ",") > 0)]$EK), ",")[,1], na.rm = T)
    pos.point <- min(
      str_locate( stri_reverse(DATA[ which(str_count(DATA$VK, ",") > 0)]$VK), "\\.")[,1], 
     str_locate( stri_reverse(DATA[ which(str_count(DATA$EK, ",") > 0)]$EK), "\\.")[,1], na.rm = T) 
    
    
    if( !is.infinite(pos.point) ) {
      if( pos.vir > pos.point ) {
        DATA[, (cols) := lapply(.SD, function(x) gsub(",", "", x)), .SDcols = cols]
      } else {
        DATA[, (cols) := lapply(.SD, function(x) gsub("\\.", "", x)), .SDcols = cols]
      }
    }
  }
  DATA[, (cols) := lapply(.SD, function(x) gsub(",", ".", x)), .SDcols = cols]
      
  DATA[, VK := as.numeric(VK)]
  DATA[, EK := as.numeric(EK)]
  
  print(colorDF(DATA[,.N, .(VK, VK.old, EK, EK.old, factor = VK/EK)][order(-VK)]))
  cat("\n")
  
  
  
  DATA[is.na(EK), EK := 0]
  
  if( rm.na ) {
    
    cat("\n\n", red("TAKE CARE you have rm.na = T ------------- !!!!!!!!!!!!!!!!!!!!!!!"),"\n\n")
    
    if( nrow(DATA[is.na(VK)]) > 0 ) { 
      cat(yellow("[INFO]"), " - You have",
          bgRed(nrow(DATA[is.na(VK) | is.na(EK)])),
          "rows with VK are NA --->",
          bgRed("Removed"), "\n\n") 
      print(DATA[is.na(VK), .N, .(VK, VK.old, EK, EK.old)])
    }
    
    DATA <- DATA[!is.na(VK)][!is.na(EK)]
    
    if( nrow(DATA[VK == 0]) > 0 ) { 
      cat("\n\n", yellow("[INFO]"),
          " - You have", bgRed(nrow(DATA[VK == 0])), 
          "rows with VK == 0 --->",
          bgRed("Removed"), "\n\n")
    }
    
    DATA <- DATA[VK != 0]
    
  } else {
    if( nrow(DATA[is.na(VK)]) > 0 ) {
      if( nrow(DATA[is.na(VK), .N, .(VK, VK.old, EK, EK.old)]) > 0 ) {
        print(colorDF(DATA[is.na(VK), .N, .(VK, VK.old, EK, EK.old)]))
      }
      cat(bgRed("\nYou have", nrow(DATA[is.na(VK)]), "NA value ... data[is.na(VK)]\n\n"))
      # stop()
    }
  }
  
  
  
  DATA[, c("VK.old", "EK.old") := NULL]
  
  
  assign(ori.name, DATA, envir = .GlobalEnv)

  
}

clean.prices <- function(DATA, EK.name = "EK", VK.name = "VK") {
  
  library(plyr)
  
  DATA[, VK.bu := VK]
  DATA[, VK := round_any(VK.bu, 1, f = ceiling)]
  DATA[, VK.r100 := round_any(VK, 100, f = round)]
  DATA[, VK.r10 := round_any(VK, 10, f = round)]
  DATA[, VK.r100.d := VK.r100-VK]
  DATA[, VK.r10.d := VK.r10-VK]
  DATA[abs(VK.r100.d) < 2 & abs(VK.r100) > 0, .(VK.bu, VK, VK.r100, VK.r100.d, VK.r10, VK.r10.d)]
  DATA[abs(VK.r100.d) < 2 & abs(VK.r100) > 0, VK := VK.r100]
  DATA[abs(VK.r10.d) < 2 & abs(VK.r10) > 20, .(VK.bu, VK, VK.r100, VK.r100.d, VK.r10, VK.r10.d, GTIN)]
  DATA[abs(VK.r10.d) < 2 & abs(VK.r10) > 20, VK := VK.r10]
  DATA[, VK := VK - 0.05]
  DATA[, .N, .(VK, VK.bu)]
  DATA[, diff := VK-VK.bu]
  # range(DATA$diff, na.rm = T)
  # DATA[abs(diff) > 2, .(VK, VK.bu)]
  hist(DATA$diff, breaks = seq(-2, 2, 0.05))
  DATA[, c("VK.r100.d", "VK.r10.d", "diff", "VK.r100", "VK.r10") := NULL]

}

get.categories <- function(DATA = data, block.list.col) {
  # if multiples cat ---
    cols <- strsplit(block.list.col, " ")[[1]]
    DATA[, .N, cols]
    setnames(DATA, cols, p0("K", 1:length(cols)))
    cols <- p0("K", 1:length(cols))
    
  # apply to all columns and replace in all columns ---
    DATA[, (cols) := lapply(.SD, str_to_title), .SDcols = cols]
    DATA[, (cols) := lapply(.SD, gsub, pattern = "®", replacement = "", fixed = T), .SDcols = cols]
    DATA[, (cols) := lapply(.SD, gsub, pattern = "^ *| *$", replacement = ""), .SDcols = cols]
    
    clean.kategorie.tree(DATA, cols)
}

create.Vater.Kinder <- function(DATA) {
  
  
  dataK <- DATA[, .(VID,
                    # "Artikelnummer (Lieferant)" = article..,
                    Artikelnummer,
                    Artikelname,
                    ArtikelnameV,
                    GTIN = GTIN,
                    UPC = UPC,
                    Hersteller = Firma,
                    Kategorie.Ebene.1 = "IMPORT",
                    Kategorie.Ebene.2 = Firma,
                    Kategorie.Ebene.3 = ifelse("K1" %in% names(DATA), K1, ""),
                    Kategorie.Ebene.4 = ifelse("K2" %in% names(DATA), K2, ""),
                    Kategorie.Ebene.5 = ifelse("K3" %in% names(DATA), K3, ""),
                    Kategorie.Ebene.6 = ifelse("K4" %in% names(DATA), K4, ""),
                    UVP = VK,
                    VK = VK,
                    EK = EK,
                    Variationsname.1 = "Farbe",
                    Variationswert.1 = Colour,
                    # Variation.SortNr.1 = Col.No.,
                    Variationsname.2 = "Größe",
                    Variationswert.2 =  Size, 
                    # Variation.SortNr.2 = Size.code,
                    # Variationsname.3 = "Geschlecht",
                    # Variationswert.3 = Geschlecht,
                    # Variation.SortNr.3 = Geschlecht2,
                    # Artikelgewicht = Gesamtgewicht*1000,
                    # Breite = Width,
                    # Höhe = Height,
                    # Länge = Depth,
                    # Erscheint.am = available.Germany,
                    # Bild.1.Pfad__URL = Main.Image.grey,
                    # Bild.2.Pfad__URL = ID2,
                    # Bild.3.Pfad__URL = ID3,
                    # Kurzbeschreibung = Description.DE,
                    # Beschreibung = BESCHREIBUNG.LANG,
                    # TARIC_Code = substr(Customs.Code, 1, 8),
                    # Herkunftsland = toupper(substr(Italy, 1, 2)),
                    Serie = Serie,
                    Verkaufseinheit = "Stück",
                    Keep.VaterID
  ),]
  
  
  
  dataV <- dataK[, .(Artikelnummer = VID,
                     Artikelname = ArtikelnameV,
                     Hersteller,
                     # Herkunftsland,
                     # TARIC_Code,
                     Serie,
                     Verkaufseinheit,
                     Kategorie.Ebene.1 = ifelse("Kategorie.Ebene.1" %in% names(dataK), Kategorie.Ebene.1, ""),
                     Kategorie.Ebene.2 = ifelse("Kategorie.Ebene.2" %in% names(dataK), Kategorie.Ebene.2, ""),
                     Kategorie.Ebene.3 = ifelse("Kategorie.Ebene.3" %in% names(dataK), .SD[1, Kategorie.Ebene.3], ""),
                     Kategorie.Ebene.4 = ifelse("Kategorie.Ebene.4" %in% names(dataK), .SD[1, Kategorie.Ebene.4], ""),
                     Kategorie.Ebene.5 = ifelse("Kategorie.Ebene.5" %in% names(dataK), .SD[1, Kategorie.Ebene.5], ""),
                     Kategorie.Ebene.6 = ifelse("Kategorie.Ebene.6" %in% names(dataK), .SD[1, Kategorie.Ebene.6], ""),
                     # Bild.1.Pfad__URL = .SD[1,Bild.1.Pfad__URL],
                     # Bild.2.Pfad__URL = .SD[2,Bild.1.Pfad__URL],
                     # Bild.3.Pfad__URL = .SD[3,Bild.1.Pfad__URL],
                     N = .N
  ), .(VID)]
  dataV
  dataV[, VID := NULL]
  dataV
  
  dataV <- unique(dataV)
  
  
  # assign(name.return, data, envir = parent.frame(1))
  assign("dataK", dataK, envir = .GlobalEnv)
  assign("dataV", dataV, envir = .GlobalEnv)
  
  
}

last.export <- function(x = 1) {
  rev(list.files("C:/Users/dorian.BSPM/Desktop/Export_ALL_for-price-update/", full = T, pattern = "\\.csv"))[x]
}





# database ----------------------------------------------------------------

read.DB <- function(path.export, dataV = dataV, dataK = dataK) {
  
  dbtemp <- data.table(read.table(path.export, sep = ";", h = T, dec = ",", quote = "", colClasses = "character"))
  db <- data.table(read.table(path.export, sep = ";", h = T, dec = ",", quote = ""))
  
  db[, EAN := dbtemp$EAN] # in order to keep EAN read as character and avoid to miss leading 0
  rm(dbtemp)
  
  
  debug.easy(!all(c("In.Aufträgen", "Lagerbestand..gesamt.") %in% names(db)), "", bgMagenta("[DEBUG]"), " - some columns are missing : In.Aufträgen or Lagerbestand..gesamt.")
  
  setnames(db, "Artikelnummer", "Artikelnummer.db")
  
  db[, EAN := as.character(EAN)]
  
  dbK <- db[Varkombi.Vater == F]
  dbK
  
  dbV <- db[Varkombi.Vater == T | c(Varkombi.Vater == F & Varkombi.Kind == F)] # also the one that are alone
  dbV
  
  assign("dbK", dbK, env = .GlobalEnv)
  assign("dbV", dbV, env = .GlobalEnv)
  
  cat("\n", yellow("[INFO]"), " - Robjects assigned, 'dbK' and 'dbV', Kinder und vater from offiziel DB\n")
  
  cat("\n", yellow("[INFO]"), " - Lager:\n")
  dbK.lager <- dbK[Verfügbar..gesamt. != 0]
  dbK.lager
  assign("dbK.lager", dbK.lager, env = .GlobalEnv)
  cat(nrow(dbK.lager), " Articles with value in lager - Robject 'dbK.lager'\n")
  
  dbK.auftrag <- dbK[In.Aufträgen != 0 ]
  assign("dbK.auftrag", dbK.auftrag, env = .GlobalEnv)
  cat(nrow(dbK.auftrag), " Articles with value in lager and something in auftrag - Robject 'dbK.auftrag'\n")
  
}

read.DB.ameise <- function(path.export, dataV = dataV, dataK = dataK) {
  
  dbtemp <- fread(path.export, colClasses = "character", check.names = T)
  dbtemp
  db <- fread(path.export, check.names = T, dec = ",", encoding = "Latin-1")
  db
  
  
  # JTL-wawi version 1.6
  if("GTIN" %in% names(db)) {
    old <- c("Eigene.ID", "Identifizierungsspalte.Vaterartikel", "Onlineshop..BS.Maxi...Onlineshop.aktiv", "Auf.Lager", "Durchschnittlicher.Einkaufspreis..netto.", "Brutto.VK")
    new <- c("Serie", "VID", "Online.Shop.Aktiv", "Lager", "EK", "VK")
    setnames(dbtemp, old, new)
    setnames(db, old, new)
  }
  # JTL-wawi version 1.5
  if("EAN.Barcode" %in% names(db)) {
    old <- c("EAN.Barcode", "Vaterartikel.ArtNr", "Shop.BS.Maxi.Webshop.aktiv", "Lagerbestand.Gesamt", "EK.Netto..für.GLD.", "Std..VK.Brutto")
    new <- c("GTIN", "VID", "Online.Shop.Aktiv", "Lager", "EK", "VK")
    setnames(dbtemp, old, new)
    setnames(db, old, new)
  }
  
  dbtemp
  debug.easy(nrow(dbtemp[grep("e|E|,", GTIN)]) > 0, "Something went wrong with EAN reading ....check if it is in scientific format ... 4.08e+12")
  
  db[, GTIN := dbtemp$GTIN] # in order to keep EAN read as character and avoid to miss leading 0
  rm(dbtemp)
  
  setnames(db, c("Artikelnummer"), c("Artikelnummer.db"))
  
  # old code before 20211005
  # dbV <- db[VID == ""]
  # dbK <- db[VID != ""]
  dbV <- db[GTIN == ""]
  dbK <- db[GTIN != ""]
  
  # avoid to have error when no vater at all or NA value (normally does not happend if it exists at least 1 VID)
  if( class(dbK$VID) != "character" ) { 
    dbK[, VID := as.character(VID)]
    dbK[is.na(VID), VID := ""]
  }
  
  format.GTIN(dbK, "GTIN")
  
  
  
  
  assign("dbK", dbK, env = .GlobalEnv)
  assign("dbV", dbV, env = .GlobalEnv)
  
  cat("\n", yellow("[INFO]"), " - Robjects assigned, 'dbK' and 'dbV', Kinder und vater from offiziel DB\n")
  
  cat("\n", yellow("[INFO]"), " - Lager:\n")
  dbK.lager <- dbK[Lager != 0]
  
  assign("dbK.lager", dbK.lager, env = .GlobalEnv)
  cat(nrow(dbK.lager), " Articles with value in lager - Robject 'dbK.lager'\n")
  
  
  
}

readDB <- function(table.name, name.return = "data", DB = "test") {
  
  # # MariaDB is SQL
  # readDB("Mapping_R", "CPidmapping") # will run select * from cpidmapping
  # readDB("Mapping_R", "select * from CPidmapping where CPid='AXX00311428_001'")
  # readDB("Mapping_R", "select * from CPidmapping limit 10")  # select frist 10 lines
  # readDB("Mapping_R", "select * from CPidmapping where Copy=6", "map") # select only copy6
  
  # 
  # # REMP is oracle
  # readDB("REMP_prod", "user_tables")
  # readDB("REMP_prod", "select * from EXT_MAPPING where rownum < 5") # normally finished with ; but for this function not
  # readDB("REMP_prod", "select * from EXT_MAPPING where BARCODE='700000003681'")
  # readDB("REMP_prod", "select * from HITPLATES where PLA_CODE in ('700000003700', '700000003701', '700000003688')")
  # readDB("REMP_prod", "HITPLATES") # function also with viewtables (not only table_names)
  
  # if there is a space in the table.name with read the table if not consider that table.name is a statement
  
  if(DB == "offi") {
    dbname <- "eazybusiness"
  } else {
    dbname <-  "Mandant_1"
  }
  
  tryCatch({ 
    
    odbc::odbcListDrivers()
    
    # for exact parameters look here https://www.connectionstrings.com/
    # for exact parameters look here https://www.connectionstrings.com/
    # for exact parameters look here https://www.connectionstrings.com/
    # for exact parameters look here https://www.connectionstrings.com/
    
    conn <- dbConnect(odbc::odbc(), Driver = "SQL Server", Server = "bergsportmaxi\\jtlwawi", 
                     Database = dbname, UID = "sa", PWD = "HuSa1610", Port = 1433, encoding = "latin1")
    
    # dbDisconnect(conn)
    
    
    if( grepl("select ", table.name, ignore.case=TRUE) ) {
      queryf<-  table.name
    } else {
    
      column.types <- data.table(dbGetQuery(conn, p0("SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='", table.name, "'")))
      indeq <- dbSendQuery(conn, table.name)
      inde <- data.table(dbColumnInfo(indeq))
      dbClearResult(indeq)
      inde
      setnames(inde, "name", "COLUMN_NAME")
      column.types <- dtjoin(column.types, inde)
      column.types <- column.types[order(type)]
      print(kable(column.types))
      
      # # test
      # column.types
      # column.types[is.na(CHARACTER_MAXIMUM_LENGTH), CHARACTER_MAXIMUM_LENGTH := -30]
      # column.types[, COLUMN_NAME2 := COLUMN_NAME]
      # column.types <- column.types[order(CHARACTER_MAXIMUM_LENGTH)]
      # column.types[CHARACTER_MAXIMUM_LENGTH %in% c(4000, 255), COLUMN_NAME2 := p0("left(", COLUMN_NAME, ", 20) as ", COLUMN_NAME)]
      # column.types
      # queryf <- p0("select ", paste(column.types$COLUMN_NAME2[1:8], collapse = ", "), " from ", table.name)
      # queryf
  
      # omitted <- column.types[CHARACTER_MAXIMUM_LENGTH == 0]
      # omitted <- column.types[CHARACTER_MAXIMUM_LENGTH %in% c(0, 2147483647)]
      omitted <- column.types[CHARACTER_MAXIMUM_LENGTH %in% c(0, 4000, 2147483647) | type %in% c(-2)]
      # omitted <- column.types[CHARACTER_MAXIMUM_LENGTH %in% c(4000, 255, 2147483647) | type %in% c(-2, -9)]
      # omitted <- column.types[CHARACTER_MAXIMUM_LENGTH %in% c(4000, 255, 2147483647, 500) | type %in% c(-2)]
      cat("\n---------------------------------")
      cat(red("\nVariables omitted: \n"))
      print(kable(omitted))
      column.types <- column.types[!COLUMN_NAME %in% omitted$COLUMN_NAME][order(-type)]
      column.types
      queryf <- p0("select ", paste(column.types$COLUMN_NAME, collapse = ", "), " from ", table.name)
    
    }
    
    data <- data.table(dbGetQuery(conn, queryf))
    # ltable <- data.table(Name.tables = dbListTables(conn))
    ltable <- data.table(dbGetQuery(conn, "SELECT  t.NAME AS TableName, s.Name AS SchemaName, p.rows, SUM(a.total_pages) * 8 AS TotalSpaceKB,  CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TotalSpaceMB, SUM(a.used_pages) * 8 AS UsedSpaceKB,  CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS UsedSpaceMB,  (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB, CAST(ROUND(((SUM(a.total_pages) - SUM(a.used_pages)) * 8) / 1024.00, 2) AS NUMERIC(36, 2)) AS UnusedSpaceMB FROM  sys.tables t INNER JOIN sys.indexes i ON t.OBJECT_ID = i.object_id INNER JOIN  sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id INNER JOIN  sys.allocation_units a ON p.partition_id = a.container_id LEFT OUTER JOIN  sys.schemas s ON t.schema_id = s.schema_id WHERE  t.NAME NOT LIKE 'dt%'  AND t.is_ms_shipped = 0 AND i.OBJECT_ID > 255  GROUP BY  t.Name, s.Name, p.Rows ORDER BY p.rows DESC, t.Name"))
    ltable <- ltable[rows > 0]
    
    suppressWarnings(dbDisconnect(conn))
    
    assign(name.return, data, envir = parent.frame(1)) # parent.frame(1), to assign to the envir before, important for function like check.integrity which use readDB
    cat("\n\n", name.return, " R object assigned.")
    assign("ltable", ltable, envir = parent.frame(1))
    cat("\n ltable R object assigned. ---- ", green(nrow(ltable)), "tables in the DB\n")
    
  }, error=function(e) {
    # if error close the connection
    cat("\n\n, ERROR: \n")
    print(e)
    suppressWarnings(dbDisconnect(conn))    
    cat("\n[DEBUG] - ERRROR - dbconnexion closed.\n")
    # kable(data.table(Name.tables = dbListTables(mydb)))
    # detach("package:RJDBC", unload=TRUE)
  })
  
}

dbUpdateVars <- function(dbtable, DATA, column.old, column.new, DB = "test") { 
  
  if(DB == "offi") {
    dbname <- "eazybusiness"
  } else {
    dbname <-  "Mandant_1"
  }
  
  
  odbc::odbcListDrivers()
  
  # for exact parameters look here https://www.connectionstrings.com/
  # for exact parameters look here https://www.connectionstrings.com/
  # for exact parameters look here https://www.connectionstrings.com/
  # for exact parameters look here https://www.connectionstrings.com/
  
  conn <- dbConnect(odbc::odbc(), Driver = "SQL Server", Server = "bergsportmaxi\\jtlwawi", 
                   Database = dbname, UID = "sa", PWD = "HuSa1610", Port = 1433, encoding = "latin1")
    
  DATA2 <- DATA[, .N, c(column.new, column.old)]
  DATA2 <- DATA2[get(column.new) != get(column.old)]
  DATA2
  
  cat("[INFO] - You are ready to update", nrow(DATA2), "from", dbtable)
  WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue [Y or N]?"))
  
  if( DB == "offi" ) {
    WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?"))
  }

  
  for (i in 1:nrow(DATA2)) {
    queryf <- p0("update ", dbtable, " set ", column.old, " = ", 
                 ifelse(is.character(DATA2[i, get(column.new)]), p0("'", DATA2[i, get(column.new)], "'"), DATA2[i, get(column.new)]), 
                 " where ", column.old , " = ", 
                 ifelse(is.character(DATA2[i, get(column.old)]), p0("'", gsub("'", "''", DATA2[i, get(column.old)]), "'"), DATA2[i, get(column.old)]))
    print(queryf)
    suppressWarnings(dbSendQuery(conn, queryf))
    cat(i,"/", nrow(DATA2))
  }
  
  suppressWarnings(dbDisconnect(conn))

      
} 

dbSendSQL <- function(sql, DB = "test") { 
  
  if(DB == "offi") {
    dbname <- "eazybusiness"
  } else {
    dbname <-  "Mandant_1"
  }
  
  
  odbc::odbcListDrivers()
  
  # for exact parameters look here https://www.connectionstrings.com/
  # for exact parameters look here https://www.connectionstrings.com/
  # for exact parameters look here https://www.connectionstrings.com/
  # for exact parameters look here https://www.connectionstrings.com/
  
  conn <- dbConnect(odbc::odbc(), Driver = "SQL Server", Server = "bergsportmaxi\\jtlwawi", 
                   Database = dbname, UID = "sa", PWD = "HuSa1610", Port = 1433, encoding = "latin1")
    
  
  cat(yellow("[INFO]"), "- You are ready to run those sql")
  kable(sql)
  WaitYorN(p0("\n\n", bgCyan("[IMPORTANT]"), " - Are you sure you wanna continue [Y or N]?"))
  
  if( DB == "offi" ) {
    WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?"))
  }

  
  for (i in seq_along(sql)) {
    queryf <-sql[i]
    cat(i,"/", length(sql), " --- Try: ", queryf, "\n")
    suppressWarnings(dbSendQuery(conn, queryf))
  }
  
  suppressWarnings(dbDisconnect(conn))

      
} 





# variation ---------------------------------------------------------------

getcommonstring <- function(s) {
  temp <- GrpString::CommonPatt(s) %>% 
    filter(Freq_str == length(s)) %>% filter(Length == max(Length, na.rm = T)) %>% 
    select(Pattern) %>% unlist(use.names = F)
  return(temp)
}

get.common.ID <- function(data, var.common, var.get.common, var.name) {
  
  listpro <- u(data[[var.common]])
  data[, c(var.name) := ""]
  cat("", yellow("[INFO]"), " - Creating new column '", var.name, "' searching common variable in '", var.get.common, "' filtered with '", var.common, "'")
  for(i in seq_along(listpro)) {
    tryCatch({
      data[get(var.common) == listpro[i], c(var.name) := getcommonstring(get(var.get.common))]
    }, error=function(e) {
      
      cat("\n\n", bgMagenta("[DEBUG]"), " - stopped at id", i, "listpro <- u(data[[var.common]]) = ", listpro[i], "\n")
      print(data[get(var.common) == listpro[i], .(get(var.get.common), get(var.common))])
    })
  }
  
}

# get longest common string
get.lcs <- function(string, vector) {
# get longest common string

  debug.easy(length(string) != 1, "Your string parameter should be of length 1")
  sb <- stri_sub(string, 1, 1:nchar(string))
  # sstr <-  stri_extract_all_coll(x, sb, simplify=TRUE, omit_no_match = T)
  sstr <- c()
  for(i in seq_along(sb)) {
    sstr <- c(sstr, stri_extract_all_coll(vector, sb[i], omit_no_match = T, simplify = T))
  }
  result <- sstr[which.max(nchar(sstr))]
  return(result)
}

get.lcs.vector <- function(your.vector) {

  # Find common character to create an ID
  # 
  # `get.lcs.vector` permit to find a the longest common id from a group of values.
  # It can be easily use with data.table \code{dt[, newcolumn := get.lcs.vector(your.vector), .(your.group.column)]}
  # 
  # @param your.vector a vector or a variable from a data.table.
  # @return a data.table, invisibly.
  # @export
  # @examples
  # dt[, newcolumn := get.lcs.vector(your.vector), .(your.group.column)]
  
  # tryCatch( {
    combi <- data.table(expand.grid(your.vector, your.vector, stringsAsFactors = F))[Var1 != Var2]
    combi
    if( nrow(combi) != 0) {
      combi.result <- unique(mapply(get.lcs, combi[[1]], combi[[2]]))
      combi.result
      lcs <- unlist(combi.result[which.min(nchar(combi.result))])
      lcs
      return(lcs)
    } else {
      debug.easy(T, "Number of combi == 0, check please")
    }
  # }, error=function(e) {
  #   browser()
  # })
  

}

extract.info.variation <- function(data, vector.variation, var.look, new.column) {
  # browser()
  
  # Function to extract information from a description or article name, depending on list of colors, size and so on, using gsub
  data[, c(new.column) := ""]
  
  debug.easy(any(vector.variation %like% "\\$"), "You should not have $ in your vector.variation")
  
  vector.variation <- vector.variation[order(-nchar(vector.variation))]
  vector.variation2 <- quotemeta(vector.variation)
  
  for(i in seq_along(vector.variation)) {
    # data[get(var.look) %like% vector.variation[i], c(new.column) := gsub("^ - ", "", p0(get(new.column), " - ", vector.variation[i]))]
    regexexp <- p0(" ", vector.variation2[i], " | ",
                   vector.variation2[i], "$|^",
                   vector.variation2[i], " ")
    regexexp
    j <- data[, .I[get(var.look) %like% regexexp & get(new.column) == ""]]
    
    if(length(j) > 0) {
      data[j, c(new.column) := vector.variation[i]]
      data[j, c(var.look) := gsub(p0(" ", vector.variation2[i], "$"), "", get(var.look))]
      data[j, c(var.look) := gsub(p0(" ", vector.variation2[i], " "), " ", get(var.look))]
      data[j, c(var.look) := gsub(p0("^", vector.variation2[i], " "), " ", get(var.look))]
      data[j, c(var.look) := gsub(p0("^", vector.variation2[i]), "", get(var.look))]
      data[j, c(var.look) := gsub("^ *| *$", "", get(var.look))]
    }
    
  }
  (data)
}

remove.variation.artikelname.v03 <- function(data, where2remove, listcol2remove) {
  
  # list.col.to.remove <- c("Colour", "Size")
  # where.to.remove <- "Product.Description"
  # browser()
  for (j in seq_along(listcol2remove)) {
    data[, temp := nchar(get(listcol2remove[j]))] # to order longer size or color to remove first
    for (i in 1:nrow(data[,.N, get(listcol2remove[j])]) ) {
      toremove <- data[order(-temp),.N, c(listcol2remove[j])][[i, listcol2remove[j]]]
      
      
      if( toremove != "" & !is.na(toremove) ) {
        # # DEBUG check
        # if(toremove %like% "Grigri\\+") browser()
        # data[i, get(where2remove)]
        # toremove
        # (temp <- gsub("(.*)\\s$", "\\1", gsub(p0("\\s", toremove, "|", toremove, "\\s"), " ", data[i, get(where2remove)], ignore.case =T)))
        # (temp <- gsub(toremove, " ", temp, fixed = T))
        # gsub("^ $|^ *| *$", "", temp)
        
  # browser()
        # data[i, c(where2remove) := gsub("(.*)\\s$", "\\1", gsub(p0("\\s", toremove, "|", toremove, "\\s"), " ", get(where2remove), ignore.case =T))] # removed 20211218
        a <- p0("\\s", toremove, "\\s|\\s", toremove, "$|^", toremove, "\\s|,", toremove, "\\s|\\s", toremove, ",")
        data[get(listcol2remove[j]) == toremove, c(where2remove) := gsub("(.*)\\s$", "\\1", gsub(a,
          " ", get(where2remove), ignore.case =T))]
        # data[i, c(where2remove) := gsub(toremove, " ", get(where2remove), fixed = T)] # removed 20211218
      }
      # data[i, c(where2remove, listcol2remove[j]), with = F]
    }
  }
  data[, c(where2remove) := gsub("^ $|^ *| *$", "", get(where2remove))]
  data[, temp := NULL]
  data
  data
  
}





# Ameise ------------------------------------------------------------------

Ameise.import.code <- function(Vater.file, 
                               Kinder.file,
                               Firma,
                               DB = "test",
                               export.bat.path = "C:/Users/dorian.BSPM/Dropbox/Shared_Dorian/Firmen_Listen_EAN/Listen/Formatted",
                               out = "Ameise_temp.bat",
                               ask.confirmation = T) {
  
  if( all( DB == "offi", ask.confirmation) ) {
    WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?"))
  }

  
  debug.easy(all( !hasArg(Vater.file), !hasArg(Kinder.file) ), "You need at least one Kinder.file or one Vater.file parameter.")
  
  if(  hasArg(Vater.file) ) {
    inpu.V <- gsub("/", "\\\\", Vater.file)
  }
  if(  hasArg(Kinder.file) ) {
    inpu.K <- gsub("/", "\\\\", Kinder.file)
  }
  
  code <- vector()
  if(  hasArg(Vater.file) ) { 
    code <- c(code, code.ameise(DB. = DB, vorlage = "IMP24", inputfile = inpu.V, log.suffix = "Vater", log.path = formattedpath, call.check = T, title.cmd = T))
  }
  if(  hasArg(Kinder.file) ) { 
    code <- c(code, code.ameise(DB. = DB, vorlage = "IMP25", inputfile = inpu.K, log.suffix = "Kinder_1st_try", log.path = formattedpath, call.check = F))
    code <- c(code, code.ameise(DB. = DB, vorlage = "IMP25", inputfile = inpu.K, log.suffix = "Kinder", log.path = formattedpath, call.check = T))
  }
  
  if( DB == "offi" ) {
    code <- c(code, p0("copy ", inpu.K, " Imported\\", gettimestamp(F), "_", basename(inpu.K)))
    code <- c(code, p0("copy ", inpu.V, " Imported\\", gettimestamp(F), "_", basename(inpu.V)))
  }
  
  # writeLines(code.end, p0("C:\\Users\\buero.BSPM\\Dropbox\\Shared_Dorian\\Firmen_Listen_EAN\\Listen\\Formatted\\", out))
  writeLines(code, p0(export.bat.path, "/",  out))
  
  cat("", yellow("[INFO]"), " - You need to open Firmen_Listen_EAN\\Listen\\Ameise_temp.bat your self !!!! I do not know why stop in the middle if I use BrowseURL()")
  
}

Ameise.import.todelete <- function(DB = "test", DATA = todelete, batch.file.output = F) {
  
  
  if( DB == "offi") {
    WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?"))
  }
  
  
  output <- p0(rootpath, 'Firmen_Listen_EAN/Import/', gettimestamp(long = F), "_", gsub(" ", "", Firma), "_DELETE.csv")
  output2 <- gsub("^.*C:", "C:", gsub("/", "\\\\", output))
  
  if("Artikelnummer" %in% names(DATA) ) {
    cols <- c("Artikelnummer", "Artikelname")
  } else {
    if("GTIN" %in% names(DATA) ) {
      cols <- c("GTIN", "Artikelname")
    }
  }
  debug.easy(!all(cols %in% names(DATA)), p0("You miss some columns: ", paste0(cols, collapse = " ")))
  setcolorder(DATA, c(cols, names(DATA)[!names(DATA) %in% cols]))
  
  write.csv.wawi(DATA, datapath = output)
  
  
  if("Artikelnummer" %in% names(DATA) ) {
    code <- code.ameise(DB. = DB, vorlage = "IMP27", inputfile = output2, log.suffix = "DELETE")
  }
  if("GTIN" %in% names(DATA) ) {
    code <- code.ameise(DB. = DB, vorlage = "IMP29", inputfile = output2, log.suffix = "DELETE")
  }
  
  
  
  
  # writeLines(code, "test.txt")
  cat(cyan(code))
  WaitYorN(p0("\n\n", bgCyan("[QUESTION]"),  "You know need to delete the -todelete- article ..... before going to the next step !\n\nDo you want to run the code in Ameise [Y or N] ? and delete afterwards manually\n"))
  
  if( batch.file.output ) {
    cat(yellow("\n[Info] - code in batchfile\n"))
    writeLines(code, "C:/Users/dorian.BSPM/Dropbox/Shared_Dorian/Firmen_Listen_EAN/Listen/Formatted/ToDelete_article.bat")
  } else {  
    system(code)
  }
  
  # renummer Vater to be sure that you can import the DATA even if you do not delete the articles
  if( "Artikelnummer" %in% names(DATA) ) {
    DATA2 <- copy(DATA)
    DATA2[, Artikelnummer := p0(Artikelnummer, "-todelete")]
    write.csv.wawi(DATA2, datapath = output)
    code <- code.ameise(DB. = DB, vorlage = "IMP33", inputfile = output2, log.suffix = "DELETE")
    Sys.sleep(2) 
    system(code)
  }
  
  
}

Ameise.import.lost.articles <- function(DB = "test", DATA = lost.articles) {
  
  
  if( DB == "offi") {
    WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?"))
  }

  

#   debug.easy(!all(c("GTIN", "Eigene ID", "UVP", "Brutto-VK", "Durchschnittlicher Einkaufspreis (netto)",
# "Lager", "Identifizierungsspalte Vaterartikel", "Artikelnummer", 
# "Artikelname", "Hersteller", "Variationswert 1", 
# "Variationswert 2", "Variationsname 1", "Variationsname 2") %in% names(DATA)), "You have columns missing ...")
  
  outputV <- p0(rootpath, 'Firmen_Listen_EAN/Import/', gettimestamp(long = F), "_", Firma, "_LOST.ARTICLES_Vater.csv")
  outputK <- p0(rootpath, 'Firmen_Listen_EAN/Import/', gettimestamp(long = F), "_", Firma, "_LOST.ARTICLES_Kinder.csv")
  outputV2 <- gsub("^.*C:", "C:", gsub("/", "\\\\", outputV))
  outputK2 <- gsub("^.*C:", "C:", gsub("/", "\\\\", outputK))
  
  write.csv.wawi(DATA[is.na(GTIN)], datapath = outputV)
  write.csv.wawi(DATA[!is.na(GTIN)], datapath = outputK)
  
  WaitYorN(p0("\n\n", bgCyan("[QUESTION]"),  " - Do you have imported all new articles before doing this [Y or N] ?"))

  code <- code.ameise(DB. = DB, vorlage = "IMP24", inputfile = outputV2, log.suffix = "LOST.ARTICLES_Vater", call.check = T)
  system(code[1])
  system("cmd.exe", code[2], intern = F, ignore.stdout = F, ignore.stderr = F, wait = F, show.output.on.console = T)
  code <- code.ameise(DB. = DB, vorlage = "IMP25", inputfile = outputK2, log.suffix = "LOST.ARTICLES_Kinder_1st_try")
  system(code)
  code <- code.ameise(DB. = DB, vorlage = "IMP25", inputfile = outputK2, log.suffix = "LOST.ARTICLES_Kinder", call.check = T)
  
  
  
  system(code[1])
  system(code[2])
  system("cmd.exe", code[2], intern = F, ignore.stdout = F, ignore.stderr = F, wait = F, show.output.on.console = T)
  
  
}

Ameise.import.lager <- function(DB = "test", DATA = toimport) {
  
  if( DB == "offi") {
    WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?"))
  }
  
  cols <- c("GTIN",	"Lagerbestand")
  debug.easy(!all(cols %in% names(DATA)), p0("You miss some columns: ", paste0(cols, collapse = " ")))
  setcolorder(DATA, c(cols, names(DATA)[!names(DATA) %in% cols]))
  
  output <- p0(rootpath, 'Firmen_Listen_EAN/Import/', gettimestamp(long = F), "_", Firma, "_LAGER.csv")
  output2 <- gsub("^.*C:", "C:", gsub("/", "\\\\", output))
  
  
  write.csv.wawi(DATA, datapath = output)
  
  code <- code.ameise(DB. = DB, vorlage = "IMP26", inputfile = output2, log.suffix = "LAGER")

  
  # writeLines(code, "test.txt")
  cat("Code:\n", code, "\n")
  WaitYorN(p0("\n\n", bgCyan("[QUESTION]"),  " - Do you have imported all new articles before doing this [Y or N] ?"))
  system(code)
}

Ameise.import.renummer.Vater.Serie <- function(DB = "test", DATA = K.GTIN.up.pb.V2.modify.Vater2) {
  
  
  if( DB == "offi") {
    WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?"))
  }
  WaitYorN(p0("\n\n", bgCyan("[QUESTION]"),  " - Are you sure you wanna renummer all those Vater  [Y or N] ?"))

  output <- p0(rootpath, 'Firmen_Listen_EAN/Import/', gettimestamp(long = F), "_", Firma, "_renummer-Vater.csv")
  output2 <- gsub("^.*C\\:", "C:", gsub("/", "\\\\", output))
  
  cols <- c("Artikelname", "Artikelnummer", "Serie")
  debug.easy(!all(cols %in% names(DATA)), p0("You miss some columns: ", paste0(cols, collapse = " ")))
  setcolorder(DATA, c(cols, names(DATA)[!names(DATA) %in% cols]))
  
  setnames(DATA, "Serie", "Eigene ID")
  
  write.csv.wawi(DATA, datapath = output)
  
  code <- code.ameise(DB. = DB, vorlage = "IMP28", inputfile = output2, log.suffix = "renummer-Vater")

  
  # writeLines(code, "test.txt")
  cat(cyan(code))
  system(code)
}

Ameise.import.renummer.Kinder.Serie <- function(DB = "test", DATA =  K.GTIN.no.pb.AN) {
  
  if( DB == "offi") {
    WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?"))
  }
  
  DATA1 <-  copy(DATA)

  output <- p0(rootpath, 'Firmen_Listen_EAN/Import/', gettimestamp(long = F), "_", Firma, "_renummer-Kinder.csv")
  output2 <- gsub("^.*C:", "C:", gsub("/", "\\\\", output))
  
  if( "Artikelnummer.db" %in% names(DATA1)) {    setnames(DATA1, "Artikelnummer.db", "Artikelnummer")  }
  if( "Serie" %in% names(DATA1)) {    setnames(DATA1, "Serie", "Serie.db")  }
  
  cols <- c("GTIN", "Artikelnummer", "Artikelname")
  debug.easy(!all(cols %in% names(DATA1)), p0("You miss some columns: ", paste0(cols, collapse = " ")))
  
  DATA1 <- DATA1[, .(GTIN, Artikelnummer = p0(Artikelnummer, "-", Serie), Artikelname)]
  DATA1[, Kategorie.Ebene.1 := "do not take in account"]
  setcolorder(DATA1, c(cols, names(DATA1)[!names(DATA1) %in% cols]))
  
  
  DATA1 <- rename.col.names.maxi(DATA1)
  
  write.csv.wawi(DATA1, datapath = output)
  
  code <- code.ameise(DB. = DB, vorlage = "IMP31", inputfile = output2, log.suffix = "renummer-Kinder")

  
  # writeLines(code, "test.txt")
  cat(cyan(code))
  WaitYorN(p0("\n\n", bgCyan("[QUESTION]"),  " - Are you sure you wanna renummer all those Kinders - it will add the serie number  [Y or N] ?"))
  system(code)
}

Ameise.import.change.Vater <- function(DB = "test", DATA) {
  
  
  debug.easy(T, "PLEASE CHECK THIS FUNCTION, USED IT RARELY RARE and check the vorlage")
  
  
  if( DB == "offi") {
    WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?"))
  }
  
  output <- p0(rootpath, 'Firmen_Listen_EAN/Import/', gettimestamp(long = F), "_", Firma, "_change-Vater.csv")
  output2 <- gsub("^.*C:", "C:", gsub("/", "\\\\", output))
  
  cols <- c("Artikelnummer", "Vaterartikel ID-Feld", "Variationsname 1", "Variationswertname 1")
  if( "Variationswertname 2" %in% names(DATA) ) {
    cols <- c(cols, "Variationsname 2", "Variationswertname 2")
  }
  debug.easy(!all(cols %in% names(DATA)), p0("You miss some columns: ", paste0(cols, collapse = " ")))
  setcolorder(DATA, c(cols, names(DATA)[!names(DATA) %in% cols]))
  
  write.csv.wawi(DATA, datapath = output)
  
  code <- code.ameise(DB. = DB, vorlage = "IMP30", inputfile = output2, log.suffix = "change-Vater")
  
  # writeLines(code, "test.txt")
  cat(cyan(code))
  WaitYorN(p0("\n\n", bgCyan("[QUESTION]"),  " - Are you sure you wanna change those Vater  [Y or N] ?"))
  system(code)
}

Ameise.import.price.update <- function(DB = "test", DATA,
                                       export.bat.path = "C:/Users/dorian.BSPM/Desktop/Export_ALL_for-price-update/") {
  
  
    output <- p0(rootpath, 'Firmen_Listen_EAN/Import/', gettimestamp(long = F), "_", Firma, "_Price-update.csv")
    output2 <- gsub("^.*C:", "C:", gsub("/", "\\\\", output))
    
    cols <- c("GTIN", "Hersteller", "UVP", "Brutto-VK", "Durchschnittlicher Einkaufspreis (netto)", "Lieferant")
    debug.easy(!all(cols %in% names(DATA)), p0("You miss some columns: ", paste0(cols, collapse = " ")))
    setcolorder(DATA, c(cols, names(DATA)[!names(DATA) %in% cols]))
    
    write.csv.wawi(DATA, datapath = output)
    write(p0("[", format(Sys.time(), format = "%Y%m%d-%H%M"), "] - R - SUCCESS - file to update: \t*", basename(output), "*"), "C:/Users/dorian.BSPM/Desktop/Export_ALL_for-price-update/logfile.log", append = T)
    
    code <- code.ameise(DB. = DB, vorlage = "IMP35", inputfile = output2, log.suffix = "Price-update")
    
    writeLines(code, p0(export.bat.path, "TEMP_Price-update.bat"))

    # writeLines(code, "test.txt")
    cat(cyan(code))
    # WaitYorN(p0("\n\n", bgCyan("[QUESTION]"),  " - Are you sure you wanna change those Vater  [Y or N] ?"))
    # system(code)
}

Ameise.import.rename.or.renummer <- function(DB = "test", DATA, mode) {
  
  #' Title
  #'
  #' @param DB Your database
  #' @param DATA Your data that you wanna use to import
  #' @param mode "rename" or "renummer", if you use GTIN as variable you can only "rename"
  #'
  #' @return
  #' @export
  #'
  #' @examples
  
  if( DB == "offi") {
    WaitYorN(p0("\n\n[IMPORTANT] - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?\n\n\t\t\t\tYou wanna ", toupper(mode)))
  }
  
  
  debug.easy(ncol(DATA) != 2, "You need only 2 columns in your DATA")
  
  output <- p0(rootpath, 'Firmen_Listen_EAN/Import/', gettimestamp(long = T), "_", gsub(" ", "", Firma), "_", mode, ".csv")
  output2 <- gsub("^.*C:", "C:", gsub("/", "\\\\", output))
  
  if("Artikelnummer" %in% names(DATA) ) {
    if( mode == "rename" ) ( vorl <- "IMP27")
    if( mode == "renummer" ) ( vorl <- "IMP33")
    cols <- c("Artikelnummer", "Artikelname")
  } else {
    if("GTIN" %in% names(DATA) ) {
      debug.easy(mode = "renummer", "You can only rename with GTIN variable")
      if( mode == "rename" ) ( vorl <- "IMP29")
      cols <- c("GTIN", "Artikelname")
    }
  }
  debug.easy(!all(cols %in% names(DATA)), p0("You miss some columns: ", paste0(cols, collapse = " ")))
  setcolorder(DATA, c(cols, names(DATA)[!names(DATA) %in% cols]))
  
  write.csv.wawi(DATA, datapath = output)
  
  
  code <- code.ameise(DB. = DB, vorlage = vorl, inputfile = output2, log.suffix = mode)
  
  system(code)

  
}

code.ameise <- function(DB., vorlage, inputfile, log.suffix, Firma. = Firma, log.path = importpath, call.check = F, title.cmd = F) {
    
  
    code <- '"C:\\Program Files (x86)\\JTL-Software\\JTL-wawi-ameise.exe" -s 192.168.178.100,1433\\JTLWAWI -d '
    
    if( DB. == "test") {
      code <- p0(code, "Mandant_1")
    } else {
      if( DB. == "offi") {
        code <- p0(code, "eazybusiness")
        # WaitYorN(p0("\n\n", bgRed("[IMPORTANT]"), " - Are you sure you wanna continue you will do modif in OFFICIAL Databank [Y or N]?"))
      } else {
        debug.easy(T, "Error in your DB object, sjould be test or offi")
      }
    }
    
    inputfile <- gsub("/", "\\\\", rP(gsub("file:\\\\\\\\\\\\", "", inputfile)))
    
    olog <- p0(gsub("/", "\\\\", rP(log.path)), "Logs\\", format(Sys.time(),"%Y%m%d-%H%M%S"), "_",  gsub(" ", "_", Firma.), "_", DB., '_', log.suffix, '.log')
    code <- p0(code, " -u sa -p HuSa1610 --loglevel=1 -t ", vorlage, ' --inputfile="', inputfile, '" --log="', olog, '"')
    
    if( call.check ) {
      code <- c(code, p0('call "', gsub("/", "\\\\", rP(formattedpath)), 'BATCH_Check_Ubergehe_datensatz_AKTUALI_v08.bat" "', inputfile, '" ', olog))
      # To use this do not use system(code) but
      # system("cmd.exe", code[2], intern = F, ignore.stdout = F, ignore.stderr = F, wait = F, show.output.on.console = T)
    }
    
    if( title.cmd ) {
      code <- c(p0("title ", DB., "-", Firma), code)
    }
      
    
    return(code)
    
  }

export.data.wawi <- function(data, Vater.file = new.name.V, Kinder.file = new.name.K) {
  
  V <- data[is.na(GTIN)]
  K <- data[!is.na(GTIN)]
  
  tryCatch({
    write.csv.wawi(V, Vater.file)
    write.csv.wawi(K, Kinder.file)
  }, error=function(e) {
    write.csv.wawi(V, Vater.file)
    write.csv.wawi(K, Kinder.file)
  })
  
  
  
}

update.VaterID.from.db <- function(DATA, path.export.csv, skip.confirmation = F) {
  
  DATA[, VID.old := VID]
  # read actual db
  read.DB.ameise(path.export.csv)
  # get common EAN to update VaterID
  # t.db <- dbK[EAN %in% data$EAN & VID != ""][, .(EAN, VID)]
  # t.db <- dtjoin(t.db, dbV[, .(VID = Artikelnummer.db, Artikelname)]) # add ArtikelnameV in case to make things easier
  # t.db
  
  t.db <- dbK[VID != "", .(GTIN, VID)]
  t.db[, .N, VID][N == 1]
  t.db <- t.db[VID %in% t.db[, .N, VID][N > 1]$VID] # remove Vater with only 1 Kinder
  t.data <- DATA[GTIN %in% dbK$GTIN][, .(GTIN, VID)]
  t.data
  setnames(t.db, "VID", "VID.db")
  temp <- dtjoin(t.data, t.db)
  temp <- temp[!is.na(VID.db)]
  temp[, GTIN := NULL]
  temp <- u(temp)
  temp
  
  temp[VID.db %in% temp[, .N, .(VID.db)][N > 1]$VID.db]
  Vaterdupli.im <- temp[VID.db %in% temp[, .N, .(VID.db)][N > 1]$VID.db]$VID
  Vaterdupli.im
  temp[VID %in% temp[, .N, .(VID)][N > 1]$VID]
  Vaterdupli.db <-  temp[VID %in% temp[, .N, .(VID)][N > 1]$VID]$VID.db
  Vaterdupli.db
  
  Vaterdupli <- c(Vaterdupli.db, Vaterdupli.im)
  Vaterdupli.GTIN <-dbK[VID %in% Vaterdupli]$GTIN
  
  if( length(Vaterdupli) > 0 ) {
    temp <- temp[!VID.db %in% Vaterdupli]
    cat("\n\n--------------------------------------------------------------------------\n\n")
    cat("", bgMagenta("[DEBUG]"), " - you have Vaters in db that correrspond to several Vaters in import and vice versa, conflict with joining. I will update based on the import\n\n")
    error()
    cat("\n\n")
    print(dput(Vaterdupli))
    if( !skip.confirmation ) {
      WaitYorN("Please confirm you understood (Y)")
    }
  }
  
  
  # update VaterID from a dtjoin on VaterID... otherwise if you do an update on EAN you will miss the new variation because not in actual db
  # update VaterID from a dtjoin on VaterID... otherwise if you do an update on EAN you will miss the new variation because not in actual db
  # update VaterID from a dtjoin on VaterID... otherwise if you do an update on EAN you will miss the new variation because not in actual db
  update.DT(DATA1 = DATA,
            DATA2 = temp,
            join.variable = "VID",
            overwrite.variable = "VID",
            overwrite.with.variable = "VID.db")
  
  # get trace when VaterID is the same AND several variations, but there is a the new data only 1 article, to avoid to be overwritten by remove.single.article
  DATA[, Keep.VaterID := F]
  DATA[VID.old != VID, Keep.VaterID := T]
  DATA[GTIN %in% Vaterdupli.GTIN, Keep.VaterID := T]
  
  DATA[, Artikelnummer := gsub(VID.old, VID, Artikelnummer), by = .(VID.old, VID)]
  
  cat(yellow("[INFO] -"), "You have", yellow(nrow(DATA[VID != VID.old])), "rows where VID != VID.old", silver("data[VID != VID.old]\n"))
  
}

delete.Vater <- function(yourvector, .dbK = dbK, DATA = data, .dbV = dbV) {
  
  # if(!exists("dbK")) {
  #   stop("\n", bgMagenta("[DEBUG]"), " - You need to use the function read.DB.ameise to get Robject from the actual db\n")
  # }
  # if(!exists("data")) {
  #   stop("\n", bgMagenta("[DEBUG]"), " - You need the data from import with the GTIN field\n")
  # }
  if(!"GTIN" %in% names(DATA)) {
    stop("\n", bgMagenta("[DEBUG]"), " - You need GTIN field in your data table\n")
  }
    
  d.GTIN <- .dbK[VID %in% yourvector][!GTIN %in% DATA$GTIN] # will be delete definitively
  d.pro <- .dbK[Lager != 0 & VID %in% yourvector] # could delete lager or auftrag article !!!!
  d.pro2 <- d.pro[, .(GTIN, Lagerbestand = Lager)]
  d.rename <- .dbV[Artikelnummer.db %in% yourvector][, .(Artikelnummer = Artikelnummer.db, Artikelname)]
  d.rename[, Artikelname := p0(Artikelname, "-todelete")]
  if( exists("new.prices") ) {
    d.pri <- .dbK[VID %in% check & GTIN %in% new.prices$GTIN]
  }
  
  
  
  # prepare lost.article import
  lost.articles <- d.GTIN[, .(GTIN, UPC, Serie, UVP, VK, EK, Lager, VID, Artikelnummer = Artikelnummer.db, Artikelname, Hersteller)]
  ndim <- length(tstrsplit(lost.articles$Artikelname, " - ", fill = ""))
  if( ndim == 3 ) {
    lost.articles[, Artikelname := p0(Artikelname, " - None")]
  }
  if( ndim == 2 ) {
    lost.articles[, Artikelname := p0(Artikelname, " - None - None")]
  }
  if(ndim > 4) {
    print(lost.articles)
    debug.easy(ndim > 4, "You have error in seperator ' - ' that can makes problem to find variations")
  }
  if( nrow(lost.articles) > 0 ) {
    
    t <- copy(lost.articles)
    # lost.articles <- copy(t)
    lost.articles[, c("ID1", "ID2", "Variationswert.1", "Variationswert.2") := tstrsplit(Artikelname, " - ", fill = "")]
    lost.articles[, Variationsname.1 := "Farbe"]
    lost.articles[, Variationsname.2 := "Größe"]
    # lost.articles[Variationswert.1 == "", Variationswert.1 := "None"]
    # lost.articles[Variationswert.2 == "", Variationswert.2 := "None"]
    lost.articles[, Artikelname := p0(ID1, " - ", ID2, " - ", Variationswert.1, " - ", Variationswert.2)]
    lost.articles[, "Bestandsführung aktiv" := "Y"]
    lost.articles[, Kategorie.Ebene.1 := "IMPORT"]
    lost.articles[, Kategorie.Ebene.2 := Hersteller]
    lost.articles[, Kategorie.Ebene.3 := "R_lost.articles"]
    lost.articles[, Verkaufseinheit := "Stück"]
    
    lost.articles[, Keep.VaterID := F]
    
    
    
    
    lost.articlesV <- lost.articles[, .(Artikelnummer = VID,
                                        Artikelname = p0(ID1, " - ", ID2),
                                        Hersteller,
                                        # Herkunftsland,
                                        # TARIC_Code,
                                        Serie = max(Serie),
                                        Verkaufseinheit,
                                        Kategorie.Ebene.1 = ifelse("Kategorie.Ebene.1" %in% names(lost.articles), Kategorie.Ebene.1, ""),
                                        Kategorie.Ebene.2 = ifelse("Kategorie.Ebene.2" %in% names(lost.articles), Kategorie.Ebene.2, ""),
                                        Kategorie.Ebene.3 = ifelse("Kategorie.Ebene.3" %in% names(lost.articles), .SD[1, Kategorie.Ebene.3], ""),
                                        Kategorie.Ebene.4 = ifelse("Kategorie.Ebene.4" %in% names(lost.articles), .SD[1, Kategorie.Ebene.4], ""),
                                        Kategorie.Ebene.5 = ifelse("Kategorie.Ebene.5" %in% names(lost.articles), .SD[1, Kategorie.Ebene.5], ""),
                                        Kategorie.Ebene.6 = ifelse("Kategorie.Ebene.6" %in% names(lost.articles), .SD[1, Kategorie.Ebene.6], ""),
                                        # Bild.1.Pfad__URL = .SD[1,Bild.1.Pfad__URL],
                                        # Bild.2.Pfad__URL = .SD[2,Bild.1.Pfad__URL],
                                        # Bild.3.Pfad__URL = .SD[3,Bild.1.Pfad__URL],
                                        .N
                                        
    ), .(VID)]
    lost.articlesV <- lost.articlesV[!VID %in% u(DATA$VID)]
    lost.articlesV
    lost.articlesV[, VID := NULL]
    lost.articlesV
    
    
    
    
    lost.articles[, c("ID1", "ID2") := NULL]
    
    
    
    if( nrow(lost.articles[, .N, Artikelname][N > 1]) > 0 ) {
      
      lost.articles[, .N, Artikelname][N > 1] # ACHTUNG
            # lost.articles[Artikelname %in% lost.articles[, .N, Artikelname][N > 1]$Artikelname]
            # data[GTIN %in% lost.articles[Artikelname %in% lost.articles[, .N, Artikelname][N > 1]$Artikelname]$GTIN]
      cat("", bgMagenta("[DEBUG]"), " - You have duplicate in lost.articles - please browser()")
      browser()
    }
     
    
     
    if( nrow(lost.articles[, .N, Artikelnummer][N > 1]) > 0 ) {
      
      lost.articles[, .N, Artikelnummer][N > 1] # ACHTUNG
            # lost.articles[Artikelnummer %in% lost.articles[, .N, Artikelnummer][N > 1]$Artikelnummer][order(Artikelnummer)]
      cat("", bgMagenta("[DEBUG]"), " - You have duplicate in lost.articles - please browser()")
      browser()
    }
    
      
    lost.articlesV <- unique(lost.articlesV)
    
      
        
    if( nrow(lost.articlesV[, .N, Artikelname][N > 1]) > 0 ) {
      
      lost.articlesV[, .N, Artikelname][N > 1] # ACHTUNG
            # lost.articlesV[Artikelname %in% lost.articlesV[, .N, Artikelname][N > 1]$Artikelname[1]]
            # dput(lost.articlesV[Artikelname %in% lost.articlesV[, .N, Artikelname][N > 1]$Artikelname][order(Artikelname)]$Artikelnummer)
            # data[ArtikelnameV %in% lost.articlesV[, .N, Artikelname][N > 1]$Artikelname[1]][order(ArtikelnameV)]
      cat("", bgMagenta("[DEBUG]"), " - You have duplicate in lost.articles - please browser()")
      browser()
    }
    
     
    if( nrow(lost.articlesV[, .N, Artikelnummer][N > 1]) > 0 ) {
      
      lost.articlesV[, .N, Artikelnummer][N > 1]
          # lost.articlesV[Artikelnummer %in% lost.articlesV[, .N, Artikelnummer][N > 1]$Artikelnummer[1]]
          # data[VID %in% dataV[, .N, Artikelnummer][N > 1]$Artikelnummer][order(Artikelnummer)]
          # data[VID %in% dataV[, .N, Artikelnummer][N > 1]$Artikelnummer[1]][order(Artikelnummer)]
      cat("", bgMagenta("[DEBUG]"), " - You have duplicate in lost.articles - please browser()")
      browser()
    }
    
    .dbK[, Keep.VaterID := F]
    
    .dbK2 <- copy(.dbK)
    setnames(.dbK2, "Artikelnummer.db", "Artikelnummer")
    remove.single.article(.dataV = lost.articlesV, .dataK = lost.articles, DATA = .dbK2)

    clean.info.nummer.name.Maxi(lost.articles)
    
    lost.articlesall <- rbind(lost.articlesV, lost.articles, fill=T)
    
    maxi.check(lost.articlesall, dont.check.1.variation = F)

    replace.col.names.maxi(lost.articlesall)
    
    
  }
  
  
  
  
  
  cat("", yellow("[INFO]"), " - If you delete those Vaters:\n")
  cat("---------------------------------------\n")
  a <- nrow(d.GTIN)
  cat("\t- ", ifelse(a == 0 , bgGreen(black( a)), bgRed(a)), "articles will be definitively deleted (not in import)\t", silver("d.GTIN\n"))
  cat("\t\tTO IMPORT THEM - use ", blue("Ameise.import.lost.articles(DB = which.db, DATA = lost.articles)\n"))
  a <- nrow(.dbK[Lager != 0 & VID %in% yourvector][!GTIN %in% DATA$GTIN])
  cat("\t\t> ", ifelse(a == 0 , bgGreen(black( a)), bgRed(a)), "in lager\t", silver("d.GTIN[Lager != 0]\n"))
  a <- nrow(d.pro)
  cat("\t- ", ifelse(a == 0 , bgGreen(black( a)), bgRed(a)), "articles in lager or Auftrag will be delete ---> keep track\t", silver("d.pro"), " or ", silver("d.pro2\n"))
  if( exists("new.prices") ) {
    a <- nrow(d.pri)
    cat("\t- ", ifelse(a == 0 , bgGreen(black( a)), bgRed(a)), "articles have new prices !!!!  ---> keep track\t", silver("d.pri\n"))
  }
  
  cat("\nRobject d.rename created if you wanna update Vaternames with -todelete in order to delete them easily\n\n\n")
  
  assign("d.GTIN", d.GTIN, env = .GlobalEnv)
  if(exists("lost.articlesall") ) {
    assign("lost.articles", lost.articlesall, env = .GlobalEnv)
  } else {
    assign("lost.articles", lost.articles, env = .GlobalEnv)
  }
  assign("d.pro", d.pro, env = .GlobalEnv)
  assign("d.pro2", d.pro2, env = .GlobalEnv)
  assign("d.rename", d.rename, env = .GlobalEnv)
  if( exists("new.prices") ) {
    assign("d.pri", d.pri, env = .GlobalEnv)
  }
  
  # debug.easy(nrow(lost.articles[`Variationswert 1` == "None"]) > 0, "You have article with wrong found Varia, check\tlost.articles[`Variationswert 1` == 'None'] ")
  
  # cat("\twrite.csv.wawi(d.rename, datapath = p0(rootpath, '/Firmen_Listen_EAN/Import/yourname_todelete-vater.csv'")
  cat(red('Respect the order:\n'))
  cat('\tAmeise.import.todelete(DB = "test", data = d.rename)\n')
  cat(blue('\tDelete them in Wawi\n'))
  cat("\tAmeise.import.code function\n")
  cat(blue("\tRun the Ameise_bat file\n"))
  cat("\tAmeise.import.lost.articles(DB = which.db, data = lost.articles)\n")
  cat('\tAmeise.import.lager(DB = "test", data = d.pro2)\n')
}

delete.Kinder <- function(yourvector, .dbK = dbK, DATA = data) {
  
  
  if(!exists(".dbK")) {
    stop("\n", bgMagenta("[DEBUG]"), " - You need to use the function read.DB.ameise to get Robject from the actual db\n")
  }
  if(!exists("data")) {
    stop("\n", bgMagenta("[DEBUG]"), " - You need the data from import with the GTIN field\n")
  }
  if(!"GTIN" %in% names(DATA)) {
    stop("\n", bgMagenta("[DEBUG]"), " - You need GTIN field in your data table\n")
  }
  if( any(nchar(yourvector) != 13) ) {
    stop("\n", bgMagenta("[DEBUG]"), " - Some of your GTIN does not have 13 characters ...\n")
  }
  
  
  d.GTIN <- .dbK[GTIN %in% yourvector][!GTIN %in% DATA$GTIN] # will be delete definitively
  d.pro <- .dbK[Lager != 0 &GTIN %in% yourvector] # could delete lager or auftrag article !!!!
  d.pro2 <- d.pro[, .(GTIN, Lagerbestand = Lager)]
  d.rename <- .dbK[GTIN %in% yourvector][, .(GTIN, Artikelname)]
  d.rename[, Artikelname := p0(Artikelname, "-todelete")]
  if( exists("new.prices") ) { d.pri <- .dbK[GTIN %in% check & GTIN %in% new.prices$GTIN] }
  
  cat("", yellow("[INFO]"), " - If you delete those Kinders:\n")
  cat("---------------------------------------\n")
  cat("\t- ", nrow(d.GTIN), "articles will be definitively deleted (not in import)\t\td.GTIN\n")
  cat("\t\t> ", nrow(.dbK[Lager != 0 & VID %in% yourvector][!GTIN %in% DATA$GTIN]), "in lager\t\tdbK.lager[!GTIN %in% data$GTIN]\n")
  cat("\t- ", nrow(d.pro), "articles in lager or Auftrag will be delete ---> keep track\t\td.pro or d.pro2\n")
  if( exists("new.prices") ) { cat("\t- ", nrow(d.pri), "articles have new prices !!!!  ---> keep track\t\td.pri\n") }
  
  cat("\nRobject d.rename created if you wanna update Vaternames with -todelete in order to delete them easily\n\n\n")
  
  assign("d.GTIN", d.GTIN, env = .GlobalEnv)
  assign("d.pro", d.pro, env = .GlobalEnv)
  assign("d.pro2", d.pro2, env = .GlobalEnv)
  assign("d.rename", d.rename, env = .GlobalEnv)
  if( exists("new.prices") ) { assign("d.pri", d.pri, env = .GlobalEnv) }
  
  
  # write.csv.wawi(d.rename, datapath = p0(rootpath, "/Firmen_Listen_EAN/Import/", gettimestamp(), "_", Firma, "_todelete-kinder.csv"))
  cat('\tAmeise.import.todelete(DB = "test", data = d.rename)\n')
  cat('\tAmeise.import.lager(DB = "test", data = d.pro2)\n')
  
  
  
}






# Pictures ----------------------------------------------------------------

download.pic <- function(DATA, filename = "col.name", ext2 = "ext", url = "col.name", filepath) {
  
  n <- nrow(DATA)
  dirwin <- p0(dirname(gsub("file:///", "", filepath)), "/Download.bat")
  # dirwin <- p0(dirname(gsub("file:///", "", filepath)), "/list_temp_curl")
  lect <- substr(dirwin, 1, 2)
  
  # curl list
  DATA <- DATA[get(url) != ""]
  DATA <- u(DATA)
  DATA[, c(url) := gsub("%", "%%", get(url))]
  DATA[, c(ext2) := gsub("\\.\\.", ".", p0(".", get(ext2)))]
  DATA[, filename1 := p0('"', get(filename), get(ext2), '"')]
  DATA[, filename2 := p0('"', get(filename), "_temp", get(ext2), '"')]
  DATA[, row := 1:nrow(DATA)]
  DATA[, code := p0('curl --silent -L -o ', filename1, ' "', get(url), '"')]
  # DATA[ext %like% "jpg", code2 := p0('rename ', filename1, ' ', filename2, ' && magick convert ', filename2, ' -resize 600^> -background white -flatten ', filename1, ' && del ', filename2)]
  # DATA[!ext %like% "jpg", code2 := p0('magick convert ', filename1, ' -resize 600^> -background white -flatten ', filename1)]
  # DATA[, code2 := p0(code2, " && echo ", row, "/", nrow(DATA))]
  DATA[, code2 := p0("echo ", row, "/", nrow(DATA))]
  
  
  writeLines(c("@echo OFF\n", rbind(DATA$code, DATA$code2)), dirwin)
  
  
  # progressbar
  # writeLines(c(lect, 
  #              p0("\ncd ", gsub("\\/", "\\\\", dirname(dirwin))), 
  #              p0("\n@echo off\nsetlocal EnableDelayedExpansion\nset n=", n),
  #              '\nset /a lengthbar=100\nset "bar="\nfor /L %%i in (1,1,%lengthbar%) do set "bar=!bar!O"\nset "space="\nfor /L %%i in (1,1,%lengthbar%) do set "space=!space!-"\nset i=0\nfor /F "tokens=*" %%c in (list_temp_curl) do (\n\techo %%c\n\tset /A i+=1, percent=!i!*%lengthbar%/!n!\n\tfor %%a in (!percent!) do (\n\t\tset bar2=!bar:~0,%%a!\n\t\tset /a left=%lengthbar%-%%a\n\t\tfor %%b in (!left!) do (\n\t\t\tset space2=!space:~-%%b!\n\t\t\ttitle !i! / !n!  -  %%a %%  -  !bar2!!space2!\n\t\t)\n\t)\n)\n'), filepath)
  
  
}

create.html.picture.table <- function(data,
                                      Artikelname = "Artikelnr.+Artikelbezeichnung",
                                      Colour = "Farbe",
                                      GTIN = "GTIN",
                                      id.bild = "id.bild",
                                      filepath = "filepath",
                                      filename = p0(importpath, "test.html"),
                                      color.bg = "#313130",
                                      color.line = "#b4bac4",
                                      color.text = "#b4bac4",
                                      font.size = "11px",
                                      font.family = "Calibri",
                                      text.align = "center",
                                      height.bild = 100
                                      ) {
  
  cat("", yellow("[INFO]"), " - You can use variable tokeep 1 or 0 to check which bild you wanna use or not\n\n")
  
  DATA <- copy(data)
  
  
  
  if( "tokeep" %in% names(DATA) ) {
    DATA[tokeep == 0, filepath2 := p0('<a href="', filepath, '"><img class="tokeep0" src="', filepath, '" onclick="copyURI(event)" height = ', height.bild, ' /></a>')]
    DATA[tokeep != 0, filepath2 := p0('<a href="', filepath, '"><img src="', filepath, '" onclick="copyURI(event)" height = ', height.bild, ' /></a>')]
  } else {
    DATA[, filepath2 := p0('<a href="', filepath, '"><img src="', filepath, '" onclick="copyURI(event)" height = ', height.bild, ' /></a>')]
  }
  
  if( GTIN == "" ) {
    if( Colour == "" ) {
      form <- p0(Artikelname, "~", id.bild)
    } else {
      form <- p0(Artikelname, "+", Colour, "~", id.bild)
    }
  } else {
    form <- p0(Artikelname, "+", Colour, "+", GTIN, "~", id.bild)
  }
  
  temp <- dcast.data.table(DATA, as.formula(form), value.var = "filepath2")
  
  setcolorder(temp,  c(grepcol("Bild", temp, rev = T),  p0("Bild.", 1:length(grepcol("Bild", temp)), ".Pfad__URL")))
 
  
  tabhtml <- tableHTML(temp,
                       rownames = FALSE) %>%
    add_css_table(css = list('border', color.line)) %>%
    add_css_table(css = list('text-align', text.align)) %>%
    add_css_table(css = list('font-family', font.family)) %>%
    add_css_table(css = list('font-size', font.size)) %>%
    add_css_table(css = list('color', color.text))
  
  write_tableHTML(tabhtml, filename)
  
  temp <- suppressWarnings(readLines(filename))
  temp <- gsub( "&#62;", ">", temp)
  temp <-  gsub( "&#60;", "<", temp)
  temp <- c("<style>.tokeep0 {  border: 10px solid #FF4500; } </style>", temp)
  temp <- c("<script> function copyURI(evt) {		evt.preventDefault();		text = evt.target.getAttribute('src');		text = text.replaceAll('/', '\\\\');		navigator.clipboard.writeText(text).then(() => {		  console.log('Success copy');		  console.log(text)		}, () => {		  console.log('Failed copy')		})}</script>",  temp)
  temp <- c("<body bgcolor='", color.bg, "'>", temp)
  
  writeLines(temp, filename)
  
  
}

create.html.picture.table.general <- function(DATA,
                                              x,
                                              y,
                                              value.var,
                                              filename = getwd(),
                                              height = 150,
                                              color.bg = "#313130",
                                              color.line = "#b4bac4",
                                              color.text = "#b4bac4",
                                              font.size = "11px",
                                              font.family = "Calibri",
                                              text.align = "center",
                                              nrow.per.file = "") {
  
  DATA[, filepath2 := p0('<a href="', get(value.var), '"><img src="', get(value.var), '" onclick="copyURI(event)" height = ', height, ' /></a>')]
  
  form <- p0(x, "~", y)
  
  temp <- dcast.data.table(DATA, as.formula(form), value.var = "filepath2")

  
  if( nrow.per.file != "") {
    seqdata <- seq(1, nrow(temp), nrow.per.file)
    filename <- gsub(".html$", "", filename)
    tempfile <- p0(dirname(filename), "temp.html")
      
      for (i in seqdata) {
        j <- which(seqdata == i)
        print(i)
        print(j)
        tabhtml <- tableHTML(temp[i:(i+(nrow.per.file-1))],
                             rownames = FALSE) %>%
          add_css_table(css = list('border', color.line)) %>%
          add_css_table(css = list('text-align', text.align)) %>%
          add_css_table(css = list('font-family', font.family)) %>%
          add_css_table(css = list('font-size', font.size)) %>%
          add_css_table(css = list('color', color.text))
        
        
        write_tableHTML(tabhtml, tempfile)
        
        temp2 <- suppressWarnings(readLines(tempfile))
        temp2 <- gsub( "&#62;", ">", temp2)
        temp2 <- gsub( "&#60;", "<", temp2)
        temp2 <- c("<script> function copyURI(evt) {		evt.preventDefault();		text = evt.target.getAttribute('src');		text = text.replaceAll('/', '\\\\');		navigator.clipboard.writeText(text).then(() => {		  console.log('Success copy');		  console.log(text)		}, () => {		  console.log('Failed copy')		})}</script>",  temp2)
        temp2 <- c("<body bgcolor='", color.bg, "'>", temp2)
        
        writeLines(temp2, p0(filename,"_", nrow.per.file, "_", j, ".html"))
      }
  
  } else {
    
    tabhtml <- tableHTML(temp,
                         rownames = FALSE) %>%
      add_css_table(css = list('border', color.line)) %>%
      add_css_table(css = list('text-align', text.align)) %>%
      add_css_table(css = list('font-family', font.family)) %>%
      add_css_table(css = list('font-size', font.size)) %>%
      add_css_table(css = list('color', color.text))
    
    write_tableHTML(tabhtml, filename)
    
    temp <- suppressWarnings(readLines(filename))
    temp <- gsub( "&#62;", ">", temp)
    temp <-  gsub( "&#60;", "<", temp)
    temp <- c("<body bgcolor='", color.bg, "'>", temp)
    temp <- c("<script> function copyURI(evt) {		evt.preventDefault();		text = evt.target.getAttribute('src');		text = text.replaceAll('/', '\\\\');		navigator.clipboard.writeText(text).then(() => {		  console.log('Success copy');		  console.log(text)		}, () => {		  console.log('Failed copy')		})}</script>",  temp)
    
    writeLines(temp, filename)
  }
  
}


create.html.picture.table.VATER <- function(data,
                                      filename = p0(importpath, "test.html"),
                                      color.bg = "#313130",
                                      color.line = "#b4bac4",
                                      color.text = "#b4bac4",
                                      font.size = "11px",
                                      font.family = "Calibri",
                                      text.align = "center") {
  
  DATA <- copy(data)
  
  listcol <- grepcol("Bild", DATA)
  for(i in seq_along(listcol)) {
    DATA[!is.na(get(listcol[i])), (listcol[i]) := p0('<a href="', get(listcol[i]), '"><img src="', get(listcol[i]), '" onclick="copyURI(event)" height = 150/></a>')]
  }
  
  
  tabhtml <- tableHTML(DATA,
                       rownames = FALSE) %>%
    add_css_table(css = list('border', color.line)) %>%
    add_css_table(css = list('text-align', text.align)) %>%
    add_css_table(css = list('font-family', font.family)) %>%
    add_css_table(css = list('font-size', font.size)) %>%
    add_css_table(css = list('color', color.text))
  
  write_tableHTML(tabhtml, filename)
  
  temp <- suppressWarnings(readLines(filename))
  temp <- gsub( "&#62;", ">", temp)
  temp <-  gsub( "&#60;", "<", temp)
  temp <- c("<script> function copyURI(evt) {		evt.preventDefault();		text = evt.target.getAttribute('src');		text = text.replaceAll('/', '\\\\');		navigator.clipboard.writeText(text).then(() => {		  console.log('Success copy');		  console.log(text)		}, () => {		  console.log('Failed copy')		})}</script>",  temp)
  temp <- c("<body bgcolor='", color.bg, "'>", temp)
  
  writeLines(temp, filename)
  
  
}


replace.occurence <- function(x, pattern, replacement, which.occu) {
  if( which.occu == "last" ) {
    gsub(paste0("(.*", pattern, ".*)", pattern, "(.*)"), paste0("\\1", replacement, "\\2"), x)
  } else {
    gsub(paste0("(.*?", paste0(rep(paste0(pattern, ".*?"), which.occu - 1), collapse = ""), ")", pattern, "(.*)"), paste0("\\1", replacement, "\\2"), x)
  }
}

remove.identical.img <- function(DATA, main.image, other.images) {
  require(magick)
  for(i in 1:nrow(DATA)){
    for(j in seq_along(other.images)) {
      if(!any( DATA[i, get(other.images[j])] == "", is.na(DATA[i, get(other.images[j])]), DATA[i, get(other.images[j])] == "NA")) {
        cat("attributes(image_compare(image_read(DATA[", i, ", get('", main.image, "')]), image_read(DATA[", i, ", get('", other.images[j], "')])))$distortion)\n")
        tryCatch({
          diff <- attributes(image_compare(image_read(DATA[i, get(main.image)]), image_read(DATA[i, get(other.images[j])]) ))$distortion
          }, error=function(e) {
            # do nothing 
          })
        
        if( diff > 0.8 ) {
          # DATA[i, get(other.images[j])]
          DATA[i, c(other.images[j]) := ""]
        }
      }
    }
  }
}


prepare.bilder.import <- function(DATA, color.name, new.name, 
                                  letzte.einkauf.file = "20230609-1651_Export___letzte-einkauf.csv",
                                  # rm.identical.Vater.loop = 0,
                                  rev.order = F,
                                  custom.order = "",
                                  n.bild.to.keep = 4) {
    
    # prepare Info data
        cat("\n", yellow("[INFO]"), " - Your data have :\n")
        
        info <- data.table(filepath = c("NA", "Exist", "NA", "Exist"),
        Lager = c("0", "Exist", "Exist", "0"),
        nrow = c(nrow(DATA[is.na(filepath) & Lager == 0]),
              nrow(DATA[!is.na(filepath) & Lager != 0]),
              nrow(DATA[is.na(filepath) & Lager != 0]),
              nrow(DATA[!is.na(filepath) & Lager == 0])))
        print(kable(info[order(Lager, filepath)]))
    
    # Prepare data
        DATA <- DATA[!is.na(filepath)]
        debug.easy(nrow(DATA) == 0, "You have no GTIN linked with path check .....")
        
        if( rev.order ) {
           if( custom.order !=  "" ) {
            setorderv(DATA, c(custom.order, -"filepath"))
          } else {
            setorder(DATA, -filepath)
          }
        } else {
          if( custom.order !=  "" ) {
            setorderv(DATA, c(custom.order, "filepath"))
          } else {
            setorder(DATA, filepath)
          }
        }
        DATA[, id.bild := 1:.N, GTIN] # renumber id.bild
    
    # Check letzte einkauf to avoid to have to many bilders
        le <- read.csv.wawi(p0(exportpath, letzte.einkauf.file), warn = F)
        format.GTIN(le, "GTIN")
        
        DATA[, tokeep := 0]
        DATA[GTIN %in% le$GTIN, tokeep :=1]
        DATA[ VID %in% DATA[GTIN %in% le$GTIN & VID != ""]$VID, tokeep := 1]
        DATA[as.numeric(id.bild) > n.bild.to.keep, tokeep := 0]
        DATA[as.numeric(id.bild) == 1, tokeep := 1]
        DATA <- DATA[!is.na(filepath)]
    
    # Create html amd export data
        # DATA2 <- u(DATA[, .(VID,Artikelnummer.db, Artikelname, GTIN, id.bild, filepath, tokeep)])
        DATA[, id.bild := p0("Bild.", id.bild, ".Pfad__URL")]
        setorder(DATA, "Artikelname")
        
        bildK <- DATA[tokeep == 1]$filepath

        
        cat("\n\n\n")
        # GTIN
        if( nrow(DATA[, .N, .(GTIN, id.bild)][N>1]) > 0 ) {
          cat("-----------------------------------------------------------------------------------------------------------------------------------------------------")
          cat("\n[INFO - DEBUG] - You have duplicates rows with GTIN and bild, This is a no GO, find a solution\n\n")
          cat("\nDATA[GTIN %in% DATA[, .N, .(GTIN, id.bild)][N>1]$GTIN][order(GTIN, id.bild)]\n\n")
          print(DATA[GTIN %in% DATA[, .N, .(GTIN, id.bild)][N>1]$GTIN][order(GTIN, id.bild)])
          stop()
        } else {
          tryCatch({
            capture.output(create.html.picture.table(DATA,
                        Artikelname = "Artikelnummer.db",
                        Colour = "Artikelname",
                        GTIN = "GTIN",
                        id.bild = "id.bild",
                        filepath = "filepath",
                        filename =  p0(importpath, new.name, "_Bilder_Kinder.html")), file = "NUL")
          }, error=function(e) {
            capture.output(create.html.picture.table(DATA,
                        Artikelname = "Artikelnummer.db",
                        Colour = "Artikelname",
                        GTIN = "GTIN",
                        id.bild = "id.bild",
                        filepath = "filepath",
                        filename =  p0(importpath, new.name, "_Bilder_Kinder.html")), file = "NUL")
          })
          
          
          # DATAcolor color only
          DATAcolor <- DATA[VID != "", .N, c("VID", color.name, "filepath", "id.bild")][, N := NULL]
          DATAcolor[, .N, .(VID, var3, id.bild)][N > 1]
          
          if(nrow( DATAcolor[, .N, .(VID, var3, id.bild)][N > 1] ) != 0 ) {
            cat(bgRed("\nRemoved"), bgBlue(nrow(DATAcolor[, .N, .(VID, var3, id.bild)][N > 1])), bgRed("rows for Bilder_Kinder__COLOR.html\n\n"))
            DATAcolor <- DATAcolor[ !VID %in% DATAcolor[, .N, .(VID, var3, id.bild)][N > 1]$VID] # remove problematic ones if nrow < 5
          } 
          
          DATAcolor <- dcast.data.table(DATAcolor, as.formula(p0("VID+", color.name, "~id.bild")), value.var = "filepath")
          names(DATAcolor)
          setcolorder(DATAcolor, c("VID", color.name, p0("Bild.", 1:(ncol(DATAcolor)-2), ".Pfad__URL")))
          
          tryCatch({
            capture.output(create.html.picture.table.VATER(DATAcolor, p0(importpath, new.name, "_Bilder_Kinder__COLOR.html") ), file = "NUL")
          }, error=function(e) {
            capture.output(create.html.picture.table.VATER(DATAcolor, p0(importpath, new.name, "_Bilder_Kinder__COLOR.html") ), file = "NUL")
          })
          
          
          # __Letzte-Eink html 
          if( nrow( DATA[GTIN %in% le$GTIN] ) > 0 ) {
            tryCatch({
              capture.output(create.html.picture.table(DATA[GTIN %in% le$GTIN],
                                                       Artikelname = "Artikelnummer.db",
                                                       Colour = "Artikelname",
                                                       GTIN = "GTIN",
                                                       id.bild = "id.bild",
                                                       filepath = "filepath",
                                                       filename =  p0(importpath, new.name, "_Bilder_Kinder__Letzte-Eink.html")), file = "NUL")
            }, error=function(e) {
              capture.output(create.html.picture.table(DATA[GTIN %in% le$GTIN],
                                                       Artikelname = "Artikelnummer.db",
                                                       Colour = "Artikelname",
                                                       GTIN = "GTIN",
                                                       id.bild = "id.bild",
                                                       filepath = "filepath",
                                                       filename =  p0(importpath, new.name, "_Bilder_Kinder__Letzte-Eink.html")), file = "NUL")
            })
          }
          
          
          
          
          
          
            # export data
            ff6 <- dcast.data.table(DATA[tokeep == 1], VID+GTIN~id.bild, value.var = "filepath")
            # setnames(ff6, "GTIN", "GTIN/Barcode")
            setnames(ff6, "VID", "VID2")
            
            lc <- p0("Bild.", 1:4, ".Pfad__URL")
            for(i in seq_along(lc)) {
              if(!lc[i] %in% names(ff6)) {
                ff6[, c(lc[i]) := NA]
              }
            }
            rename.col.names.maxi(ff6)
            
            # export Kinder data
            tryCatch({
              capture.output(write.csv.wawi(ff6, p0(importpath, new.name, "_Bilder_Kinder.csv")), file = "NUL")
            }, error=function(e) {
              capture.output(write.csv.wawi(ff6, p0(importpath, new.name, "_Bilder_Kinder.csv")), file = "NUL")
            })
            if( !grepl("IN-SHOP___NO-BILDER", new.name) ) {
              tryCatch({
                capture.output(write.csv.wawi(ff6, p0(rP("file:///C:/Users/dorian.BSPM/Desktop/BILDER_path_BU_Wawi/Kinder/"), new.name, "_Bilder_Kinder.csv")), file = "NUL")
              }, error=function(e) {
                capture.output(write.csv.wawi(ff6, p0(rP("file:///C:/Users/dorian.BSPM/Desktop/BILDER_path_BU_Wawi/Kinder/"), new.name, "_Bilder_Kinder.csv")), file = "NUL")
              })
            }
            
            cat(green("\n[SUCCESS]")," - Html Kinder")
        }
        
        
    # Vater
        ff6V <- DATA[tokeep == 1][id.bild == "Bild.1.Pfad__URL" & VID != "", .N, c("VID", color.name, "filepath")]
        ff6V
        bildV <- ff6V$filepath
        ff6V <- ff6V[, .(filepath = .SD[1,filepath], N = .N),  c("VID", color.name)]
        ff6V <- u(ff6V)
        ff6V[, id.bild := 1:.N, VID]
        
        # if( nrow(ff6V[N > 1]) > 0 ) {
        #     cat("\n[Failed] - Vater : You have duplicates rows with Artikelnummer / VaterID, color and bild, ou may need to find a better color column, you may have problem with Vater\n\n")
        # } else {
            ff6V1 <- ff6V[id.bild < 10]
            # ff6V1[, md5 := md5(filepath)]
            ff6V1[, md5 := tools::md5sum(filepath)] # check if similar pictures
            # dupli <- ff6V1[, .N, .(VID, md5)][N > 1]
            # ff6V1[md5 %in% dupli$md5]
            ff6V1 <- unique(ff6V1, by=c("VID", "md5"))
            ff6V1[, id.bild := 1:.N, VID]
            
            ff6V2 <- dcast.data.table(ff6V1, VID~id.bild, value.var = "filepath")
            ff6V2
            coln <- 1:length(grepcol("VID", ff6V2, rev = T))
            coln
            setnames(ff6V2, p0(coln), p0("Bild.", coln, ".Pfad__URL"))
            setnames(ff6V2, "VID", "Artikelnummer")
            ff6V2
            
            # # old code
            # if( rm.identical.Vater.loop != 0 ) {
            #   for(i in 1:rm.identical.Vater.loop) {
            #     main.i <- p0("Bild.", i, ".Pfad__URL")
            #     other.i <- grep.return(main.i,grepcol("Bild", ff6V2), invert = T)
            #     remove.identical.img(ff6V2, main.image = main.i, other.images = other.i)
            #   }
            # }
            

            tryCatch({
              capture.output(create.html.picture.table.VATER(ff6V2, p0(importpath, new.name, "_Bilder_Vater.html") ), file = "NUL")
            }, error=function(e) {
              capture.output(create.html.picture.table.VATER(ff6V2, p0(importpath, new.name, "_Bilder_Vater.html") ), file = "NUL")
            })
           
            
            
            rename.col.names.maxi(ff6V2)
            
            tryCatch({
              capture.output(write.csv.wawi(ff6V2, p0(importpath, new.name, "_Bilder_Vater.csv")), file = "NUL")
            }, error=function(e) {
              capture.output(write.csv.wawi(ff6V2, p0(importpath, new.name, "_Bilder_Vater.csv")), file = "NUL")
            })
            if( !grepl("IN-SHOP___NO-BILDER", new.name) ) {
              tryCatch({
                capture.output(write.csv.wawi(ff6V2, p0(rP("file:///C:/Users/dorian.BSPM/Desktop/BILDER_path_BU_Wawi/Vater/"), new.name, "_Bilder_Vater.csv")), file = "NUL")
              }, error=function(e) {
                capture.output(write.csv.wawi(ff6V2, p0(rP("file:///C:/Users/dorian.BSPM/Desktop/BILDER_path_BU_Wawi/Vater/"), new.name, "_Bilder_Vater.csv")), file = "NUL")
              })
            }
            
            
            cat(green("\n[SUCCESS]")," - Html Vater")
        # }
            
            code <- code.ameise(DB. = "offi", vorlage = "IMP38", inputfile = p0(importpath, new.name, "_Bilder_Vater.csv"), log.suffix = "Bilder_Vater", log.path = importpath, call.check = F, title.cmd = T)
            code
            code <- c(code, code.ameise(DB. = "offi", vorlage = "IMP39", inputfile = p0(importpath, new.name, "_Bilder_Kinder.csv"), log.suffix = "Bilder_Kinder", log.path = importpath, call.check = F, title.cmd = F))
            code <- c(code, "pause")
            writeLines(code, p0(importpath, "/",  new.name, "_offi_Bilder.bat"))
            cat("\n\n", yellow("[INFO]"), " - You need to open", blue(p0(importpath, "/",  new.name, "_offi_Bilder.bat")), "your self !!!!\n")

            cat("\n\n", yellow("[INFO]"), " - calculate file size ...")
            bild.all <- round(sum(file.info(unique(c(bildK, bildV)))$size, na.rm = T)/1000/1000,0)
            cat("\n\n", yellow("[INFO]"), " - Size all unique bilder imported = ", red(bild.all), "Mb\n")
                            
            

}

read.gpx <-  function(input, type = "wpt") {
  
  require(xml2)
  # Read the GPX file
  gpx_file <- read_xml(input)
  ns <- xml_ns(gpx_file)

  # Extract waypoints (or other elements like tracks)
  waypoints <- xml_find_all(gpx_file, p0(".//d1:", type), ns = ns)
  
  if( type == "wpt") {
    # Extract attributes (latitude and longitude)
    data <- data.table(lat = as.numeric(xml_attr(waypoints, "lat")),
                       lon = as.numeric(xml_attr(waypoints, "lon")),
                       name = xml_find_all(waypoints, "d1:name", ns = ns) %>% xml_text())
    lpara <- c("url", "des")
    for(j in seq_along(lpara)) {
      if( length(xml_find_all(waypoints, p0("d1:", lpara[j]), ns = ns)) > 0 ) {
        data[, lpara[j] := xml_find_all(waypoints, p0("d1:", lpara[j]), ns = ns) %>% xml_text()]
      }
    }
  }
  if( type == "trk" ) {
    data <- data.table()
    for( i in 1:length(waypoints)) {
      pts <- xml_find_all(waypoints[i], ".//d1:trkpt", ns = ns)
      # Extract attributes (latitude and longitude)
      temp <- data.table(lat = as.numeric(xml_attr(pts, "lat")),
                         lon = as.numeric(xml_attr(pts, "lon")),
                         name = xml_find_all(waypoints[i], ".//d1:name", ns=ns)%>% xml_text())
      lpara <- c("ele", "time")
      for(j in seq_along(lpara)) {
        if( length(xml_find_all(pts, p0(".//d1:", lpara[j]), ns = ns)) > 0 ) {
          temp[, lpara[j] := xml_find_all(pts, p0(".//d1:", lpara[j]), ns = ns) %>% xml_text()]
        }
      }
      data <- rbind(data, temp)
    }
  }
  
  return(data)
  
}


export.gpx <- function(DATA, filename, add.desc = T, add.url = T, layer.type = "waypoints") {
  
  # layer.type is waypoints or tracks
  
  
  
  debug.easy(!all(c("lat", "lon") %in% names(DATA)), "You need 'lat' and 'lon' variable." ) 
  
  if( layer.type == "tracks") {
    layer.type <- "track_points"
    DATA[,track_fid := 0] #Assign ID to tracks
    DATA[,track_seg_id := 0] #Assign_seg_id to segments of tracks
    DATA[, track_seg_point_id := (1:.N) - 1] #Assign point IDs, begin at zero and go in consecutive order. If data is not in order, it will need sorted first.
  }
  
  if( all( add.desc, add.url )) {
    DATA2 <- DATA[, .(name, desc, url)]
  } else if ( add.desc ) {
    DATA2 <- DATA[, .(name, desc)]
  } else if ( add.url ) {
    DATA2 <- DATA[, .(name, url)]
  } else if ( !all( add.desc, add.url ) ) {
    DATA2 <-  DATA
  }
  
  latslongs <- SpatialPointsDataFrame(coords = DATA[, .(lon, lat)],
                                          data = DATA2,
                                          proj4string = CRS("+proj=longlat + ellps=WGS84")) 
  
  
  suppressWarnings(writeOGR(latslongs, dsn=filename, dataset_options="GPX_USE_EXTENSIONS=yes",layer=layer.type, driver="GPX", overwrite_layer = T))
  
  DATA3 <- data.table(x = readLines(filename, encoding = "UTF8"))
  DATA3[grep("extensions>", x)]
  DATA3 <- DATA3[grep("extensions>", x, invert = T)]
  DATA3[, x := gsub("ogr:url", "url", x)]
  if ( add.url ) {
    DATA3[, x := gsub("  <url", "<url", x)]
  }
  write.table(DATA3$x, filename, quote = F, row.names = F, col.names = F)
  
}



png2mp4 <- function(filepath, time.s = 6, outpath = "D:/Pictures/GoPro/Map_bike") {
  
  temp <- getwd()
  setwd(outpath)
  
  
  system(p0('ffmpeg -y -stats -loglevel error -r "1/', time.s, '" -f image2 -i "', filepath, '" -vcodec libx264 -vf "fps=30,format=yuv420p" 0.mp4'))
  
  # dur <- system(p0("exiftool -b -TrackDuration 0.mp4"))
  # cat("duration:", dur)
  # dur2 <- as.numeric(dur)-2
  dur2 <- time.s-2

  system('ffmpeg -y -stats -loglevel error -f lavfi -i anullsrc=channel_layout=stereo:sample_rate=48000 -i 0.mp4 -c:v copy -c:a aac -shortest 1.mp4')
  system(p0('ffmpeg -y -stats -loglevel error -i 1.mp4 -vf "fade=t=in:st=0:d=2,fade=t=out:st=', dur2, ':d=2" -c:a copy -video_track_timescale 30000  "', substr(filepath, 1, nchar(filepath)-3), 'mp4"'))
  
  file.remove("0.mp4", "1.mp4")
  setwd(temp)
  
}















# RR12 --------------------------------------------------------------------

DecimalToToD <- function(x) {
  require(hms)
  hms::as_hms(x)
}

ToDToDecimal <- function(x) {
  period_to_seconds(lubridate::hms(x))
}

readRR12 <- function(APIrawdata, APItimes, APIresults, getrawdata = T) {
  
  # get data
  if( getrawdata ) {
    system(p0("curl -o rawdata.txt ", APIrawdata))
  } 
  system(p0("curl -o Times.csv ", APItimes))
  results <- data.table(jsonlite::fromJSON(url(APIresults), flatten = TRUE))
  
  rd <- data.table(jsonlite::fromJSON("rawdata.txt", flatten = TRUE))
  times <- data.table(read.csv("Times.csv"))
  
  # Manipulation      
  rd
  rd[, ToD := DecimalToToD(Time)]
  a <- ggplot(rd, aes(ToD))+geom_histogram()
  print(a)
  
  rd2 <- rd[, .(ID, Bib, TimingPoint, Time, ToD, Invalid, Passing.Hits, Passing.RSSI, Passing.DeviceID, Passing.DeviceName)]
  
  times[, Time := NULL]
  times[, InfoText := NULL]
  setnames(times, c("ï..Bib", "DecimalTime", "Result"), c("Bib", "Time", "ResultID"))
  times[, ToD := DecimalToToD(Time)]
  
  setnames(results, "ID", "ResultID")
  
  times2 <- dtjoin(times, results[, .(ResultID, Name)])
  
  assign("times", times2, env=.GlobalEnv)
  
  data <- dtjoin(rd2, times2[, .(Bib, ResultID, Time, Name)])
  data[, ToResult := 1]
  data[is.na(ResultID), ToResult := 0]
  data[, .N, .(Bib, ToResult)]
  data[, .N, ToResult]
  
  data[, LapID := as.numeric(gsub("(\\D*)(\\d*)", "\\2", Name))]
  data[, NameTP := gsub("(\\D*)(\\d*)", "\\1", Name)]
  
  return(data)
  
}
