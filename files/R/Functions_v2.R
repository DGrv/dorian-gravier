
library(reshape2)
# options(java.parameters = "-Xmx8000m") # default : options(java.parameters = "-Xmx1000m")
# to allow to write bigger xlsx files
# Whenever you are using a library that relies on rJava (such as RWeka in my case), you are bound to hit the default heap space (512 MB) some day. Now, when you are using Java, we all know the JVM argument to use (-Xmx2048m if you want 2 gigabytes of RAM). Here it's just a matter of how to specify it in the R environnement.
# options(java.parameters = "-Xmx2048m")
# library(rJava)
# Note that you need to specify the option before loading the library rJava (or the one relying on it like RWeka) since the JVM is going to be initialized at that moment.
library(rJava)
library(ggplot2)
library(fields) # for colors raster
library(gridExtra)
library(Rmisc)
# library(drc)
library(markdown) # required for md to html 
library(rmarkdown)
library(RMySQL)
library(knitr)
library(scales)
library(proto)
library(ggExtra)
library(data.table)
library(plyr) ### load at the end
library(dplyr) ### load at the end
library(stringr)
library(tableHTML)
library(XML)
library(zoo) # rollapply function
library(grid) # for theme_Emi_Publication
library(ggthemes) # for theme_Emi_Publication
library(crayon)
library(forcats)
# library(ETLUtils) # for sql query
library(RJDBC)
library(RMariaDB)
library(jpeg)
library(plotly)
library(GGally)
library(RColorBrewer)













# KEEP Functions_Wormulon_v4 are loading this script from line 50
# KEEP Functions_Wormulon_v4 are loading this script from line 50
# KEEP Functions_Wormulon_v4 are loading this script from line 50
# KEEP Functions_Wormulon_v4 are loading this script from line 50
# KEEP Functions_Wormulon_v4 are loading this script from line 50
# KEEP Functions_Wormulon_v4 are loading this script from line 50
# KEEP Functions_Wormulon_v4 are loading this script from line 50

# Theme ggplot ------------------------------------------------------------

theme_set(theme_bw())

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




# Small function ----------------------------------------------------------


Print.Bike <- function() {
  cat("\n\n")
  cat("                                           $'   *.\n")
  cat("               d$$$$$$$P'                  $    J\n")
  cat("                   ^$.                     4r  '\n")
  cat("                   d'b                    .dbv\n")
  cat("                  P   $                  e' $\n")
  cat("         ..ec.. .'     *.              zP   $.zec..\n")
  cat("     .^        3*b.     *.           .P' .@'4F      '4\n")
  cat("   .'         d'  ^b.    *c        .$'  d'   $         %\n")
  cat("  /          P      $.    'c      d'   @     3r         3\n")
  cat(" 4        .eE........$r===e$$$$eeP    J       *..        b\n")
  cat(" $       $$$$$       $   4$$$$$$$     F       d$$$.      4\n")
  cat(" $       $$$$$       $   4$$$$$$$     L       *$$$'      4\n")
  cat(" 4         '      ''3P ===$$$$$$'     3                  P\n")
  cat("  *                 $       '''        b                J\n")
  cat("   '.             .P                    %.             @\n")
  cat("     %.         z*'                      ^%.        .r'\n")
  cat("        '*==*''                             ^'*==*''   \n")
  cat("\n\n")
}

p0 <- function(...) {
  return(paste0(...))
}

p0rep <- function(vec1, vec2) {
  # paste0 of all combinaison between 2 vectors
  temp <- expand.grid(vec1, vec2)
  sprintf("%s%s", temp[,1], temp[,2])
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
  assign(newwd, file.path(wd,newdir), env = .GlobalEnv)
  setwd(get(newwd))
}

gettimestamp <- function(long=T) {
  if( long == T) {
    return(format(Sys.time(),"%Y%m%d-%H%M"))
  } else {
    return(format(Sys.time(),"%Y%m%d"))
  }
}

as.POSIXct.POSIXlt.all <- function (data)  {
  i <- sapply(data, class)
  i <- i %like% "POSIXlt"
  data[i] <- lapply(data[i], function(i) as.POSIXct(i))
  return(data)
}

as.numeric.factor.all <- function (data)  {
  i <- sapply(data, is.factor)
  data[i] <- lapply(data[i], function(i) as.numeric(levels(i))[i])
  return(data)
}


as.numeric.factor <- function (data)  {
  data <-as.numeric(levels(data))[data]
  return(data)
}

round.table <- function(data, digits) {
  
  if( any(class(data) %in% "data.table") ) {
    data2 <- copy(data)
    numcol <- names(data2)[sapply(data2, is.numeric)]
    data2[ , (numcol) := lapply(.SD, function(x) round(x, digits = digits)), .SDcols = numcol]
    return(data2)
  } else {
    if( any(class(data) %in% "data.frame") ) {
      # round all numeric variables
      # data: data frame 
      # digits: number of digits to round
      numcol <- sapply(data, class) == 'numeric'
      data[numcol] <-  round(data[numcol], digits = digits)
      return(data)
    }
  }
  
}

as.numeric.integer.all <- function (data)  {
  i <- sapply(data, is.integer)
  data[i] <- lapply(data[i], function(i) as.numeric(i))
  return(data)
}

as.numeric.integer <- function (data)  {
  data <- as.numeric(data)
  return(data)
}

as.character.factor.all <- function (data)  {
  i <- sapply(data, is.factor)
  data[i] <- lapply(data[i], function(i) as.character(levels(i))[i])
  return(data)
}

as.character.factor <- function (data)  {
  data <- as.character(levels(data))[data]
  return(data)
}

as.factor.character.all <- function (data)  {
  i <- sapply(data, is.character)
  data[i] <- lapply(data[i], function(i) as.factor(i))
  return(data)
}

as.factor.character <- function (data)  {
  data <- as.factor(data)
  return(data)
}


renamecol <- function(data, col1, col2) {
  for(i in seq(col1))
  {
    col <- which(colnames(data)==col1[i])
    colnames(data)[col] <- col2[i]
  }
  return(data)
}

comparecol <- function(df1, df2, assignlistmissing = F, assignlistextra = F) {
  
  setdiff(df1, df2) 
  
  if ( assignlistmissing == T ) {
    listmissing <- c(temp$x[which(is.na(temp$y) == T)],  temp$y[which(is.na(temp$x) == T)])
    assign("listmissing", listmissing, env = .GlobalEnv)
    cat("[INFO] - Robject 'listcolmissing' assigned.\n") 
  }
  
  if ( assignlistextra == T ) {
    assign("listextra", listextra, env = .GlobalEnv)
    cat("[INFO] - Robject 'listcolextra' assigned.\n") 
  }
  
  
}

write.xlsx.Dorian <- function (objects, names, title) {
  require(r2excel)
  
  wb <- createWorkbook()
  
  for (i in seq(objects))
  {
    sheet <- createSheet(wb, sheetName=paste0(names[i]))
    xlsx.addTable(wb, sheet, get(objects[i]), row.names =F,startCol=1)
  }
  
  saveWorkbook(wb, title)
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

printfast.grid <- function(list.graph, ncol = NA, title = "", height = 800, width = 800, wdfunction = getwd()){
  
  
  setwd(wdfunction)
  
  if(!is.na(ncol)) {
    ncol <- length(list.graph)
  }
  
  
  printfast(do.call(grid.arrange,
                    c(lapply(list.graph,
                             as.name),
                      list(ncol = ncol),
                      list(top=textGrob(title, gp=gpar(fontsize=20))))),
            paste0(title, ".jpg"),
            height = height,
            width= width,
            qualityprint = 100)
  
}

printfast.plotly <- function(plot, name, wdfunction = getwd(), selfcontained = F) {
  
  setwd(wdfunction)
  htmlwidgets::saveWidget(ggplotly(plot), p0(name, ".html"), selfcontained = selfcontained)
  
}




EquationLM <- function( formula,
                        data) {
  
  # > EquationLM(Time+85~Vol, temp)
  # [1] "y = 0.8x + 112.64, r2 = 0.99, n = 5"
  
  lmlm <- lm(formula, data = data)
  
  if( nrow(summary(lmlm)$coefficients) > 1 ) {
    
    a <- summary(lmlm)$coefficients[2, 1]
    b <- summary(lmlm)$coefficients[1, 1]
    
    equationlm  <- paste0("y = ",
                          round(a,2),
                          "x + ",
                          round(b,2), 
                          ", r2 = ", round(summary(lmlm)$adj.r.squared, 4),
                          ", n = ", nrow(data))
    
    assign("runlm", function (x=c(), y=c(), a = summary(lmlm)$coefficients[2, 1], b = summary(lmlm)$coefficients[1, 1]) {
      if(length(x) > 0) {     return(a*x+b)    } else {      return((y-b)/a)    }    }, env= .GlobalEnv)
    
    print(cat("\nFunction runlm() created. Use it as runlm(x=) or runlm(y=)."))
    
    return(equationlm)
    
  } else {
    cat("Dataset can not be used by lm.")
  }
  # add in a ggplot : a + annotate("text", x =Inf, y= Inf, hjust=3, vjust=2, label = EquationLM(Time2~Vol, temp) )
  
}

rollingSlope <- function(vector) {
  
  # lm is too slow, use .lm.fit instead. But special, works like this
  # .lm.fit(cbind(1, x), y)
  # you can extract a and b (in order b and a as output here)
  
  # This wuold be the lm version
  # lmlm <- lm(vector ~ seq(vector))
  # a <- summary(lmlm)$coefficients[2, 1]
  # or
  # coef(lmlm)[2]
  cat("\n[BECAREFUL] - Are you sure of the order for the rollingSlope.")
  
  a <- coef(.lm.fit(cbind(1, seq(vector)), vector))[2]
  return(a)
  
}






ColRowFactor <- function(data, reverse.row = F, reverse.col = F) {
  
  data <- data.table(data)
  if( reverse.row ) {
    data[, row := factor(row, levels = c(LETTERS[1:26],paste0("A",LETTERS[1:(32-26)])))]
  } else {
    data[, row := factor(row, levels = rev(c(LETTERS[1:26],paste0("A",LETTERS[1:(32-26)]))))]
  }
  if( reverse.col ) {
    data[, col := factor(col, levels = rev(c(1:48)))]
  } else {
    data[, col := factor(col, levels = c(1:48))]
  }
  return(data)
  
}

substrRight <- function(x, n){
  # substr character from the right, x is the vector, n the number of characters
  substr(x, nchar(x)-n+1, nchar(x))
}

WaitUserInput <- function(messa)
{
  # to wait input from user as enter or anything except Q
  cat (messa)
  line <- readline()
  return(line)
}

WaitEnter <- function()
{
  # to wait input from user as enter or anything except Q
  cat ("Press [enter] to continue. Type Q to quit.")
  line <- readline()
  if(line == "Q") stop()
}

WaitYesNo <- function() {
  # to wait input from user as enter or anything except Q
  cat ("You are sure to continue (y/n) ?")
  line <- readline()
  if (line == "y") {
  } else if (line == "n") {
    stop()
  }
}

ReadUserInput <- function (question) {
  question <- paste0("\n", question, "      ")
  cat(question)
  choice <- readLines("stdin", n=1)
  print(choice)
  return(choice)
}


addControl <- function(DATA, colpos = Poscon, colneg = Negcon, colcp=NA) {
  
  DATA[col %in% colpos, Control := "P"]
  DATA[col %in% colneg, Control := "N"]
  DATA[col %in% colcp, Control := "C"]
  return(DATA)
  
}


ReplaceInFiles <- function (path, patternfile, patterngsub, replacementgsub, preffix = NA) {
  
  setwd(path)
  listf <- list.files(path, patternfile, recursive = T)
  
  for(i in seq_along(listf)) {
    
    content <- readLines(listf[i])
    content <- gsub(patterngsub, replacementgsub, content)
    if( is.na(preffix) ) {
      writeLines(content, listf[i])
    } else {
      writeLines(content, paste0(preffix, listf[i]))
    }
    
  }
  
}

dtjoin <- function(x, y, type = "left") {
  
  if( !type %in% c("left", "inner", "right", "full", "semi", "anti")) {
    stop("[DEBUG] - Wrong type, please use : ", paste0(c("left", "inner", "right", "full", "semi", "anti"), collapse = ", "))
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

replace.NA.csv <- function(listcsv, pattern = "NA", replacement = "") {
  
  for(i in seq_along(listcsv)) {
    
    temp <- readLines(listcsv[i])
    temp <- gsub(pattern, replacement, temp)
    writeLines(temp, listcsv[i])
    
  }
  
  cat("\nNA replaced.\n")
}


leading0 <- function ( vect, digits ) {
  
  if( !is.numeric(vect) ){
    cat("[DEBUG] - Your vector should be numeric.")
  }
  
  vect <- sprintf(paste0("%0", digits, "d"), vect)
  return(vect)
  
}



extractXML <-function(xdata, expr, transpo = T){
  
  # expr should be "//*/Array"
  # cat("[INFO] - expr is an expression of the path usually something like '//*/Array'.")
  # cat("\n[INFO] - Use Transpo = F is you do not want to transpose the output. Just try it out.\n\n")
  
  dumFun <- function(x){
    xname <- xmlName(x)
    xattrs <- xmlAttrs(x)
    c(sapply(xmlChildren(x), xmlValue), name = xname, xattrs)
  }
  
  
  dum <- xmlParse(xdata)
  listxml <- xpathSApply(dum, expr, dumFun)
  
  if( transpo == T ) {
    data <- as.data.table(t(listxml), stringsAsFactors = FALSE)
  } else {
    data <- as.data.table(rbind.fill(lapply(listxml,function(y){as.data.frame(y,stringsAsFactors=F)})))
  }
  
  return(data)
  
}



write.html.link <- function(data,
                            filename,
                            caption = filename,
                            wdfunction,
                            color.bg = "#00000",
                            color.line = "#b4bac4",
                            color.text = "#b4bac4",
                            font.size = "11px",
                            font.family = "Calibri",
                            text.align = "center",
                            n.digi.round = 2, # 0 if not
                            brightness.slider = T,
                            colID.hmvalue, # numeric vector telling where the HM should be done
                            same.scale.hm # in combination with colID.hmvalue, define if you want the same scale for all data in hm or only per column
) {
  
  # permit to write a html table with a local link to click
  
  cat("To create a link add column in your data : <a href = 'file:///X:/Screening/...'>title link</a>\n")
  
  if( n.digi.round == 0 ) {
    rtable <- data
  } else {
    rtable <- round.table(data, n.digi.round)
  }
  
  tabhtml <- tableHTML(rtable,
                       rownames = FALSE,
                       caption = caption,
                       theme="default") %>%
    add_css_table(css = list('border', color.line)) %>%
    add_css_table(css = list('text-align', text.align)) %>%
    add_css_table(css = list('font-family', font.family)) %>%
    add_css_table(css = list('font-size', font.size)) %>%
    add_css_table(css = list('color', color.text))
  
  
  if( !missing(colID.hmvalue) ) {
    
    if( same.scale.hm ) { # same.scale.hm is to have all columns after the dcast with your formulaPV of the same scale
      
      datahm <- data.table()
      rtable2 <- rtable[1:(nrow(rtable) - 1)]
      
      for(i in seq_along(colID.hmvalue) ) {
        temp <- data.table(col = colID.hmvalue[i], value = rtable2[[colID.hmvalue[i]]])
        datahm <- rbind(datahm, temp)
      }
      
      datahm[, value := as.numeric(value)]
      datahm[, row := 1:.N, col]
      a <- ggplot(datahm ,aes(col, row))+
        geom_tile(aes(fill = value))+
        scale_fill_gradientn(colours=hmcolor)
      q <- ggplot_build(a)
      t <- data.table(q$data[[1]])
      
      
      for(i in seq_along(colID.hmvalue)) {
        temp <- list(a = round(datahm$value, 0))
        names(temp) <- names(rtable2)[colID.hmvalue[i]]
        
        colour.rank.css <- make_css_colour_rank_theme(temp,
                                                      colors = tim.colors(64))
        
        # colour.rank.css[[names(colour.rank.css)]][[2]][[1]] <- colour.rank.css[[names(colour.rank.css)]][[2]][[1]][grep(colID.hmvalue[i], datahm$col)]
        # The line above does not work properly, so I use ggplot to get the scale.
        colour.rank.css[[names(colour.rank.css)]][[2]][[1]] <- t[x==colID.hmvalue[i]]$fill
        colour.rank.css[[names(colour.rank.css)]][[2]][[1]] <- c(colour.rank.css[[names(colour.rank.css)]][[2]][[1]], "grey50")
        # browser()
        
        tabhtml <- tabhtml %>%
          add_css_conditional_column(colour_rank_css =  colour.rank.css, 
                                     columns = colID.hmvalue[i])
      }
    } else {
      for(i in seq_along(colID.hmvalue)) {
        temp <- list(a = rtable[[colID.hmvalue[i]]])
        names(temp) <- names(rtable)[colID.hmvalue[i]]
        colour.rank.css <- make_css_colour_rank_theme(temp,
                                                      colors = tim.colors(64))
        tabhtml <- tabhtml %>%
          add_css_conditional_column(colour_rank_css =  colour.rank.css,
                                     columns = colID.hmvalue[i],
                                     same_scale = TRUE,
                                     decreasing = FALSE)
      }
    }
    
    
    
    
    
    # # Error from the packages
    # # Error from the packages
    # # Error from the packages
    # # Error from the packages
    # # Error from the packages
    # listcss <- list()
    # for(i in seq_along(colID.hmvalue)) {
    #   temp <- list(a =rtable[[colID.hmvalue[i]]])
    #   names(temp) <- names(rtable)[colID.hmvalue[i]]
    #   listcss <- c(listcss, temp)
    # }
    # tabhtml <- tabhtml %>%
    #   add_css_conditional_column(colour_rank_css =  make_css_colour_rank_theme(listcss,
    #                                                                            colors = tim.colors(64)), 
    #                              columns = colID.hmvalue,
    #                              same_scale = TRUE,
    #                              decreasing = FALSE) %>% 
    
    
    tabhtml <- tabhtml %>% 
      add_css_column(columns = colID.hmvalue,
                     css = list('color', "black")) # change the font color of the hm cell in black
    
  }
  
  write_tableHTML(tabhtml, file = paste0(wdfunction, "/", filename, ".html"))
  temp <- suppressWarnings(readLines(paste0(wdfunction, "/", filename, ".html")))
  temp <- gsub( "&#62;", ">", temp)
  temp <-  gsub( "&#60;", "<", temp)
  temp <- c("<body bgcolor='", color.bg, "'>", temp)
  
  if( brightness.slider ) {
    # add brightness slider
    temp <- c("<div class='slidecontainer'>\n	<input type='range' min='-1000' max='4000' value='10' class='slider' id='myRange'>\n<p><font color='white'>Brightness (%): <span id='demo'></span></font></p>\n</div>\n\n<button onclick='reset()'>Reset</button><br><br>\n		\n<script>\n	function reset() {\n		var input = document.getElementsByTagName('img');\n		var inputList = Array.prototype.slice.call(input);\n		for(i = 0;i < inputList.length; i++) {\n			inputList[i].style = 'filter: brightness(100%)';\n		};\n	};\n \n	var slider = document.getElementById('myRange');\n	var output = document.getElementById('demo');\n	output.innerHTML = slider.value;\n	slider.oninput = function() {\n		output.innerHTML = this.value;\n		var input = document.getElementsByTagName('img');\n		var inputList = Array.prototype.slice.call(input);\n		for(i = 0;i < inputList.length; i++) {\n			inputList[i].style = 'filter: brightness(' + this.value + '%)';\n		};\n	};\n\n</script>", temp)
  }
  
  
  writeLines(temp, paste0(wdfunction, "/", filename, ".html"))
  
}


transposeDorian <- function(data, variable.name) {
  
  data <- data.table(data)
  temp <- setnames(data.table(t(data[, -c(variable.name), with=F])), data[[c(variable.name)]])
  temp[, col := names(data)[which(!names(data) %in% variable.name)]]
  return(temp)
  
}

readAll <- function(listfile, fill = F, skip = 0, header = T) {
  
  # give a list of file and read them all and rbind
  lst <- lapply(listfile, fread, skip=skip, header = header)
  lst <- mapply(cbind, lst, file=basename(listfile), SIMPLIFY=F)
  dt <- rbindlist(lst, fill = fill)
  return(dt)
  
  
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

grep.return <- function(pattern, vector) {
  
  return(vector[grep(pattern, vector)])
  
}

grep.string <- function(vector, collapse = "|") {
  
  cat("[Info] - Use of grep:\n- 'grep -s string *' to search in current directory, not recursively.\n- 'grep -sE string *' to search in current directory, not recursively with regex.- 'grep -RlE 'word1|word2' *.doc' to search recursively, with regex, output in list.\n\n")
  return(paste0(vector, collapse = collapse))
  
}

debug.easy <- function(logical, message, toprint) {
  
  if( logical ) {
    if( !missing(toprint) ) {
      print(toprint)
    }
    stop(cat("[DEBUG] - ", message, "\n"))
  }
  
}

debug.easy.Rscript <- function(logical, message) {
  
  if( logical ) {
    message("[DEBUG] - ", message, "\n")
    Sys.sleep(30)
    stop()
  }
  
}

ncomb <- function(n, x) { # Number of k-combinations for all k (field opera, or other)
  # The number of k-combinations for all k is the number of subsets of a set of n elements. There are several ways to see that this number is 2n. In terms of combinations, {\displaystyle \sum _{0\leq {k}\leq {n}}{\binom {n}{k}}=2^{n}} \sum _{0\leq {k}\leq {n}}{\binom {n}{k}}=2^{n}, which is the sum of the nth row (counting from 0) of the binomial coefficients in Pascal's triangle. These combinations (subsets) are enumerated by the 1 digits of the set of base 2 numbers counting from 0 to 2n  −  1, where each digit position is an item from the set of n.
  
  # Given 3 cards numbered 1 to 3, there are 8 distinct combinations (subsets), including the empty set:
  
  2^n - 1 
  # x2 <- x:1
  # sum(factorial(n) / factorial(n-x2) / factorial(x2))
  
}

coldiff <- function(x, y) {
  
  # check colnames difference between 2 data.table / data.frame
  temp <- setdiff(names(x), names(y))
  return(temp)
  
}

sourceLines <- function(Rfile, lines) {
  
  #' Source specific lines in an R file
  #'
  #' @param Rfile character string with the path to the file to source.
  #' @param lines numeric vector of lines to source in \code{Rfile}.
  
  
  debug.easy(!is.character(Rfile), "'Rfile' should be a string (path)")
  debug.easy(exists(Rfile), "'Rfile'does not exists")
  debug.easy(!is.numeric(lines), "'lines' should be numeric")
  
  code <- readLines(Rfile, warn = FALSE)
  code2 <- code[lines]
  print(code2)
  eval(parse(text=code2), envir = .GlobalEnv)
}

Expand.table <- function(DATA, expand.vector, name.new.variable) {
  
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

rDT <- function(file, ...) {
  temp <- data.table(read.csv(file = file, ...))
  return(temp)
}

write.csv.PF <- function(DATA, filenamefunction, additionalcol=NA) {
  
  DATA$row <- factor(DATA$row, levels=LETTERS[1:16])
  
  if(is.na(additionalcol) == F) {
    normalcol <- c(additionalcol, c("AP", "Expi", "Meas", "MeasTime", "nFields", "AnaTime", "filename", "nodename", "row"))
  } else {
    normalcol <- c("AP", "Expi", "Meas", "MeasTime", "nFields", "AnaTime", "filename", "nodename", "row")
  }
  
  
  datacol <- names(DATA)[which(names(DATA) %ni% c(normalcol, "col"))]
  pfall <- data.frame()
  
  for(i in seq_along(datacol)) {
    temp <- subset(DATA, select = c(normalcol, "col", datacol[i]))
    pf <- dcast(temp, as.formula(paste0(paste0(normalcol, collapse = "+"), "~col")))
    pf$variable <- datacol[i]
    pf <- rbind(pf, names(pf))
    pfall <- rbind(pfall, pf)
  }
  
  if(is.na(additionalcol) == F) {
    write.csv(pfall, gsub(".csv", paste0("_PF-", paste0(additionalcol, collapse = "-"), ".csv"), filenamefunction), row.names=F)
  } else {
    write.csv(pfall, gsub(".csv", "_PF.csv", filenamefunction), row.names=F)
  }
  
}


Throughput <- function (start.time = "9:00",
                        time.stagger.s = 390,
                        time.1.sample.s = 2*60*60,
                        max.plates = 100
) {
  
  
  start.time <- strptime(start.time, format ="%H:%M")
  
  if( missing( max.plates ) ) {
    max.plates <- 100
  }
  
  data <- data.table(Sample = 1:max.plates, Start = start.time)
  
  for(i in 1:nrow(data)) {
    
    if(i != 1) {
      data[i, Start := data[i-1]$Start + time.stagger.s]
    }
    data[i, End := Start + time.1.sample.s]
    
  }
  
  data2 <- melt.data.table(data, c("Sample"))
  
  days <- strptime(unique(format(data2$value, "%Y-%m-%d")), "%Y-%m-%d")
  begin.day <- days + rep(9*60*60, length(days))
  end.day <- days + rep(18*60*60, length(days))
  
  a <- ggplot(data2, aes(value, Sample))+
    geom_vline(xintercept = begin.day, color = "green")+
    geom_vline(xintercept = end.day, color = "red")+
    geom_line(aes(group = Sample))+
    scale_y_reverse(minor_breaks = seq(0,max.plates,  5), breaks = seq(0, max.plates, 10))+
    scale_x_datetime(breaks = date_breaks("30 min"), labels = date_format("%d %H:%M", tz = "CET"))+
    theme(axis.text.x = element_text(angle = 90, hjust = 1))+
    labs(title = "Throughput",
         caption = paste0("Time stagger: ", time.stagger.s, "\nTime for 1 sample: ", round(time.1.sample.s / 60 / 60, 2), "h"))
  print(a)
  assign("a", a, envir = parent.frame(1))
  
  
}

dilution.step <- function(startCC = 0.01, nsteps = 8) {
  return(c(startCC, startCC * 1/(3^c(1:(nsteps - 1)))))
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




# QC ----------------------------------------------------------------------


QC.filter <- function (DATA, 
                       QCvariables = "RZprimefactor", 
                       filter.variable = "Zprimefactor", # which variable to take the best CP-Q
                       QCvalues = 0.5,
                       operator = "&",
                       APvariable = "AP", 
                       title = "",
                       duplicate = 1) {
  
  temp <- copy(DATA)
  
  if ( !"Q" %in% names(DATA) ) { 
    # assign Quadrant if not existing
    temp[, Q := NA]
  }
  
  # debug part ---
  debug.easy( !all(c("CP", "Q", "Addition") %in% names(temp)), "You should have 'CP' and 'Q' and 'Addition' variable.")
  debug.easy( length(QCvariables) != length(QCvalues), "Length of 'QCvariables' should equal to length of 'QCvalues'")
  debug.easy( !all(QCvariables %in% names(temp)), "'QCvariable' should be column names")
  debug.easy( !APvariable %in% names(temp), "'APvariable' should be column names")
  debug.easy( !is.numeric(duplicate), "duplicate' should be numeric")
  debug.easy( !all(filter.variable %in% QCvariables), "'filter.variable' should be in 'QCvariable'")
  
  
  temp <- dcast.data.table(temp,
                           as.formula( p0(APvariable, "+CP+Q~Addition") ),
                           value.var = QCvariables,
                           fun.aggregate = max)  # dcast for addition
  
  if( length(QCvariables) == 1 ) {
    # change names if only 1 QCvariable
    setnames(temp, grepcol(c("AP", "IP", "CP", "Q"), temp, rev = T), p0(QCvariables, "_", grepcol(c("AP", "IP", "CP", "Q"), temp, rev = T)))
  }
  
  temp[, QC := 0]
  
  # if only 1 operator replicate it
  if( length(operator) == 1 & length(QCvariables) > 1 ) {
    operator <- rep(operator, length(QCvariables) - 1)
  }
  
  
  
  nadd <- length(unique(DATA$Addition))
  for(i in seq_along(QCvariables) ) {
    if( nadd == 2) {
      listAP <- temp[get( p0(QCvariables[i], "_1") ) >= QCvalues[i] & get( p0(QCvariables[i], "_2") ) >= QCvalues[i]][, get(APvariable)]  # select only AP with good QC for the 2 additions
    } else {
      add <- unique(DATA$Addition)
      listAP <- temp[get( p0(QCvariables[i], "_", add) ) >= QCvalues[i]][, get(APvariable)]
    }
    
    listAP <- as.character(listAP)
    
    if( i == 1 ) {
      listAPend <- listAP
    } else {
      if( operator[i-1] == "&" ) { # if first QCvariable do not take care of operator
        listAPend <- unique(listAP[listAP %in% listAPend])
      } 
      if( operator[i-1] == "|" ) {
        listAPend <- unique(c(listAPend, listAP))
      }
    }
    
    if( nadd == 2 ) {
      temp[, p0("mean", QCvariables[i]) := (get( p0(QCvariables[i], "_1") ) + get( p0(QCvariables[i], "_2") )) / 2]
    } else {
      temp[, p0("mean", QCvariables[i]) := get( p0(QCvariables[i], "_", add) )]
    }
  }
  
  
  temp[get(APvariable) %in% listAPend, QC := 1]
  
  if( duplicate == 1 ) {
    
    temp.good <- temp[QC == 1]
    temp.good <- temp.good[temp.good[, .I[get(p0("mean", filter.variable)) == max(get(p0("mean", filter.variable)), na.rm = T)], .(CP, Q)]$V1] 
    toredo <- dtjoin(temp[QC == 0, .N, .(CP, Q)], temp.good, "anti")
    notselec <- dtjoin(temp, temp.good, "anti")
    
    if( nrow(notselec) > nrow(temp.good) ) {
      cat("\n--------------------------------------------------------------------------------------------------------------------\n")
      cat("[INFO] - You have a lot of duplicates, is this normal ? If it is a DRC assay you can set the number of duplicates wanted with 'duplicate' parameter.")
      cat("\n--------------------------------------------------------------------------------------------------------------------\n")
      
    }
    
  } else {
    
    debug.easy(T, "STOP - Function part to check")
    temp.good <- temp[QC == 1]
    
    toredo <-  temp[QC == 0, .N, c("CP", "Q", APvariable)]
    status <- temp.good[, .N, .(CP, Q)][, Todo := duplicate - N]
    
    bad <- temp[QC == 0, .N, .(CP, Q)][!CP %in% status$CP]
    bad <- bad[, N := 0]
    bad[, Todo := duplicate - N]
    
    status <- rbind(status, bad)
    status[order(CP)]
    
  }
  
  
  
  assign(p0("good", title), temp.good, env = parent.frame(1))
  assign(p0("toredo", title), toredo, env = parent.frame(1))
  
  if( duplicate == 1 ) {
    assign(p0("notselec", title), notselec, env = parent.frame(1))
    cat("RObject assigned:\n-", p0("good", title), " (#", nrow(temp.good),") : good plates\n-", p0("toredo", title)," (#", nrow(toredo),") : plates to repeat\n- notselec (#", nrow(notselec),") : data not selected, can be good or bad\n")
  } else {
    debug.easy(T, "STOP - Function part to check")
    assign(p0("Status", title), status, env = parent.frame(1))
    cat("RObject assigned:\n-", p0("Good", title), " (#", nrow(temp.good),") : Good plates\n- Bad done -", p0("Toredo", title),"object (#", sum(toredo$N),") : plates to repeat\n- Status from duplicates in '", p0("Status", title), "'")
  }
  
  
}

QC.output.table <- function(DATA, 
                            Zpf.threshold = 0.5,
                            APvariable = "AP",
                            wdfunction = wdout,
                            Model) {
  
  create.dir(wdout, "QC", "wdoutqc")
  
  DATA2 <- copy(DATA)
  
  if( !"Addition" %in% names(DATA)) {
    DATA2[, Addition := 1]
  }
  
  
  DATA2[, Addition := factor(Addition, levels = c(1, 2))]
  
  if( missing(Model) ) {
    QC <- DATA2[, .N, c(APvariable, "S.B", "Zprimefactor", "RZprimefactor", "Session", "Addition")]
  } else {
    QC <- DATA2[, .N, c(APvariable, "S.B", "Zprimefactor", "RZprimefactor", "Session", "Addition", Model)]
  }
  
  QC[, QC.Zpf := ifelse(Zprimefactor >= Zpf.threshold, paste0(">= ", Zpf.threshold), paste0("< ", Zpf.threshold))]
  QC[, QC.RZpf := ifelse(RZprimefactor >= Zpf.threshold, paste0(">= ", Zpf.threshold), paste0("< ", Zpf.threshold))]
  QC[, Session := factor(Session, levels = 1:100)]
  
  if( missing(Model) ) {
    QC2 <- melt.data.table(QC[, -c("QC.Zpf", "QC.RZpf", "N")], c(APvariable, "Session", "Addition"))
  } else {
    QC2 <- melt.data.table(QC[, -c("QC.Zpf", "QC.RZpf", "N")], c(APvariable, "Session", "Addition", Model))
  }
  
  QC2[, Threshold := ifelse(variable == "S.B", 2, 0.5)]
  
  if( missing(Model) ) {
    QC3 <- QC2[, .(Mean = mean(value),
                   SD = sd(value),
                   Max = max(value),
                   Min = min(value)), .(Addition, variable)]
  } else {
    QC3 <- QC2[, .(Mean = mean(value),
                   SD = sd(value),
                   Max = max(value),
                   Min = min(value)), c("Addition", "variable", Model)]
  }
  
  write.csv(QC3, paste0(basename(wdout), "_QC_Average.csv"), row.names = F)
  
  assign("QC", QC, env = .GlobalEnv)
  assign("QC2", QC2, env = .GlobalEnv)
  cat("[INFO] - RObject 'QC' and 'QC2' assigned.\n\tQ3 written in ", paste0(basename(wdout), "_QC_Average.csv\n"))
  write.csv(QC3, paste0(basename(wdfunction), "_QC_Average.csv"), row.names = F)
  
}

QC.graphics <- function(DATA, 
                        project, 
                        Zpf.threshold = 0.5,
                        wdfunction = wdout,
                        APvariable = "AP",
                        Model) {
  
  
  debug.easy(!is.character(project), "Parameter 'project' should be a string.")
  debug.easy(!is.data.table(DATA), "Parameter 'DATA' should be a data.table.")
  
  QC.output.table(DATA, Zpf.threshold =  Zpf.threshold, APvariable = APvariable, wdfunction = wdfunction, Model = Model)
  
  two.add <- ifelse(length(unique(QC$Addition)) == 2, T, F)
  nSession <- length(unique(QC$Addition))
  
  # _____________________________________________________________________________________________
  
  create.dir(wdout, "QC", "wdoutqc")
  
  a <- ggplot(QC, aes(Addition))+
    geom_bar(aes(fill = QC.Zpf))+
    labs(title = paste0(project, " - Histogram of plate QC"),
         subtitle = "Zprimefactor",
         caption = paste0("Number of session = ",
                          length(unique(QC$Session)),
                          "\nNumber of plates = ", length(unique(QC$AP)), 
                          "\nREF not included",
                          "\nDate: ",
                          gettimestamp()))
  a
  if( !missing(Model) ) {
    a <- a + facet_grid(as.formula(p0("~", Model)))
  }
  printfast(a, paste0(basename(wdout), "_QC_Zprimefactor.jpg"), 300, 200)
  
  # _____________________________________________________________________________________________
  
  create.dir(wdout, "QC", "wdoutqc")
  
  a <- ggplot(QC, aes(Addition))+
    geom_bar(aes(fill = QC.RZpf))+
    labs(title = paste0(project, " - Histogram of plate QC"),
         subtitle = "Zprimefactor",
         caption = paste0("Number of session = ",
                          length(unique(QC$Session)),
                          "\nNumber of plates = ", length(unique(QC$AP)), 
                          "\nREF not included",
                          "\nDate: ",
                          gettimestamp()))
  a
  if( !missing(Model) ) {
    a <- a + facet_grid(as.formula(p0("~", Model)))
  }
  printfast(a, paste0(basename(wdout), "_QC_RZprimefactor.jpg"), 300, 200)
  
  # _____________________________________________________________________________________________
  
  a <- ggplot(QC, aes(Session))+
    geom_bar(aes(fill = QC.Zpf))+
    labs(title = paste0(project, " - Histogram of plate QC per Session"),
         subtitle = "Zprimefactor",
         caption = paste0("Number of session = ",
                          length(unique(QC$Session)),
                          "\nNumber of plates = ", length(unique(QC$AP)), 
                          "\nREF not included",
                          "\nDate: ",
                          gettimestamp()))
  a
  if( !missing(Model) ) {
    a <- a + facet_grid(as.formula(p0("Addition~", Model)))
  } else {
    a <- a + facet_grid(Addition~.)
  }
  printfast(a, paste0(basename(wdout), "_QC-Session_Zprimefactor.jpg"), 500, 150 + (50 * nSession))
  
  # _____________________________________________________________________________________________
  
  a <- ggplot(QC, aes(Session))+
    geom_bar(aes(fill = QC.RZpf))+
    labs(title = paste0(project, " - Histogram of plate QC per Session"),
         subtitle = "RZprimefactor",
         caption = paste0("Number of session = ",
                          length(unique(QC$Session)),
                          "\nNumber of plates = ", length(unique(QC$AP)), 
                          "\nREF not included",
                          "\nDate: ",
                          gettimestamp()))
  a
  if( !missing(Model) ) {
    a <- a + facet_grid(as.formula(p0("Addition~", Model)))
  } else {
    a <- a + facet_grid(Addition~.)
  }
  printfast(a, paste0(basename(wdout), "_QC-Session_RZprimefactor.jpg"), 500, 150 + (50 * nSession))
  
  # _____________________________________________________________________________________________
  
  
  if( !missing(Model) ) {
    temp <- QC[,.N, c(APvariable, "Session", Model)]
  } else {
    temp <- QC[,.N, c(APvariable, "Session")]
  }
  a <- ggplot(temp, aes(Session))+
    geom_bar()+
    labs(title = paste0(project, " - Histogram of plate per Session"),
         caption = "\nREF not included",
         "\nDate: ",
         gettimestamp())
  a
  if( !missing(Model) ) {
    a <- a + facet_grid(as.formula(p0("~", Model)))
  }
  printfast(a, paste0(basename(wdout), "_AP-Session.jpg"), 500, 150 + (50 * nSession))
  
  # _____________________________________________________________________________________________
  
  a <- ggplot(QC2, aes(Session, value))+
    geom_hline(aes(yintercept = Threshold), color = "green")+
    ylim(c(0, NA))+
    labs(title = paste0(project, " - QC per Session"),
         caption = paste0("Number of session = ",
                          length(unique(QC$Session)),
                          "\nNumber of plates = ", length(unique(QC$AP)), 
                          "\nREF not included",
                          "\nDate: ",
                          gettimestamp()))
  
  if( two.add ) {
    a <- a + geom_boxplot(aes(group = interaction(Session, Addition), fill = Addition), position = position_dodge2(preserve = "total"))
  } else {
    a <- a + geom_boxplot(aes(group = Session), position = position_dodge2(preserve = "total"))
  }
  
  # position = position_dodge2(preserve = "total") is for preserving good width for boxplot
  if( !missing(Model) ) {
    a <- a + facet_grid(as.formula(p0(Model, "~variable")), scales = "free_y")
  } else {
    a <- a + facet_grid(variable~., scales = "free_y")
  }
  
  a
  printfast(a, paste0(basename(wdout), "_QC-Session.jpg"), 500, 150 + (50 * nSession))
  
  # _____________________________________________________________________________________________
  
  a <- ggplot(QC2, aes(Addition, value))+
    geom_boxplot(position = position_dodge2(preserve = "total"))+
    geom_hline(aes(yintercept = Threshold), color = "green")+
    ylim(c(0, NA))+
    labs(title = paste0(project, " - QC per Addition"),
         caption = paste0("Number of session = ",
                          length(unique(QC$Session)),
                          "\nNumber of plates = ", length(unique(QC$AP)), 
                          "\nREF not included",
                          "\nDate: ",
                          gettimestamp()))
  a
  if( !missing(Model) ) {
    a <- a + facet_grid(as.formula(p0("variable~", Model)), scales = "free_y")
  } else {
    a <- a + facet_grid(variable~., scales = "free_y")
  }
  printfast(a, paste0(basename(wdout), "_QC-Add.jpg"), 500, 200)
  
}

# Check.Integrity <- function(DATA,
#                             PS,
#                             format = "384",
#                             mapped.Robject.name = "",
#                             title,
#                             wdfunction) {
#   
#   setwd(wdfunction)
#   
#   
#   debug.easy(!any(c("384", "96", "1536") %in% format), "'format' should be '384, '1536' or '96'")
#   debug.easy(mapped.Robject.name == "", "Give a defined name for 'mapped.Robject.name', will bind the CPidmapping")
#   debug.easy(!is.numeric(PS), "'PS' should a numeric vector.")
#   
#   data <- copy(DATA)
#   
#   if( !"AP" %in% names(DATA) ) {
#     cat("[INFO] - No 'AP' variable found, 'IP' will be renamed to 'AP'\n\n")
#     data[, AP := IP]
#   }
#   if( !"Addition" %in% names(DATA) ) {
#     cat("[INFO] - No 'Addition' variable, a new variable will be create with value 1\n\n")
#     data[, Addition := 1]
#   }
#   
#   debug.easy(nrow( data[, .N, names(data)][N>1] ) > 0, "You have duplicated data, check above.", data[, .N, names(data)][N>1])
#   
#   
#   
#   # mapping
#   map <- data.table()
#   for(i in seq_along(PS)) {
#     readDB("Mapping_R", p0("select * from CPidmapping where PS=", PS[i]), "map1") 
#     if( unique(map1$Format) == "1536" & format == "384" ) {
#       map1 <- convertMapping(map1, "1536", "384") # convert mapping - this is changing col and row and adding Q
#     } else if ( unique(map1$Format) == format ) { 
#       map1[, Q := NA]
#     } else {
#       debug.easy(T, "[DEBUG] - Error in the format check function")
#     }
#     map <- rbind(map, map1)
#   }
#   
#   cat("[INFO] - 'map' assigned\n\n")
#   assign("map", map, env = parent.frame(1))
#   
#   if( "Q" %in% names(data) & all(!is.na(unique(data$Q))) & all(is.na(unique(map$Q))) ) {
#     datamap <- dtjoin(data, map[, -"Q"]) 
#   } else {
#     datamap <- dtjoin(data, map) 
#   }
#   (missing <- map[!CP %in% datamap$CP, .N, .(CP, Q, PS)])
#   assign("missing", missing, env = parent.frame(1))
#   assign(mapped.Robject.name, datamap, env=parent.frame(1))
#   
#   debug.easy(nrow(datamap[is.na(CP)]) != 0, p0("You have some data without CP info. Robject assign:", mapped.Robject.name), datamap[!is.na(CP)])
#   debug.easy(nrow( datamap[, .N, names(datamap)][N>1] ) > 0, p0("You have duplicated data, check above. Robject assign:", mapped.Robject.name), datamap[, .N, names(datamap)][N>1])
#   
#   # if only CPBC no row and col 
#   # check if Q exist but not in map, source is then 384 and destination 1536
#   if( "Q" %in% names(data) & all(!is.na(unique(data$Q))) & all(is.na(unique(map$Q))) ) {
#   } else {
#   debug.easy(nrow( datamap[, .N, .(row, col, AP, Addition)][N>1] ) > 0,  p0("You have duplicated data, check above. It seems that you have several CPid in the same well. Robject assign:", mapped.Robject.name), datamap[, .N, .(row, col, AP, Addition)][N>1])
#   }
#   
#   
#   
#   if( "Session" %in% names(data)) {
#     cat("--------------------------------------------------------------------------\n")
#     cat("|\t\t\tNumber of Session\n")
#     cat("--------------------------------------------------------------------------\n")
#     print(datamap[,.N,.(AP, Session)][order(Session), .N, Session])
#   }
#   
#   
#   cat("--------------------------------------------------------------------------\n")
#   cat("|\t\t\tNumber of AP\n")
#   cat("--------------------------------------------------------------------------\n")
#   print(datamap[,.N,.(AP, Addition)][, .N, AP])
#   
#   assign(mapped.Robject.name, datamap, env = parent.frame(1))
#   cat("\n\n[INFO] - '", mapped.Robject.name, "' assigned\n")
#   
#   if( !missing(title) ) {
#     cat("\n\n[INFO] - Writing .csv ...\n")
#     write.csv(datamap, p0(title, ".csv"), row.names = F)
#   }
#   
#   cat("\n[INFO] - 'missing' assigned\n")
#   cat("[INFO] - You have ", nrow(missing), "CP missing in your data.\n\n")
# 
#   
#   # Status
#   missing[, Status := "Not done"]
#   datamap <- datamap[,.N, .(CP, PS, Q)][, Status := "Done"]
#   status <- rbind(missing, datamap)
#   options(knitr.kable.NA = '')
#   print(kable(dcast.data.table(status[,.N, .(PS, Status)], PS~Status)))
#   
#   if( nrow(missing) == 0 ) {
#     cat("[INFO] - All fine :) All CP in the data\n\n")
#     Print.Bike()
#   }
# 
# }      

create.hitlist <- function(DATA,
                           value.name,
                           nthreshold,
                           mapped.Robject.name,
                           title,
                           wdfunction) {
  
  setwd(wdfunction)
  
  debug.easy(missing(title), "Give a defined title for the csv hitlist")
  debug.easy(missing(mapped.Robject.name), "Give a defined name for 'mapped.Robject.name'")
  debug.easy(!value.name %in% names(DATA), "'value.name' value does not exists in your data")
  debug.easy(!"CPid" %in% names(DATA), "You should have a CPid variable in your data")
  debug.easy(!grep("Value", value.name), "'value.name' value should be normalized data, so usually Value.NPI or Value.NPA")
  
  
  data <- DATA[!is.na(CPid), c(value.name, "CPid"), with = F][order(-get(value.name))]
  data <- data[data[, .I[get(value.name) == max(get(value.name))], CPid]$V1]
  
  data[, Hits := 0]
  data[1:nthreshold, Hits := 1]
  
  data2 <- copy(DATA)
  data2 <- dtjoin(data2, data)
  
  data2[!is.na(CPid), .N, Hits]
  data2[!is.na(CPid) & is.na(Hits)]
  data2[is.na(Hits) & CPid %in% data$CPid, Hits := 0] # add 0 for duplicates because 
  
  cat("\n[INFO] - '", mapped.Robject.name,  "' and 'hitlist' assigned\n")
  assign(mapped.Robject.name, data2, env = .GlobalEnv)
  assign("hitlist", data[Hits == 1], env = .GlobalEnv)
  
  write.csv(data2hits, p0(title, ".csv"), row.names = F)
  
  
}


create.REF.DRC.Session <- function(listRData,
                                   ggtitle = "", 
                                   ggsubtitle = "",
                                   ggy = "",
                                   ggx = "",
                                   ggcaption = "",
                                   title,
                                   wdfunction) {
  
  loadROnly(listRData,
            c("DRC.IC50", "DRC.data", "DRC.curve"))
  # bad DRC Session2
  DRC.curveall <- DRC.curveall[Session != 2]
  DRC.IC50all <- DRC.IC50all[Session != 2]
  DRC.dataall <- DRC.dataall[Session != 2]
  
  nadd <- length(unique(DRC.IC50all$Addition))
  
  
  a <- ggplot(DRC.curveall, aes(x, y))+
    facet_grid(.~Addition)+
    coord_cartesian(y=c(-20, 120))+
    geom_vline(data = DRC.IC50all, aes(xintercept = log10_IC50_M, color = Session, group=interaction(sample, Addition)))+
    geom_hline(yintercept=c(0,100), color="grey")+
    geom_line(aes(color = Session, group=interaction(sample, Addition)))+
    stat_summary(data = DRC.dataall, aes(log10_dose_M, value, color=Session, group=interaction(sample, Addition)), fun.y="mean", size=1, geom="point")+
    stat_summary(data = DRC.dataall, aes(log10_dose_M, value, color=Session, group=interaction(sample, Addition)), fun.data="mean_sdl", fun.args = list(mult = 1), geom="errorbar", width=0.1)+
    labs(title = ggtitle,
         subtitle = ggsubtitle,
         y = ggy,
         x = ggx,
         caption = ggcaption)
  a
  printfast(a, p0(title, ".jpg"), 400, nadd * 500)
  
  write.csv(DRC.IC50all, p0(title, ".csv"), row.names=F)
}




# Rdata -------------------------------------------------------------------



saveRData <- function(title="", wdfunction = wd2)
{
  if(exists("wdfunction") == F) {
    wdfunction <- getwd()
  }
  
  setwd(wdfunction)
  save(list = ls(all = TRUE, envir = .GlobalEnv), file = paste0(basename(dirname(wdfunction)),title,".RData"))
  
}

saveROnly <- function(title="", wdfunction = wd2, what)
{
  
  if(exists("wd2") == F) {
    wdfunction <- getwd()
  }
  
  setwd(wdfunction)
  
  save(list = what, file = paste0(basename(dirname(wdfunction)),title,".RData"))
}

# all


saveRDataAll <- function(where=dirname(wd), what)
{
  setwd(where)
  create.dir(where, "All", "wdAll")
  assign("wdAll",wdAll, env=.GlobalEnv)
  setwd(wdAll)
  Session <- paste0(unique(rawWP$Assay),"_",unique(rawWP$Session))
  assign("Session", Session, env=.GlobalEnv)
  save(list=what, file=paste0(Session,".RData"))
}


loadRDataAll <- function(where=wdAll, df, check=F)
{
  setwd(where)
  fall <- list.files(where,".RData")
  
  for (i in seq(df))
  {
    assign(paste0(df[i],"all"), data.table(), env=.GlobalEnv)
    # assign(paste0(df[i],"all"),data.table(), env=.GlobalEnv)
  }
  
  if(length(fall)!=0)
  {
    for( hh in seq_along(fall))
    {
      load(fall[hh])
      
      for( f in seq_along(df))
      {
        if(exists(df[f]) == F)
        {
          stop(paste0(df[f]," in ", fall[hh], " does not exist.\n"))
          
        } else { # so if the table is existing
          
          cat(paste0(fall[hh], " loaded..."))
          
          for(g in seq(df))
          {
            
            assign(paste0(df[g],"all"), bind_rows(get(paste0(df[g],"all")), get(df[g])), env=.GlobalEnv)
            
            if(check == T) 
            {
              df[g]
              comparecol( get(paste0(df[g],"all")), get(df[g]))
            }
          }
          
          cat(" DONE.\n")
        }
      }
    }
  }
}

loadROnly <- function(rdata, what, rbindfill = F)
{
  if (length(rdata) == 1)
  {
    load(rdata)
    for(i in seq(what))
    {
      assign(what[i], get(what[i]), env=.GlobalEnv)
    }
  } else {
    
    for (k in seq(what))
    {
      assign(paste0(what[k],"all"), data.table(), env=.GlobalEnv)
    }
    
    for(j in seq(rdata))
    {
      load(rdata[j])
      cat(paste0(j, "-", rdata[j], " loaded...\n"))
      
      for(i in seq(what))
      {
        
        tryCatch({ 
          
          # assign(paste0(what[i],"all"), bin_rows(get(paste0(what[i],"all")), get(what[i])), env=.GlobalEnv) # from loadRDataAll but not sure what is better
          assign(paste0(what[i],"all"), rbind(get(paste0(what[i],"all")), get(what[i]), fill = rbindfill), env=.GlobalEnv) # was 20180422
          
        }, error=function(e) {
          
          cat("[DEBUG] - RData : ", rdata[j], "\n[DEBUG] - Robject : ",what[i])
          
          setdiff(get(paste0(what[i],"all")), get(what[i]))
        })
        
      }
    }
  }
  
  
}





# DB ----------------------------------------------------------------------



dbRead <- function(conn, statement)
{
  cat("[INFO] - SQL Statement:", statement, "\n")
  temp <- dbFetch(dbSendQuery(conn, statement), n=-1)
  return(temp)
}


dbUpdateVars <- function(conn, dbtable, dataframe, PrimaryKey) { 
  if (!dbExistsTable(conn, dbtable)) { 
    stop("The target table \"", dbtable, "\" doesn't exist in the database \"", dbGetInfo(conn)$dbname, "\"\n\n", call. = FALSE) 
  } 
  if (is.null(dataframe)) { 
    stop("The source dataframe is missing, with no default\n\n", call. = FALSE) 
  } 
  if (!all(toupper(PrimaryKey) %in% toupper(names(dataframe)))) { 
    stop("The primary key variable doesn't exist in the source dataframe\n\n", call. = FALSE) 
  }
  if (!all(toupper(PrimaryKey) %in% toupper(dbListFields(conn, dbtable)))) { 
    stop("The primary key variable doesn't exist in the target table\n\n", call. = FALSE) 
  } 
  if (!all(toupper(dbListFields(conn, dbtable)) %in% toupper(names(dataframe)))) { 
    stop("One or more variables don't exist in the source dataframe\n\n", call. = FALSE) 
  } 
  
  data <- fetch(dbSendQuery(conn, paste0("select * from ", dbtable)), n=-1)
  PmK <- which(names(dataframe) %in% PrimaryKey)
  
  toupdate <- anti_join(dataframe, data) # add new from a to b (all column)
  tokeep <- semi_join(data, dataframe) # to keep, same in a and b
  tokeep2 <-anti_join(data, dataframe[,PmK]) # to keep only in a
  
  newdata <- rbind(toupdate, tokeep, tokeep2)
  
  dbWriteTable(conn, dbtable, newdata, overwrite = T, row.names=F)
  
} 


readDB <- function(db.name, table.name, name.return = "data", ff.package = F , RMariaDB = T) {
  
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
  if( !grepl(" ", table.name) ) {
    table.name <- p0("select * from ", table.name)
  }
  
  
  tryCatch({ 
    if( ff.package ) {
      
      if( db.name %like% "REMP" ) {
        # library("RJDBC")
        driver <- JDBC("oracle.jdbc.OracleDriver", classPath = "~/HTS/Data/R/Functions/Driver/ojdbc7.jar")
        
        if( db.name == "REMP_test" ) {
          
          data <- data.table(read.dbi.ffdf(table.name, 
                                           dbConnect.args = list(drv = driver,
                                                                 user = 'test_hdc',
                                                                 password="uspfhdc",
                                                                 url = "jdbc:oracle:thin:@10.13.47.209:1521/remp.nycomed.local",
                                                                 dbname=db.name)))
          
        } 
        
        if( db.name == "REMP_prod" ) {
          
          data <- data.table(read.dbi.ffdf(table.name, 
                                           dbConnect.args = list(drv = driver,
                                                                 user = 'hdc',
                                                                 password="uspfhdc",
                                                                 url = "jdbc:oracle:thin:@10.13.47.209:1521/remp.nycomed.local",
                                                                 dbname=db.name)))
          
        }
        
      } else {
        
        # MariaDB
        mydb <- dbConnect(MySQL(), user = 'hts', password = 'uspfhdc', host='10.13.20.9', dbname=db.name) # connexion
        print(kable(data.table(Name.tables = dbListTables(mydb))))
        suppressWarnings(dbDisconnect(mydb))
        data <- data.table(read.jdbc.ffdf(table.name, 
                                          dbConnect.args = list(drv = MySQL(),
                                                                user = 'hts',
                                                                password = 'uspfhdc',
                                                                host='10.13.20.9',
                                                                dbname=db.name)))
        
      }
      
      
    } else {
      
      if(db.name %like% "REMP") {
        # library("RJDBC")
        driver <- JDBC("oracle.jdbc.OracleDriver", classPath = "~/HTS/Data/R/Functions/Driver/ojdbc7.jar")
        
        if( db.name == "REMP_test" ) {
          
          driver <- JDBC("oracle.jdbc.OracleDriver", classPath = "~/HTS/Data/R/Functions/Driver/ojdbc7.jar")
          mydb <- dbConnect(driver, user = 'test_hdc', password="uspfhdc", url = "jdbc:oracle:thin:@10.13.47.209:1521/remp.nycomed.local") # connexion
          data <- data.table(dbRead(mydb, table.name))
          suppressWarnings(dbDisconnect(mydb))
          
        } 
        if( db.name == "REMP_prod" ) {
          
          driver <- JDBC("oracle.jdbc.OracleDriver", classPath = "~/HTS/Data/R/Functions/Driver/ojdbc7.jar")
          mydb <- dbConnect(driver, user = 'hdc', password="uspfhdc", url = "jdbc:oracle:thin:@10.13.47.209:1521/remp.nycomed.local") # connexion
          data <- data.table(dbRead(mydb, table.name))
          suppressWarnings(dbDisconnect(mydb))
          
        }
      } else {
        if( RMariaDB ) {
          # MariaDB
          mydb <- dbConnect(RMariaDB::MariaDB(), user = 'hts', password = 'uspfhdc', host='10.13.20.9', dbname=db.name) # connexion
          print(kable(data.table(Name.tables = dbListTables(mydb))))
          data <- data.table(dbRead(mydb, table.name))
          suppressWarnings(dbDisconnect(mydb))
          
        } else {
          
          mydb <- dbConnect(MySQL(), user = 'hts', password = 'uspfhdc', host='10.13.20.9', dbname=db.name) # connexion
          print(kable(data.table(Name.tables = dbListTables(mydb))))
          data <- data.table(dbRead(mydb, table.name))
          suppressWarnings(dbDisconnect(mydb))          
        }
      }
      
      
    }
    
    
    
    # Test efficiency
    # ff packages does not seem to do better
    
    # library(rbenchmark)
    
    
    
    
    # benchmark("normal" = {readDB("Mapping_R", "select * from CPidmapping", "mapex") },
    #           "MariaDB" = { readDB("Mapping_R", "select * from CPidmapping", "map", RMariaDB = T)}, replications=1)
    # 
    # 
    # 
    # test replications elapsed relative user.self sys.self user.child sys.child
    # 2 MariaDB            1  21.357     1.00    10.045    2.794          0         0
    # 1  normal            1  30.968     1.45    10.857    2.151          0         0
    # 
    
    
    # benchmark("normal" = {
    #   readDB("Mapping_R", "select * from CPidmapping limit 10", "mapex")
    # },
    # "ff" = {
    #   readDB("Mapping_R", "select * from CPidmapping limit 10", "map", ff.package = T)
    # }, replications=1)
    # 
    # benchmark("normal" = {
    #   readDB("REMP_test", "REPLICAS", "CPBC")
    # },
    # "ff" = {
    #   readDB("REMP_test", "REPLICAS", "CPBC", ff.package = T)
    # }, replications= 1)
    # 
    # benchmark("normal" = {
    #   readDB("Mapping_R", "CPidmapping", "mapex")
    # },
    # "ff" = {
    #   readDB("Mapping_R", "CPidmapping", "map", ff.package = T)
    # }, replications=1)
    
    
    
    # detach("package:RJDBC", unload=TRUE)
    assign(name.return, data, envir = parent.frame(1)) # parent.frame(1), to assign to the envir before, important for function like check.integrity which use readDB
    cat(name.return, " R object assigned.\n")
    
  }, error=function(e) {
    # if error close the connection
    cat("\n\n, ERROR: \n")
    print(e)
    suppressWarnings(dbDisconnect(mydb))    
    cat("\n[DEBUG] - ERRROR - dbconnexion closed.\n")
    # kable(data.table(Name.tables = dbListTables(mydb)))
    # detach("package:RJDBC", unload=TRUE)
  })
  
  
  
}


writeDB <- function(db.name, table.name, table.to.write, overwrite = F, user='hts', password='uspfhdc', host='10.13.20.9') {
  
  cat("This function will create the table table.name if does not exist in db.name. If exists will append the data from table.to.write.\n")
  
  mydb <- dbConnect(MySQL(), user='hts', password='uspfhdc', dbname=db.name, host='10.13.20.9') # connexion
  print(dbListTables(mydb)) # list table in the db
  
  if( overwrite ) {
    dbWriteTable(mydb, table.name, table.to.write, row.names=F, overwrite=T)
  } else {
    if(table.name %in% dbListTables(mydb)) {
      dbWriteTable(mydb, table.name, table.to.write, row.names=F, append=T)
    } else {
      dbWriteTable(mydb, table.name, table.to.write, row.names=F)
    }
  }
  
  print(dbDisconnect(mydb))
  
}

Format.DB.table <- function(DATA, name.table, hitpickplate) {
  
  if( name.table == "REPLICAS" ) {
    
    DATA <- DATA[order(PRODUCTIONDATE)]
    DATA <- renamecol(DATA,
                      c("DAUGHTERBC", "MOTHERBC", "CONC", "LIBRARY", "COLLECTION", "PLATE_SET", "COPY"),
                      c("CP", "Mother", "CCM", "Library", "Collection", "PS", "Copy"))
    DATA[, CCM := CCM * 1e-3]
    if( !missing(hitpickplate) ) {
      DATA <- DATA[Mother %in% hitpickplate, .(CP, Mother, CCM)]
    }
    return(DATA)
    
  }
  
  if( name.table == "HITPLATES" ) {
    
    # DATA <- renamecol(DATA, c("COMPOUND", "PLA_CODE"), c("CPid", "Mother"))
    # DATA[, row := gsub("(\\D*)(\\d*)", "\\1", POSITION)]
    # DATA[, col := as.numeric(gsub("(\\D*)(\\d*)", "\\2", POSITION))]
    DATA <- renamecol(DATA, c("COMPOUNDCODE", "BARCODE"), c("CPid", "Mother"))
    DATA[, row := gsub("(\\D*)(\\d*)", "\\1", COORDINATE)]
    DATA[, col := as.numeric(gsub("(\\D*)(\\d*)", "\\2", COORDINATE))]
    DATA <- DATA[, .(row, col, Mother, CPid)]
    return(DATA)
    
  }
}

format.output.screener <- function(indata, name.value, rename.value, colpos, colneg, colcp) {
  
  DATA <- copy(indata)
  
  if( !missing( name.value ) ) {
    setnames(DATA, name.value, rename.value)
  }
  
  setnames(DATA, names(DATA), gsub(" ", ".", names(DATA)))
  DATA <- renamecol(DATA,
                    c("Plate.ID",
                      "Row",
                      "Column",
                      "Compound.ID",
                      "Conc...M.",
                      "Conc...uM.",
                      "Conc..[M]",
                      "Conc..[uM]",
                      "Run", 
                      "Timestamp"), 
                    c("AP",
                      "row",
                      "col",
                      "CPid", 
                      "CCM", 
                      "CCuM",
                      "CCM", 
                      "CCuM",
                      "Session",
                      "MeasTime"))
  
  setnames(DATA, grepcol("Timestamp", DATA), "MeasTime")
  
  if( "CCuM" %in% names(DATA) ) {
    DATA[CCuM == "-", CCuM := NA]
    if( class(DATA$CCuM) == "factor" ) {
      DATA[, CCuM := as.numeric.factor(CCuM)]
    }
    if( class(DATA$CCuM) == "character" ) {
      DATA[, CCuM := as.numeric(CCuM)]
    }
  }
  if( "CCM" %in% names(DATA) ) {
    DATA[CCM == "-", CCM := NA]
    if( class(DATA$CCM) == "factor" ) {
      DATA[, CCM := as.numeric.factor(CCM)]
    }
    if( class(DATA$CCM) == "character" ) {
      DATA[, CCM := as.numeric(CCM)]
    }
  }
  
  if( "CCuM" %in% names(DATA) & !"CCM" %in% names(DATA) ) {
    DATA[, CCM := CCuM * 10e-6]
    DATA[, CCuM := NULL]
  }
  

  
  
  
  DATA[CPid == "", CPid := NA]
  if( class(DATA$CPid) == "factor" ) {
    DATA[, CPid := as.character.factor(CPid)]
  }

    
  DATA <- ColRowFactor(DATA)
  DATA <- addControl(DATA, colpos = colpos, colneg = colneg, colcp = colcp)
  DATA[, Sample := AP]  
  if("MeasTime" %in% names(DATA) ) {
    if( nchar(DATA[1, MeasTime]) == 16 ) {
      DATA[, MeasTime := strptime(MeasTime, "%d.%m.%Y %H:%M")]  
    } else {
      DATA[, MeasTime := strptime(MeasTime, "%d.%m.%Y %H:%M:%S")]  
    }
  }
  return(DATA)
}

# Client Standard output ----------------------------------------------------------------


CPmapping <- function (wdmap,
                       ext=".txt", # could be used as well as grep
                       col=0,
                       colnamesmap=data.frame(),
                       mergerawbind=0,
                       makeid=0,
                       head=T,
                       cpid=0,
                       sepa=" ",
                       namemapfilecol = "mapfile",
                       name.return = "CPBC")
{
  # ext=".csv"; col=1:3; colnamesmap=c("ID", "CP", "AP")
  # wdmap=paste0(dirname(wd),"/CPmapping"); ext=".txt"; head=F; col=3:4; colnamesmap=c("CP", "AP"); mergerawbind=1; makeid=1; cpid=0 
  #   wdmap=paste0(dirname(wd),"/CPidmapping"); ext=".csv"; mergerawbind=0; makeid=0
  
  setwd(wdmap)
  map <- list.files(getwd(), pattern=ext, recursive = F)
  
  CPBC <- data.table()
  
  for (i in seq(map)) {
    
    if(ext %like% "csv") {
      temp <- read.csv(map[i], h=head)
    } else {
      temp <- read.table(map[i], h=head, sep=sepa, fill = NA)
    }
    
    if( length(col) == 1 ) {
      col <- 1:ncol(temp)
    }
    
    temp <- temp[,col]
    
    if(length(colnamesmap)==0)
    {
      colnamesmap <- colnames(temp)
    }
    
    colnames(temp) <- colnamesmap
    temp[,namemapfilecol] <- substr(map[i],1,nchar(map[i])-4)
    
    if(makeid==1)
    {
      temp$ID <- 1:nrow(temp)
    }
    CPBC <- rbind(CPBC,temp)
  }
  
  CPBC <- CPBC[!duplicated(CPBC),]
  # CPBC <- as.data.frame(lapply(CPBC, function(x) {gsub(" ", "", x)}))
  # CPBC <- as.character.factor.all(CPBC)
  
  assign(name.return,CPBC, env = .GlobalEnv)
  
  if(mergerawbind==1)
  {
    cat("\n\nrawbind merge with CPBC\n\n")
    rawbind <- merge(rawbind, CPBC, all.x=T, all.y=F)
    assign("rawbind",rawbind, env = .GlobalEnv)
  } else { cat("\n\nrawbind NOT merge with CPBC\n\n")}
  
  print(head(CPBC))
  
  cat("\n[INFO] - '", name.return, "' assigned.")
}



convertMapping <- function(datain,
                           from = "1536",
                           to = "384",
                           ignore.dupli = F,
                           interleaved = T) {
  
  if( !is.data.table(datain)) {
    data <- data.table(datain)
  } else {
    data <- copy(datain)
  }
  
  
  debug.easy(!any( names(data) == "Format" ), "[DEBUG] - Your data should contain a 'Format' variable")
  debug.easy(all(!any( names(data) == "Format" ), length( unique(data$Format) ) > 1), "[DEBUG] - Your data should contain a 'Format' variable")
  debug.easy(!all( c("row", "col") %in% names(data)  ), "[DEBUG] - Your data should contain a 'row' and 'col' variable" )
  debug.easy(all(from == "1536", to == "96"), "[DEBUG] - Please do not use 1536 to 96, to it in 2 steps" )
  debug.easy(all(from == "96", to == "1536"), "[DEBUG] - Please do not use 96 to 1536, to it in 2 steps" )
  debug.easy(all(ignore.dupli == F, length( which(duplicated(data) == T) ) > 1 ),
             p0("[DEBUG] - You have duplicated data in your table, rows : ", which(duplicated(data) == T)))
  
  
  data <- ColRowFactor(data)
  from.num <- as.numeric(from)
  to.num <- as.numeric(to)
  
  if( from.num < to.num ) {
    oriname <- names(data)[!names(data) %in% c("row", "col", "Q")]
  } else {
    oriname <- names(data)[!names(data) %in% c("row", "col")]
  }
  
  
  
  
  if( any(c(to, from) == "1536") ) {
    
    format.list <- c("1536", "384", "96")
    comb <- combn(format.list, 2)
    
    if( interleaved ) {
      lay <- data.table(row1536 = rep(c(LETTERS[1:26], paste0("A", LETTERS[1:6])), 24*2),
                        col1536 = rep(1:48, each=16*2),
                        row384 = rep(rep(LETTERS[1:16], each=2), 24*2),
                        col384 = rep(1:24, each=16*4),
                        row96 = rep(rep(LETTERS[1:8], each=4), 24*2),
                        col96 = rep(1:12, each=16*8),
                        Q1536 = 1,
                        Q384 = rep(c(rep(c(1,3), 16), rep(c(2,4), 16)), 24),
                        Q96 = rep(c(rep(seq(1, 16, 4), 8),
                                    rep(seq(2, 16, 4), 8),
                                    rep(seq(3, 16, 4), 8),
                                    rep(seq(4, 16, 4), 8)), 12))
      
      # for(i in 1:ncol(comb) ) {
      #     lay2 <- renamecol(lay, p0(c("row", "col"), comb[1,i]), c("row", "col"))
      #     HM(lay2, p0("Q", comb[2,i]), facet.formula = p0("~Q", comb[1,i]), format = comb[1,i], title = p0(comb[1,i], "~", comb[2,i]))
      #     WaitEnter()
      # }
      
    } else {
      
      lay <- data.table(row1536 = rep(c(LETTERS[1:26], paste0("A", LETTERS[1:6])), 24*2),
                        col1536 = rep(1:48, each=16*2),
                        row384 = rep(LETTERS[1:16], 24*4),
                        col384 = c(rep(1:24, each = 16*2), rep(1:24, each = 16*2)),
                        row96 = rep(LETTERS[1:8], 24*8),
                        col96 = c(rep(1:12, each=16*4), rep(1:12, each=16*4)),
                        Q1536 = 1,
                        Q384 = c(rep(rep(c(1,3), each=16), 24), rep(rep(c(2,4), each=16), 24)),
                        Q96 = c(rep(rep(seq(1, 16, 4), each=8), 12),
                                rep(rep(seq(2, 16, 4), each=8), 12),
                                rep(rep(seq(3, 16, 4), each=8), 12),
                                rep(rep(seq(4, 16, 4), each=8), 12)))
      
      # for(i in 1:ncol(comb) ) {
      #   lay2 <- renamecol(lay, p0(c("row", "col"), comb[1,i]), c("row", "col"))
      #   HM(lay2, p0("Q", comb[2,i]), facet.formula = p0("~Q", comb[1,i]), format = comb[1,i], title = p0(comb[1,i], "~", comb[2,i]))
      #   WaitEnter()
      # }
      
    }
  } else {
    
    format.list <- c("384", "96")
    comb <- combn(format.list, 2)
    
    if( interleaved ) {
      
      lay <- data.table(row384 = rep(LETTERS[1:16], 24),
                        col384 = rep(1:24, each=16),
                        row96 = rep(rep(LETTERS[1:8], each=2), 24),
                        col96 = rep(1:12, each=16*2),
                        Q384 = 1,
                        Q96 = rep(c(rep(c(1,3), 8), rep(c(2,4), 8)), 12))
      
      # for(i in 1:ncol(comb) ) {
      #   lay2 <- renamecol(lay, p0(c("row", "col"), comb[1,i]), c("row", "col"))
      #   HM(lay2, p0("Q", comb[2,i]), facet.formula = p0("~Q", comb[1,i]), format = comb[1,i], title = p0(comb[1,i], "~", comb[2,i]))
      #   WaitEnter()
      # }
      
    } else {
      
      lay <- data.table(row384 = rep(LETTERS[1:16], 24),
                        col384 = rep(1:24, each=16),
                        row96 = rep(LETTERS[1:8], 24*2),
                        col96 = c(rep(1:12, each=16), rep(1:12, each=16)),
                        Q384 = 1,
                        Q96 = c(rep(rep(c(1,3), each = 8), 12), rep(rep(c(2,4), each = 8), 12)))
      
      # for(i in 1:ncol(comb) ) {
      #   lay2 <- renamecol(lay, p0(c("row", "col"), comb[1,i]), c("row", "col"))
      #   HM(lay2, p0("Q", comb[2,i]), facet.formula = p0("~Q", comb[1,i]), format = comb[1,i], title = p0(comb[1,i], "~", comb[2,i]))
      #   WaitEnter()
      # }
      
    }
  }
  
  
  lay[, (grepcol("col", lay)) := lapply(.SD, function(x) { factor(x, levels = 1:48) }), .SDcols = grepcol("col", lay)]
  lay[, (grepcol("row", lay)) := lapply(.SD, function(x) { factor(x, levels = c(paste0("A", LETTERS[6:1]), LETTERS[26:1])) }), .SDcols = grepcol("row", lay)]
  lay[, (grepcol("Q", lay)) := lapply(.SD, function(x) { factor(x, levels = 1:16) }), .SDcols = grepcol("Q", lay)]
  
  
  # # check _________________________
  # wd <- "~/HTS/Data/CP_libraries/Mapping/HDC/1536/Layout_1536_384_96"
  # setwd(wd)
  # if( from == "1536") {
  # 
  #   a <- ggplot(lay, aes(col1536, row1536))+
  #     geom_text(aes(label = interaction(row384, col384)), size =3)+
  #     facet_wrap(~Q384)
  #   printfast(a, "Layout_1536-384.jpg", 800, 1500)
  # 
  #   a <- ggplot(lay, aes(col1536, row1536))+
  #     geom_text(aes(label = interaction(row96, col96)), size =3)+
  #     facet_wrap(~Q96)
  #   printfast(a, "Layout_1536-96.jpg", 1000, 2000)
  # 
  #   write.csv(lay, "Layout_1536-384-96.csv", row.names = F)
  # 
  # } else {
  # 
  #   a <- ggplot(lay, aes(col384, row384))+
  #     geom_text(aes(label = interaction(row96, col96)), size = 3)+
  #     facet_wrap(~Q96)
  #   printfast(a, "Layout_384-96.jpg", 600, 1000)
  # 
  #   write.csv(lay, "Layout_384-96.csv", row.names = F)
  # }
  
  
  # data <- copy(datain)
  
  
  # divide when 2 different format
  datato <- data[Format == to]
  datafrom <- data[Format == from]
  
  if( from.num > to.num ) {
    
    datato[, Q := NA]
    
    setnames(datafrom, c("row", "col"), p0(c("row", "col"), from))
    datafrom <- dtjoin(datafrom, lay)
    # data <- data[, c("CP", "CPid", "CCM", "Copy", "Library", "Collection", paste0(c("row", "col", "Q"), to)), with=F]
    datafrom <- datafrom[, c(oriname, p0(c("row", "col", "Q"), to)), with=F]
    setnames(datafrom, p0(c("row", "col", "Q"), to), c("row", "col", "Q"))
    datafrom[, Format := to.num]
    
  } else {
    
    datato[, Q := NULL]
    
    datafrom[, Q := factor(Q, levels = 1:16)]
    setnames(datafrom, c("row", "col", "Q"), p0(c("row", "col", "Q"), from))
    datafrom <- dtjoin(datafrom, lay)
    # data <- data[, c("CP", "CPid", "CCM", "Copy", "Library", "Collection", paste0(c("row", "col", "Q"), to)), with=F]
    datafrom <- datafrom[, c(oriname, p0(c("row", "col"), to)), with=F]
    setnames(datafrom, c(p0(c("row", "col"), to)), c("row", "col"))
    datafrom[, Format := to.num]
    
    
    
  }
  
  # combine when 2 different format
  if( nrow(datato) != 0 ) {
    data <- rbind(datafrom, datato)
  } else {
    data <- datafrom
  }
  
  
  ColRowFactor(data)
  if( "Q" %in% names(data)) {
    data[, Q := as.integer(levels(Q))[Q]]
  }
  return(data)
  
}

turnMapping <- function(datain, format) {
  
  debug.easy(missing(format), "Please define a format, should a string: 96, 384 or 1536")
  
  dataout <- copy(datain)
  
  
  
  if(format == "384") {
    fake <- data.table(col = factor(rep(1:24, each=16)),
                       row = factor(rep(LETTERS[1:16], 24), levels=LETTERS[16:1]))
  } 
  if(format == "1536") {
    fake <- data.table(col = factor(rep(1:48, each=32)),
                       row = factor(rep(c(paste0("A", LETTERS[6:1]), LETTERS[26:1]),48), levels=c(paste0("A", LETTERS[6:1]), LETTERS[26:1])))
  } 
  if(format == "96") {
    fake <- data.table(col = factor(rep(1:12, each=8)),
                       row = factor(rep(LETTERS[1:8], 12), levels=LETTERS[8:1]))
  } 
  
  dataout[, row := unique(fake$row)[match(row, rev(unique(fake$row)))]]
  dataout[, col := rev(unique(fake$col))[as.numeric(col)]]
  
  return(dataout)
  
}  





# LDC and CD3
CD3output <- function(DATA, # filtered data to use (only the data needed, so good QC and so on, actually what you wanna send to the client)
                      wdfunction = wd2, # path of the where the output will be created
                      datavalue, # vector of string names regarding variable you wanna export in the data e.g.: c("Value.NPA", "OD", "ODcorFI", "FI")
                      filenamecol="AP", # which variable should be used to create the filename for the output
                      namelayout = "Project_Assay_format.csv",
                      outputdata = F, # if T will create outputdata
                      outputmapping = F, # if T will generate the mapping
                      outputlayout = F, # if T will create a layout information file
                      Concentration_M, # must be specified or you have a 'CCM' columns in your data, take care that this shjuold be the end concentration
                      turn.mapping, # T if you wanna turn the mapping
                      format, # 96, 384, 1536 for turn.mapping
                      output.name # define output name if you turn mapping for example
) {
  
  data <- copy(DATA)
  
  debug.easy(missing(turn.mapping), "You need to define if you wanna turn the mapping or not.")
  create.dir(wdfunction, "Mapping_Check", "wdmapcheck")
  
  
  
  # check columns names
  cat("---------------------------------------------\nOutput for CD3 (SOP). Use LDC = T if it is for LDC\n---------------------------------------------\n\n")
  cat("Control information will be removed in the .map files.\n")
  cat("Data: 1 file per", filenamecol, "will be created.\n\n")
  
  debug.easy(length(unique(data$CPid)) < 10, "Your mapping is wrong you less than 10 compounds ...")
  
  
  # mapping
  if( outputmapping )
  {
    
    if( turn.mapping ) {
      debug.easy(missing(format), "You need to define if you wanna turn the mapping or not.")
      debug.easy(missing(output.name), "You wanna turn the mapping, define an output.name, for writing it in a DB e.g.")
      cat("Are you sure that you wanna turn the mapping ? ")
      WaitYesNo()
      
      data2 <- turnMapping(data, format)
      
      temp <- rbind(data2[AP == unique(AP)[1]], data[AP == unique(AP)[1]])
      temp <- ColRowFactor(temp)
      
      a <- ggplot(temp, aes(col, row))+
        geom_line(aes(group = CPid))+
        labs(title = basename(wdfunction))
      print(a)
      
      cat("[USER INPUT] - Is the mapping turned ? ")
      WaitYesNo()
      printfast(a, p0(wdmapcheck, "/CHECK_Turn.jpg"), 300, 450)
      
      data <- data2
      rm(data2, temp, a)
      
      cat("\n[INFO] - Mapping was turned\n")
      cat("\n[INFO] - Mapping was turned\n")
      cat("\n[INFO] - Mapping was turned\n")
    }
    
    assign(output.name, data, env = .GlobalEnv)
    cat("\n\n[INFO] - Object '", output.name,"' assigned\n\n")
    
    
    
    create.dir(wdfunction, "Mapping", "wdmap")
    
    lay <- data.table(Well_ID = paste0(rep(LETTERS[1:16],24), formatC(as.numeric(rep(1:24, each=16)), width = 2, flag = "0")))
    
    if( is.factor(data$col) ) {
      data[, col := as.numeric.factor(col)]
    } else {
      data[, col := as.numeric(col)]
    }
    data[, Well_ID := paste0(row, formatC(col, width = 2, flag = "0"))]
    data[, Concentration_unit := "M"]
    
    
    if( any(names(data) == "CCM") ) {
      cat("\nCCM column found. This one should be in M !!!!!!\nPLEASE CHECK !!!\nPLEASE CHECK !!!\nPLEASE CHECK !!!\nCHECK IF THERE IS MORE THAN 1 CCM in the original data (CIS Library)... \n\n")
      data[, Concentration := CCM]
    } else {
      cat("\nConcentration will be", Concentration_M, "for all cmpds.\nAre you sure that this is the END Concentration ?\n")
      data[, Concentration := Concentration_M]
    }
    
    
    temp <- data[!is.na(CPid), .(AP = get(filenamecol),
                                 Compound_ID = CPid,
                                 Well_ID,
                                 Concentration,
                                 Concentration_unit)]
    
    a <- qplot(temp[, .N, .(AP)]$N)+
      labs(title = "Histogram of the number of row per map file",
           subtitle = basename(wdfunction))
    print(a)
    cat("[USER INPUT] - Please check the graph and confirm that you want to continue.")
    WaitYesNo()
    printfast(a, p0(wdmapcheck, "/CHECK_Histo_mapfile.jpg"), 300, 450)
    rm(a)
    
    HM(data[!is.na(CPid), .N, .(row, col)], "N")
    a <- a + labs(title = "Coordinates frequency from CPid in mapfiles",
                  subtitle = basename(wdfunction))
    print(a)
    cat("[USER INPUT] - Frequency coordinates CPid ")
    WaitYesNo()
    printfast(a, p0(wdmapcheck, "/CHECK_Freq.jpg"), 300, 450)
    
    cat("\nThanks :)\n")
    
    # data for seq_alonig and name to keep dmso plates
    listAP <- unique(temp$AP)
    a <- sapply(seq_along(listAP),
                function (x) write.table(temp[AP == listAP[x]],
                                         paste0(listAP[x],
                                                ".map"),
                                         row.names=F,
                                         sep=","))
    
    
    
    
  }
  
  
  # data
  if( outputdata )
  {
    create.dir(wdfunction, "Data", "wddata")
    selectcol <- c(filenamecol, "Well_ID", "Session", "Date", datavalue)
    
    if (length(selectcol[!selectcol %in% names(data)]) > 0) {
      cat("\n [DEBUG] - Columns in your data missing : ", selectcol[!selectcol %in% names(data)])
    }
    
    temp <- data[, c(filenamecol, "Well_ID", "Session", "Date", datavalue), with = F]
    
    a <- qplot(temp[, .N, .(get(filenamecol))]$N)+
      labs(title = "Histogram of the number of row per data file",
           subtitle = basename(wdfunction))
    print(a)
    
    cat("[USER INPUT] - Please check the graph and confirm that you want to continue.")
    WaitYesNo()
    printfast(a, p0(wdmapcheck, "/CHECK_Histo_datafile.jpg"), 300, 450)
    cat("\nThanks :)\n")
    
    
    
    for(i in seq_along( unique( temp[,get(filenamecol)] ) ) ) {
      
      temp2 <- temp[get(filenamecol) == unique(temp[,get(filenamecol)])[i]]
      temp3 <- left_join(lay, temp2)
      temp3[, filenamecol] <- unique(temp2[, get(filenamecol)])
      temp3$Session <- unique(temp2$Session)
      
      if( length( unique(temp2$Date) ) > 1) {
        stop("[DEBUG] - You have 2 MeasTime for the AP ", unique(temp[,get(filenamecol)])[i], "\n", unique(temp2$Date))
      }
      
      temp3$Date <- unique(temp2$Date)
      
      write.csv(temp3,
                paste0(unique(temp[, get(filenamecol)])[i],
                       ".csv"),
                row.names=F)
      
    }
  }
  
  
  #layout
  if( outputlayout )
  {
    setwd(wdfunction)
    
    temp <- ddply(data, ~row+col+Control, nrow) %>%
      dplyr::select(Row = row,
                    Column = col,
                    Description = Control)
    temp$Description <- ifelse(temp$Description == "C", "SAMPLE",
                               ifelse(temp$Description == "P", "HIGH CONTROL",
                                      ifelse(temp$Description == "N", "LOW CONTROL",temp$Description)))
    temp <- subset(temp, is.na(Description) == F)
    write.csv(temp, namelayout, row.names=F)
  }
  
  
}


# Axxam
LDCMapping <- function(DATA, # filtered data to use (only the data needed, so good QC and so on, actually what you wanna send to the client)
                       wdfunction = wd2, # path of the where the output will be created
                       APvariable = "AP",
                       NameMappingFolder = "Mapping", # just the name of the folder where the mapping will be stored
                       format
) {
  
  create.dir(wdfunction, p0(NameMappingFolder, "_Check"), "wdmapcheck")
  create.dir(wdfunction, NameMappingFolder, "wdmap")
  
  
  data <- copy(DATA)
  debug.easy(!APvariable %in% names(data), "Your 'APvariable' is not in the data")
  debug.easy(!"CCM" %in% names(data), "You have no 'CCM' variable ... you need one.")
  debug.easy(nrow(data[, .N, .(CP, CPid, row, col, get(APvariable))][N > 1]) > 0, "You have duplicate CPid per plate")
  debug.easy(!format %in% c("96", "384", "1536"), "Your format should be 96, 384 or 1536 (as.character)")
  
  
  # Add DMSO
  fake <- CreateMTPLayout(format)
  fake <- Expand.table(fake, expand.vector = unique(data$AP), name.new.variable = "AP")
  data <- dtjoin(fake, data)
  data[is.na(CPid), CPid := "DMSO"]
  cat("\n\n[INFO] - DMSO added where there is no CPid\n\n")
  
  # Add WellID
  fake <- CreateMTPLayout("1536")
  fake <- ColRowFactor(fake, reverse.row = T)
  fake <- fake[order(row, col)][, WellID := 1:.N]
  
  data <- dtjoin(data, fake)
  data[, CCmM := CCM * 1000]
  
  
  
  data <- data[, .(BC = get(APvariable), row, col, WellID, CPid, CCmM)]
  data <- ColRowFactor(data, reverse.row = T)
  setorder(data, BC, row, col)
  
  a <- qplot(data[, .N, .(BC)]$N)+
    labs(title = "Histogram of the number of row per map file",
         subtitle = basename(wdfunction))
  print(a)
  
  cat("[USER INPUT] - Please check the graph and confirm that you want to continue.")
  WaitYesNo()
  printfast(a, p0(wdmapcheck, "/CHECK_Histo_mapfile.jpg"), 300, 450)
  rm(a)
  
  HM(data[, .N, .(row, col)], "N")
  a <- a + labs(title = "Coordinates frequency from CPid",
                subtitle = basename(wdfunction))
  print(a)
  cat("[USER INPUT] - Frequency coordinates CPid ")
  WaitYesNo()
  printfast(a, p0(wdmapcheck, "/CHECK_Freq.jpg"), 300, 450)
  
  cat("\nThanks :)\n")
  
  
  
  filenameout <- paste0(gettimestamp(), "_Mapping_TO-CONVERT-IN-XLSX.csv")
  write.csv(data, filenameout, row.names = F)
  replace.NA.csv(filenameout, "NA", "")
  
  assign("LDCmap", data, env = .GlobalEnv)
  cat("\n\n[INFO] - 'LDCmap' Robject assigned\n")
  
  
}


AxMapping <- function(DATA, # filtered data to use (only the data needed, so good QC and so on, actually what you wanna send to the client)
                      wdfunction = wd2, # path of the where the output will be created
                      VOLUMEul = 0, # final volume in ul in the plate, to correlate with CONCENTRATIONmM
                      CONCENTRATIONmM = NA, # final concentration in M
                      APvariable = "AP",
                      NameMappingFolder = "Mapping" # just the name of the folder where the mapping will be stored
) {
  
  create.dir(wdfunction, p0(NameMappingFolder, "_Check"), "wdmapcheck")
  create.dir(wdfunction, NameMappingFolder, "wdmap")
  
  data <- copy(DATA)
  debug.easy(!APvariable %in% names(data), "Your 'APvariable' is not in the data")
  debug.easy(nrow(data[, .N, .(CP, CPid, row, col, get(APvariable))][N > 1]) > 0, "You have duplicate CPid per plate")
  
  data[, WELL := paste0(row, col)]
  data[, VOLUMEuL := VOLUMEul]
  
  
  if( is.na(CONCENTRATIONmM) ) {
    if( any(names(data) == "CCM") ) {
      cat("\nCCM column found, will be use for CONCENTRATIONmM. This one should be in M !!!!!!\nPLEASE CHECK !!!\nPLEASE CHECK !!!\nPLEASE CHECK !!!\n")
      data[, CONCENTRATIONmM := CCM * 1e3]
    } else {
      stop("[DEBUG] - No 'CCM' variable found and no 'CONCENTRATIONmM' parameter give. Please make a choice.")
    }
  } else {
    cat("\nCONCENTRATIONmM will be", CONCENTRATIONmM, "for all cmpds.\n")
    data[, CONCENTRATIONmM := CONCENTRATIONmM]
  }
  
  
  data <- data[, .(AXXAMCODE = CPid, WELL, PLATE_BARCODE = get(APvariable), "CONCENTRATION mM" = CONCENTRATIONmM, "VOLUME uL" = VOLUMEuL)]
  
  a <- qplot(data[, .N, .(PLATE_BARCODE)]$N)+
    labs(title = "Histogram of the number of row per map file",
         subtitle = basename(wdfunction))
  print(a)
  cat("[USER INPUT] - Please check the graph and confirm that you want to continue.")
  WaitYesNo()
  printfast(a, p0(wdmapcheck, "/CHECK_Histo_mapfile.jpg"), 300, 450)
  rm(a)
  
  HM(data[, .N, .(row, col)], "N")
  a <- a + labs(title = "Coordinates frequency from CPid",
                subtitle = basename(wdfunction))
  print(a)
  cat("[USER INPUT] - Frequency coordinates CPid ")
  WaitYesNo()
  printfast(a, p0(wdmapcheck, "/CHECK_Freq.jpg"), 300, 450)
  cat("\nThanks :)\n")
  
  
  
  listplates <- unique(data$PLATE_BARCODE)
  for(i in seq_along(listplates)) {
    write.table(data[PLATE_BARCODE == listplates[i]],
                paste0(listplates[i], ".map"),
                row.names=F,
                sep="\t", quote=F)
  }
  
}



AxHama <- function (DATA = rawWPQC, # filtered data to use (only the data needed, so good QC and so on, actually what you wanna send to the client)
                    wdfunction = wdout, # path of the where the output will be created
                    wddata = wdout, # path where the data is, a bit complex, usually it is 'wdout' which is 'Output_Client' present in the Assay folder (e.g. TRPxx1/PrS/Output_Client), from there on the script know that in this assay folder are Session folder (e.g. TRPxx1/PrS/20180521_TRPxx1_PrS_5) and will then get the data inside. The script is finding the right file due to the variable 'pathfilename'.
                    Correction = NA, # data.table with row, col and coeff for correction (Camera Correction)
                    rowregex = "Lumi" # on which type of data the correction will be applied, string for grep the line with data a \t will be paste before this
) {
  
  if( !is.na(Correction) ) {
    
    namecoeff <- grepcol("row|col", Correction, rev = T)
    cat("----------------------------------------------\nA correction is used and a coefficient called:'", namecoeff, "'will be applied.\n----------------------------------------------\n\n")
    
  }
  
  create.dir(wdfunction, "RAW", "wdraw")
  
  if ( any(names(DATA) == "Containerid") ) {
    # for screening with containerid and sid
    DATA2 <- DATA[, .N, .(filename, AP, Containerid, Sid)]
    DATA2[, BC := paste0(AP, "_", Containerid)]
    ntosub <- 9
  } else {
    # for manual measurement
    DATA2 <- DATA[, .N, .(filename, AP)]
    DATA2[, ':=' (BC = AP, Sid = .I, Containerid = 1)]
    ntosub <- 10
  }
  
  for (i in seq_along(DATA2$filename) )
  {
    
    raw <- readLines(paste0(dirname(wddata),"/", DATA2$filename[i]))
    raw2 <- substr(raw, 2, nchar(raw))
    
    raw3 <- c("Version: POLARA 2.3",
              paste0("Date: ",
                     gsub("\"Date : \"\t\"([0-9]*)/([0-9]*)/([0-9]*)\"", "\\3.\\2.\\1", raw2[3]),
                     " ",
                     gsub("\"Time : \"\t\"(.*)\"", "\\1", raw2[4])),
              paste0("BarCode: ", DATA2$BC[i]),
              "Block: Multi",
              "Instrument: Hamamatsu",
              gsub("X:\\\\Data\\\\Thermo\\\\Hamamatsu\\\\RAWDATA",
                   "...",
                   paste0(gsub(" :",
                               ":",
                               gsub("\t",
                                    "",
                                    gsub("\"",
                                         "",
                                         substr(raw2[1], 1, nchar(raw2[1]) - ntosub )))),
                          DATA2$BC[i])),
              paste0("Comment: Sample=",DATA2$Sid[i], ", container=", DATA2$Containerid[i]),
              raw2[5:length(raw2)])
    
    if( !is.na(Correction) ) {
      
      part2 <- grep(paste0("\t", rowregex), raw3)
      debug.easy(length(part2) == 0, "There is a problem the 'rowregex' parameter did not find matching pattern.")
      part1 <- 1:(min(part2) - 1 )
      part3 <- (1 + max(part2):length(raw3)) 
      
      # select only data part and read as table
      part2a <- data.table(read.table(textConnection(raw3[part2])))
      part2b <- melt.data.table(part2a, c("V1", "V2"), variable.name = "Measure_n")
      part2b[, ':=' (col = gsub("(\\D*)(\\d*)", "\\2", V1),
                     row = gsub("(\\D*)(\\d*)", "\\1", V1))]
      part2b <- dtjoin(part2b, Correction)
      
      part2b[, valuec := value * get(namecoeff)] # apply coeff
      
      # # check
      # source("~/HTS/Data/R/Functions/Functions_Graphics_v47.R")
      # HM(Correction, namecoeff)
      # ggplot(part2b, aes(Measure_n, value, group = V1))+
      #   geom_line(color="black")+
      #   geom_line(color="red", aes(Measure_n, valuec, group = V1), alpha = 0.2)
      
      part2b <- dcast.data.table(part2b, V1+V2~Measure_n, value.var = "valuec")
      part2b <- part2b[match(part2a$V1, part2b$V1)] # order wellID
      
      write.table(part2b, "temp.txt", quote = F, sep="\t", row.names = F, col.names = F) # write lines to readLines afterwards
      part2c <- readLines("temp.txt")
      unlink("temp.txt")
      part2c <- sub("\t", "\t\t", part2c)
      
      
      
      raw3 <- c(raw3[part1], part2c, raw3[part3])
      
    }
    
    fileConn <- file(paste0(DATA2$BC[i], ".txt"))
    writeLines(raw3, fileConn)
    close(fileConn)
  }
  
}

create.cmt <- function(DATA, 
                       wdfunction,
                       one.file = T,
                       filename = "", 
                       var.AP = "AP",
                       CC = "uM" # use "uM", or "M"
) {
  
  # function to create 1 .cmt per AP for mapping
  setwd(wdfunction)
  
  DATA2 <- copy(DATA)
  DATA2[, row := match(row, LETTERS)]
  DATA2 <- DATA2[!is.na(CPid), .(get(var.AP), row, col, CPid, CCM)]
  
  debug.easy(!CC %in% c("M", "uM"), "CC is <> from 'uM' or 'M'. Other string are not allowed.")
  
  
  if( one.file ) {
    debug.easy(filename == "", "Give a filename please. 'one.file' is only if you wanna export 1 file only.")
    filename <- paste0(filename, ".cmt")
    write(p0("#Genedata Screener Condenser Mapping File\t\n#Version\t1.1\t\t\t\n#PlateFormat	16	24\t\n# ConcentrationUnit	", CC, "\t\t\t"), filename)
    write.table(DATA2, filename, row.names = F, quote = F, col.names = F, append = T, sep = "\t")
  } else {
    APloop <- unique(DATA[, get(var.AP)])
    for(i in seq_along(APloop)) {
      APloopi <- APloop[i]
      filenameout <- paste0(APloopi, ".cmt")
      temp <- DATA2[get(var.AP) == APloopi]
      write(p0("#Genedata Screener Condenser Mapping File\t\n#Version\t1.1\t\t\t\n#PlateFormat	16	24\t\n# ConcentrationUnit	", CC, "\t\t\t"), filenameout)
      write.table(temp, filenameout, row.names = F, quote = F, col.names = F, append = T, sep = "\t")
    }
    
  }
}


create.screener.input <- function(DATA, APvariable, value.var, wdfunction) {
  
  listAP <- unique(DATA[, get(APvariable)])
  setwd(wdfunction)
  
  for(i in seq_along(listAP) ) {
    temp <- data2[get(APvariable) == listAP[i]]
    temp[, WellID := p0(row, leading0(as.numeric(col), 2))]
    temp <- temp[, .(barcode = get(APvariable), WellID, value = get(value.var), MeasTime, Date)]
    write.csv(temp, p0(listAP[i], ".csv"), row.names=F, quote = F)
  }
  
}

# CRT
CRTmapping <- function(DATA, # filtered data to use (only the data needed, so good QC and so on, actually what you wanna send to the client)
                       wdfunction = wd2, # path of the where the output will be created
                       VOLUMEul = 0, # final volume in ul in the plate, to correlate with CCuM
                       CCuM = 0, # final concentration in uM
                       NameMappingFolder = "Mapping", # just the name of the folder where the mapping will be stored
                       PathControlLayout = "~/HTS/Data/Thermo/Echo/ARP_CRT2018/CPidmapping/CRT_Control_layout.csv" # path of the control layout, it will have to be applied to each plate, before exporting it.
) {
  
  create.dir(wdfunction, NameMappingFolder, "wdmap")
  
  # layout
  cat('You use the PathControlLayout', PathControlLayout, "are you sure about this ???? \n")
  cat('You use the PathControlLayout', PathControlLayout, "are you sure about this ???? \n")
  cat('You use the PathControlLayout', PathControlLayout, "are you sure about this ???? \n")
  Clay <- ReadSingleLayout(PathControlLayout)
  Clay[, ':=' (LayoutFile = NULL, BatchID = "-", ID = 1, CPid2 = CPid)]
  Clay <- Clay[!is.na(CPid)]
  
  temp <- copy(DATA)
  temp <- temp[, .N, .(CP, AP, Project, mapfile, Copy, Library) ][, N := NULL]
  temp[, ID := 1]
  
  temp <- dtjoin(temp, Clay)
  temp[, ID := NULL]
  
  
  # continue
  data2 <- copy(DATA)
  data2 <- data2[!is.na(CPid)]
  data2[, CPid2 := gsub("(.*)_(.*)", "\\1", CPid)]
  data2[, BatchID := gsub("(.*)_(.*)", "_\\2", CPid)]
  
  data2 <- rbind(data2, temp, fill=T)
  
  data2[, WELL := paste0(row, col)]
  data2[, VOLUMEuL := VOLUMEul]
  data2[, DMSO := "-"]
  data2[, ID := 1]
  
  
  
  if( any(names(data2) == "CCM") )
  {
    cat("\nCCM column found, will be use for 'Compound Concentration uM'. This one should be in M !!!!!!\nPLEASE CHECK !!!\nPLEASE CHECK !!!\nPLEASE CHECK !!!\n")
    data2[, CCuM := CCM * 1e6]
  } else {
    cat("\nCCuM will be", CCuM, "for all cmpds.\n")
    data2[, CCuM := CCuM]
  }
  
  data2 <- dplyr::select(data2,
                         "Compound ID" = CPid2,
                         "Batch ID" = BatchID,
                         "Plate Barcode" = AP,
                         "Well Reference" = WELL,
                         "Compound Concentration uM" = CCuM,
                         "Compound Volume ul" = VOLUMEuL,
                         "Percent DMSO" = DMSO)
  
  write.table(data2, paste0(gettimestamp(), "_CRT-Mapping.txt"),
              row.names=F,
              sep="\t", quote=F)
  
  # a <- sapply(seq_along(unique(data$"Plate Barcode")),
  #             function (x) write.table(data[which(data$"Plate Barcode" == unique(data$"Plate Barcode")[x]), ],
  #                                      paste0(unique(data$"Plate Barcode")[x],
  #                                             ".txt"),
  #                                      row.names=F,
  #                                      sep="\t", quote=F))
  # 
}




ReadSingleLayout <- function(listcsv, NameColLayoutFile = "LayoutFile") {
  
  cat("\nYour csv file should countain 1 or x plate format matrix.\nWith always for a matrix:\n  - first col as name to give to the matrix and then the row letters\n  - first row the matrix name and then column numbers\n\n\n")
  
  lay <- data.table(read.csv(listcsv, h=F))
  listformat <- which(!lay[[1]] %in% c(LETTERS,""))
  listname <- lay[[1]][listformat]
  
  for(i in seq_along(listformat))
  {
    if(i != seq_along(listformat)[length(seq_along(listformat))]) {
      temp <- lay[(listformat[i]+1):(listformat[i+1]-1)]
    } else {
      temp <- lay[(listformat[i]+1):nrow(lay)]
    }
    
    temp <- suppressWarnings(melt.data.table(temp, id.vars=names(temp[,1])))
    names(temp) <- c("row", "col", paste0(listname[i]))
    temp[, col := as.numeric(gsub("V", "", col)) - 1]
    
    
    if( i == 1) {
      lay2 <- copy(temp)
    } else {
      lay2 <- data.table(left_join(lay2, temp))
    }
  }
  
  lay2$LayoutFile <- substr(basename(listcsv),1, nchar(listcsv)-4)
  lay2 <- renamecol(lay2, "LayoutFile", NameColLayoutFile)
  lay2[lay2 == ""] <- NA
  
  if(any(names(lay2) == "CCM")) {
    lay2[, CCM := as.numeric(CCM)]
  }
  
  lay2 <- ColRowFactor(lay2)
  
  
  return(lay2)
}

ReadLayout <- function(DATA, listcsv, add2data = F, NameColLayoutFile = "LayoutFile") {
  
  lay <- data.table()
  
  for(i in seq_along(listcsv)) {
    temp <- ReadSingleLayout(listcsv[i], NameColLayoutFile = NameColLayoutFile)
    
    if(i != 1 & ncol(temp) != ncol(lay)) {
      stop("[DEBUG] - You layout .csv have different numbers of variables")
    }
    
    lay <- rbind(lay, temp)
  }
  
  rm(temp)
  
  if( add2data == T) {
    
    lay <- ColRowFactor(lay)
    if( all( c("row", "col") %in% names(DATA))) {
      DATA <- ColRowFactor(DATA)
    }
    lay[, CP := gsub(".csv", "", LayoutFile)]
    
    temp <- dtjoin(DATA, lay)
    print(temp)
    
    cat(rep("[INFO] - Layout joined to the DATA.\n",3))
    
    return(temp)
    
  } else {
    
    print(lay)
    
    cat(rep("[INFO] - Return only the layout.\n",3))
    
    return(lay)
    
  }
  
  
}

CreateMTPLayout <- function(format = "384") {
  
  debug.easy(!is.character(format), "Your format parameter should a string: 96, 384 or 1536")
  debug.easy(!format %in% c("96", "384", "1536"), "Your format parameter should a string: 96, 384 or 1536")
  
  if(format == "384") {
    fake <- data.table(col = factor(rep(1:24, each=16)),
                       row = factor(rep(LETTERS[1:16], 24), levels=LETTERS[16:1]))
  } 
  if(format == "1536") {
    fake <- data.table(col = factor(rep(1:48, each=32)),
                       row = factor(rep(c(paste0("A", LETTERS[6:1]), LETTERS[26:1]),48), levels=c(paste0("A", LETTERS[6:1]), LETTERS[26:1])))
  } 
  if(format == "96") {
    fake <- data.table(col = factor(rep(1:12, each=8)),
                       row = factor(rep(LETTERS[1:8], 12), levels=LETTERS[8:1]))
  } 
  
  return(fake)
  
}

CheckBCLibrary <- function(BC) {
  
  readDB("Mapping_R", "CPidmapping")
  
  data[CP %in% BC, .N, .(CP, CCM, Copy, Library)]
  
  if(any(!BC %in% data$CP) ) {
    
    cat("\n\n[BECAREFUL] - BC not found : ")
    BC[which(!BC %in% data$CP)]
    
  }
  
}


readCPBCTracking <- function(wdfunction = "~/HTS/Data/CP_libraries/CPBCTracking") {
  
  setwd(wdfunction)
  filelist <- list.files(getwd(),pattern=".txt")
  tryCatch({
    temp <- lapply(filelist, fread, h=F)
  }, error=function(e) {
    stop("[DEBUG] - You have certainly 1 or more files empty. Please remove them.")
  })
  temp <- mapply(cbind, temp, ID=as.numeric(gsub("(.*)_(.*).txt", "\\2", filelist)), SIMPLIFY=F)
  temp <- rbindlist(temp)
  setnames(temp, "V1", "CP")
  
  CPlist <- temp[, .(MaxID = max(ID)), CP]
  
  assign("CPlist", CPlist, envir = .GlobalEnv)
  assign("CPlistall", temp, envir = .GlobalEnv)
  
  cat("Robjects 'CPlist' and 'CPlistall' assigned.\n")
  
}

# HCS  ---------------------------------------------------


create.xcopy.bat <- function(data, wdfunction, title="", source = "\\\\10.13.20.9\\OperaImages\\Screening\\", desti = "[DESTINATION]") {
  
  # xcopy
  setwd(wdfunction)
  listtocopy <- paste0("robocopy ",
                       source,
                       data$AP, "\\",
                       data$Expi,
                       "\\ ",
                       desti,
                       "\\",
                       data$AP,
                       "\\",
                       data$Expi,
                       "\\ /E /R:0 /W:0") 
  # /E : Copy Subfolders, including Empty Subfolders.
  # /ZB : Use restartable mode; if access denied use Backup mode.
  # /R:0 /W:0 : robocopy will only copy those files that have changed (change in time stamp or size.)
  # /LOG+:file : output status to LOG file (append to existing log).
  
  listtocopy <- listtocopy[!(duplicated(listtocopy))]
  write.table(listtocopy, paste0("ROBOCOPY_pictures",title,"_CHANGE-DESTINATION.txt"), row.names = F, quote = F, col.names = F)
  
}


SlurmList <- function(data, wdfunction = "~/HTS/TEMP/Dorian/SlurmList") {
  
  setwd(wdfunction)
  
  temp <- data[, filename] 
  temp <- unique(temp)
  temp <- gsub("/home/cellprofiler/CellProfiler/", "X:/", temp)
  temp <- gsub("/mnt/opera/", "X:/", temp)
  temp <- dirname(dirname(dirname(temp)))
  temp <- gsub("/", "\\\\", temp)
  
  write.table(temp, "SlurmList.txt", row.names = F, col.names = F, quote=F)
  cat("[INFO] - SlurmList.txt written in ", getwd())
  
}


addimgbalise <- function(vect, pisize=200) {
  
  vect <- paste0("<img src='", vect,"' width=", pisize, " />")
  return(vect)
  
}

base64 <- function(file) {
  return(mapply(image_uri, file, SIMPLIFY = T))
}


CellProfilerrawbind2 <- function(data=rawbind, onwhichcol = normalcol) {
  
  # Function to summarize object based data depending on the wish of the user.
  # data should be rawbind, object based data
  # onwhichcol should be normalcol and are all column that should be always in rawbind, no matter of the parameters set by the user.
  # [1] "col"             "row"             "CP"              "filename"        "AP"              "Experiment"      "Sample"          "DateMeasurement"
  # [9] "pathfilename"    "Date"            "Project"         "Assay"           "Session"         "CPstockCCM"      "CPendCCM"        "CPvolul"        
  # [17] "Assvolul"        "CC"              "Control"         "CPid"            "Addition"        "mapfile"   
  # extracol2 as output is used then for a next setp later for rawWP.
  
  data2 <- ddply(data, .variables = onwhichcol, summarize, nFields= sum(!is.na(Field)))
  
  if(any(is.na(colmean) == F)) {
    temp <- ddply(data, .variables = onwhichcol, 
                  colwise(mean, colmean, na.rm = TRUE))
    temp <- renamecol(temp, colmean, paste0(colmean, "Ave"))
    data2 <- cbind(data2, temp[,!(names(temp) %in% onwhichcol), drop=FALSE])
  }
  if(any(is.na(colsum) == F)) {
    temp <- ddply(data, .variables = onwhichcol, 
                  colwise(sum, colsum,na.rm = TRUE))
    temp <- renamecol(temp, colsum, paste0(colsum, "Sum"))
    data2 <- cbind(data2, temp[,!(names(temp) %in% onwhichcol), drop=FALSE])
  }
  if(any(is.na(colmin) == F)) {
    temp <- ddply(data, .variables = onwhichcol, 
                  colwise(min, colmin,na.rm = TRUE))
    temp <- renamecol(temp, colmin, paste0(colmin, "Min"))
    data2 <- cbind(data2, temp[,!(names(temp) %in% onwhichcol), drop=FALSE])
  }
  if(any(is.na(colmax) == F)) {
    temp <- ddply(data, .variables = onwhichcol, 
                  colwise(max, colmax,na.rm = TRUE))
    temp <- renamecol(temp, colmax, paste0(colmax, "Max"))
    data2 <- cbind(data2, temp[,!(names(temp) %in% onwhichcol), drop=FALSE])
  }
  if(any(is.na(colsd) == F)) {
    temp <- ddply(data, .variables = onwhichcol, 
                  colwise(sd, colsd,na.rm = TRUE))
    temp <- renamecol(temp, colsd, paste0(colsd, "Sdd"))
    data2 <- cbind(data2, temp[,!(names(temp) %in% onwhichcol), drop=FALSE])
  }
  if(any(is.na(colmedian) == F)) {
    temp <- ddply(data, .variables = onwhichcol, 
                  colwise(median, colmedian,na.rm = TRUE))
    temp <- renamecol(temp, colmedian, paste0(colmedian, "Med"))
    data2 <- cbind(data2, temp[,!(names(temp) %in% onwhichcol), drop=FALSE])
  }
  
  extracol2 <- names(data2)[!(names(data2) %in% onwhichcol)]
  # assign("extracol2", extracol2, envir = .GlobalEnv)
  # assign(outputdata, data2, envir = .GlobalEnv)
  
  return(data2)
  
  
}




PlateViewHTML <- function(wdimgout,
                          wdfunction,
                          patternlist = ".jpg",
                          regexjpeg = "([0-9]*)(.*)_(.*)",
                          regexposID = "\\1",
                          regexposWhat = "\\2",
                          regexposField = "\\3",
                          regexposZ = "\\3",
                          formulaPV = "row+Field~col+What",
                          pixelimg = 150,
                          forMAC = F,
                          filename,
                          hmvalue, # check PlateViewHTML.from.ready.data
                          same.scale.hm, # check PlateViewHTML.from.ready.data
                          base64 = F
) {
  setwd(wdfunction)
  # wdimgout <- "//10.13.20.9/OperaImages/Screening/AP_K2_0316/Meas_01(2016-12-22_15-27-59)/out"
  APBC <- basename(dirname(dirname(wdimgout)))
  Mea <- basename(dirname(wdimgout))
  if( nchar(APBC) > 20 )  {
    APBC <- basename(dirname(dirname(dirname(wdimgout))))
    Mea <- basename(dirname(dirname(wdimgout)))
  }
  
  
  # regexjpeg <- "([0-9]{6})([0-9]{4})_(.*)"
  listimg <- list.files(wdimgout, patternlist, full=T)
  listimg <- data.table(path = listimg)
  listimg[, ID := gsub(paste0(regexjpeg, patternlist), regexposID, basename(path))]
  listimg[, What := gsub(paste0(regexjpeg, patternlist), regexposWhat, basename(path))]
  listimg[, Field := as.numeric(gsub(paste0(regexjpeg,patternlist), regexposField, basename(path)))]
  listimg[, Z := as.numeric(gsub(paste0(regexjpeg,patternlist), regexposZ, basename(path)))]
  listimg[, row := LETTERS[as.numeric(substr(ID, 1, 3))]]
  listimg[, col := as.numeric(substr(ID, 4, 6))]
  
  unique(listimg$What)
  
  if( base64 ) {
    listimg[, code := base64(path)]
    listimg[, code := addimgbalise(code, pixelimg)]
  } else {
    listimg[, pathflex := p0(dirname(dirname(wdimgout)), "/", ID, ".flex")]
    
    listimg[, path := gsub("/home/cellprofiler/CellProfiler", "X:/", path)]
    listimg[, path := gsub("/mnt/opera", "X:/", path)]
    listimg[, path := gsub("/mnt/OperaImages", "X:/", path)]
    
    listimg[, pathflex := gsub("/home/cellprofiler/CellProfiler", "X:/", pathflex)]
    listimg[, pathflex := gsub("/mnt/opera", "X:/", pathflex)]
    listimg[, pathflex := gsub("/mnt/OperaImages", "X:/", pathflex)]
    
    if(forMAC == T) {
      listimg[, path := gsub("X:/", "file:///Volumes/OperaImages/", path)]
    }
    
    listimg[, code := addimgbalise(path, pixelimg)]
    listimg[, code := p0("<a href='", pathflex, "'>", code, "</a>")]
  }
  
  listimg[, code := p0(code, "<br>", row, col, "-", Field, "-", What)]
  
  
  
  
  
  
  
  assign("listimg", listimg, env = .GlobalEnv)
  
  
  if( missing(filename) ) { 
    filename <- p0(APBC, "____", Mea, filename)
  }
  
  
  if( missing(hmvalue) ) {
    PlateViewHTML.from.ready.data(listimg = listimg,
                                  formulaPV = formulaPV,
                                  filename = filename,
                                  wdfunction = wdfunction)
  } else {
    debug.easy(missing(same.scale.hm), "Your forgot to set 'same.scale.hm'")
    PlateViewHTML.from.ready.data(listimg = listimg,
                                  formulaPV = formulaPV,
                                  filename = filename,
                                  wdfunction = wdfunction,
                                  hmvalue = hmvalue,
                                  same.scale.hm = same.scale.hm)
  }
  
  
  
}


PlateViewHTML.from.ready.data <- function(listimg,
                                          formulaPV = "row+Field~col+What",
                                          filename,
                                          wdfunction,
                                          hmvalue, # string name of your column where you wanna add hm in the html
                                          same.scale.hm, # in combinaison with hmvalue to set the same scale for hm for all cell or per columns (T if same scale)
                                          base64 = F) {
  if( !missing( hmvalue ) ) {
    filename <- p0(filename, "___", hmvalue)
  }

  if( class(listimg$row) == "factor" ) {
    listimg[, row := as.character.factor(row)]
  }
  
  if( grepl("What", formulaPV) ) {
    
    listimg3 <- dcast.data.table(listimg, as.formula(formulaPV), value.var = "code")
    
    if( !missing(hmvalue) ) {
      ncolori <- ncol(listimg3)
      listimg3 <- dcast.data.table(listimg, as.formula(formulaPV), value.var = c("code", hmvalue))
      ncolnew <- ncol(listimg3)
    }
    
    listimg3 <- rbindlist(list(listimg3, as.list(colnames(listimg3)))) # put again name of columns at the end		
    namehtml <- paste0(filename)
    
    if( missing(hmvalue) ) {
      write.html.link(data = listimg3, filename = namehtml, caption = paste0(namehtml, " - ", formulaPV), wdfunction = wdfunction)
    } else {
      write.html.link(data = listimg3, filename = namehtml, caption = paste0(namehtml, " - ", formulaPV), wdfunction = wdfunction,
                      colID.hmvalue = (ncolori + 1):ncolnew,
                      same.scale.hm = same.scale.hm)
    }
    
    
  } else {
    
    for(i in seq_along(unique(listimg$What))) {
      
      listimg3 <- dcast.data.table(listimg[What == unique(What)[i]], as.formula(formulaPV), value.var = "code")

      
      if( !missing(hmvalue) ) {
        ncolori <- ncol(listimg3)
        listimg3 <- dcast.data.table(listimg[What == unique(What)[i]], as.formula(formulaPV), value.var = c("code", hmvalue))
        ncolnew <- ncol(listimg3)
      } 
      
      listimg3 <- rbindlist(list(listimg3, as.list(colnames(listimg3)))) # put again name of columns at the end		
      namehtml <- paste0(filename, "___", unique(listimg$What)[i])
      # write_tableHTML(tableHTML(listimg3,
      #                           rownames = FALSE,
      #                           caption = namehtml,
      #                           theme="default"), file = paste0(namehtml, '.html')) 
      if( missing(hmvalue) ) {
        
        write.html.link(data = listimg3, filename = namehtml, caption = paste0(namehtml, " - ", formulaPV), wdfunction = wdfunction)
        
      } else {
        
        write.html.link(data = listimg3, filename = namehtml, caption = paste0(namehtml, " - ", formulaPV), wdfunction = wdfunction, 
                        colID.hmvalue = (ncolori + 1):ncolnew,
                        same.scale.hm = same.scale.hm)
        
      }
      
    }
  }
  
}


  


FlexMetadata <- function( path ) {
  
  # Function that need as input a flexfile and will extract all info in it that could be interesting :
  # Camera1 Camera2 Camera3 Primary_Dichro Detect_Dichro Laser_1_488 Laser_2_532 Laser_3_635 Laser_4_405                Objective     Opera
  # 1:  455/70  565/50  690/50    405/532/635           510          NA        1890          NA        1140 20x_Air_LUCPLFLN_NA=0.45 OPERA3557
  # PlateType
  # 1: 384_Greiner_uclear
  
  # read 3rd line of the flex
  temp <- readLines(list.files(path, pattern = ".flex", full=T)[1], n = 4, skipNul = T)
  temp <- temp[grep("Root", temp)]
  
  data <- data.table() # create end object
  
  # get info filters
  temp1 <- extractXML(temp, "//*/FLEX/FilterCombinations/FilterCombination/SliderRef", transpo = T)
  temp1[, name := NULL]
  temp2 <- extractXML(temp, "//*/FLEX/FilterCombinations/FilterCombination", transpo = T)
  temp1[, FilterCombinationRef := rep(gsub("F_Sample_", "Exp", temp2$ID), each = 5)]
  temp1[, ID := gsub("_", "", ID)]
  temp1[, Info := paste0(ID, "_", Filter)]
  temp1 <- dcast.data.table(temp1, ID~FilterCombinationRef, value.var = "Info")
  temp1[, ID := NULL]
  Filterdt <- copy(temp1)
  
  
  
  
  # get info laser
  temp1 <- extractXML(temp, "//*/FLEX/LightSourceCombinations/LightSourceCombination", transpo = T)
  temp1[, name := NULL]
  temp2 <- extractXML(temp, "//*/FLEX/LightSourceCombinations/LightSourceCombination/LightSourceRef", transpo = T)
  temp2[, Exp := gsub("LS_Sample_", "Exp", temp1$ID)]
  temp2[, name := NULL]
  setnames(temp2, "ID", "Laser")
  setnames(temp2, "Power", "PoweruW")
  temp2[, Laser := gsub("_", "", Laser)]
  temp3 <- dtjoin(temp2, data.table(Laser = paste0("Laser", 1:4), WaveLength = c(488, 532, 635, 405)))
  temp3[, PoweruW := as.numeric(PoweruW) * 1e6]
  temp3[, Info := paste0(Laser,"_", WaveLength,"_", PoweruW)]
  temp3[, ID := seq_len(.N), Exp]
  temp4 <- dcast.data.table(temp3, ID~Exp, value.var = "Info")
  temp4[, ID := NULL]
  Laserdt <- copy(temp4)
  
  all <- rbind(Filterdt, Laserdt, fill=T)
  
  data <- all[1]
  data[, Exp1 := paste0(all$Exp1, collapse = "_")]
  data[, Exp2 := paste0(all$Exp2, collapse = "_")]
  data[, Exp3 := paste0(all$Exp3, collapse = "_")]
  data[, Exp4 := paste0(all$Exp4, collapse = "_")]
  
  
  data[, Objective := unique(extractXML(temp, "//*/ObjectiveRef", transpo = T)$text)]
  data[, Opera := extractXML(temp, "//*/FLEX", transpo = T)$OperaDevice]
  data[, PlateType := extractXML(temp, "//*/PlateName", transpo = T)$text]
  
  return(data)
  
}





