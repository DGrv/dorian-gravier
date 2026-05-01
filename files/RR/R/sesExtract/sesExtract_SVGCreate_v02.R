
# Plots -------------------------------------------------------------------

# if( !exists("nylabel") ) {
#   nylabel <- 0
# }
# if( !exists("breaksx") ) {
#   breaksx <- 10
# }






lcolor <- rep(c("#FFFF00", "#0000FF", "#00FF00", "#FF0000", "#FF6600", "#6600FF", "#FF0066"),10)
create.dir(wd, "svg", "wdsvg")

if( length(grepcol("Split", data))== 0) {
  data[, Split := ""]
}
if( length(grepcol("Split", ll))== 0) {
  ll[, Split := ""]
}


svgall <- c()
svgallblack <- c()

if( !all(is.na(data[ele != 0]$ele)) ) {
  
  
  for(i in 1:max(ll$Contest)) {
    
    if( nrow(ll[Contest == i]) > 0 ) {
    
      gpxdata <- data[ContestName == ll[Contest == i]$ContestName]
      
      # to have clean borders
      gpxdata <- rbind(gpxdata[1], gpxdata, gpxdata[nrow(gpxdata)])
      gpxdata[2, ele := gpxdata$ele[3]]
      gpxdata[(nrow(gpxdata)-1), ele := gpxdata$ele[(nrow(gpxdata)-2)]]
      gpxdata[, ele := round(ele)]
      
      
      # Create the elevation profile plot
      p <- ggplot(gpxdata, aes(x = dist, y = ele)) +
        geom_polygon(fill=lcolor[i])+
        geom_line(linewidth = 0.2)+
        geom_point(data=data[ContestName == ll[Contest == i]$ContestName][Split!=""], size=3)+
        geom_label_repel(data=data[ContestName == ll[Contest == i]$ContestName][Split!=""],aes(label = Split), vjust = 0, hjust= 0, nudge_y = ll[Contest == i]$nylabel, nudge_x=ll[Contest == i]$nxlabel, direction = "y", size=3)+
        scale_x_continuous(expand = c(0, 0), 
                           limits = c(0, NA),
                           breaks = seq(0, max(data$dist), by = ll[Contest == i]$breaksx))+  # Remove space before 0 on x-axis
        labs(x = "Km", y = "Elevation (m)", title=ll[Contest == i]$ContestName)+
        theme(
          plot.margin = margin(r=10, t=10), # default = margin(t = 5.5, r = 5.5, b = 5.5, l = 5.5, unit = "pt")
          axis.ticks.length = unit(0.1, "inches"),
          text = element_text(color = "black"),
          axis.text.y = element_text(colour = "black"),
          axis.text.x = element_text(colour = "black"),
          axis.ticks.y = element_line(color = "black"),
          axis.ticks.x = element_line(color = "black"))
      
      minele <- min(gpxdata[ele != 0]$ele)
      maxele <- max(gpxdata$ele)
      if( maxele > 500 & minele > 300 ) {
        ylim2 <- round(minele - minele*0.1, -2)
        p <- p + coord_cartesian(ylim=c(ylim2, NA))
      } else {
        p <- p + scale_y_continuous( # avoid small gap at 0 
          expand = expansion(mult = c(0, 0.000005)), # 0 at bottom, small top padding
          limits = c(0, NA)                       # start at 0, let top be automatic
        )
      }
      
      p2 <- p + theme(
        text = element_text(color = "white"),
        axis.text.y = element_text(colour = "white"),
        axis.text.x = element_text(colour = "white"),
        axis.ticks.y = element_line(color = "white"),
        axis.ticks.x = element_line(color = "white"))
      
      # Save as SVG
      ggsave(p0(ll[Contest == i]$ContestName,".svg"), plot = p2, device = "svg", width = 4000, height = 1000, units = "px")
      ggsave(p0(ll[Contest == i]$ContestName,"Black.svg"), plot = p, device = "svg", width = 4000, height = 1000, units = "px")
      
      
      # Modification  ------------------------------------------------------------------
      
      
      t <- readLines(p0(ll[Contest == i]$ContestName,".svg"))
      t <- gsub(lcolor[i], p0("url(#linear-gradient", i, ")"), t)
      t <- gsub('"', "'", t)
      t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)
      t <- c(t[1:2], p0("<defs><linearGradient id='linear-gradient", i, "' x1='0%' x2='", '"&[GradientLimit(', ll[Contest == i]$Contest, ')]&"%', "' y1='0%' y2='0%'><stop offset='100%' stop-color='", ll[Contest == i]$ColorCID, "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.2)'></stop></linearGradient></defs>"), t[3:length(t)])
      t <- gsub("<rect width='100%' height='100%' style='stroke: none; fill: #FFFFFF;'/>", "<rect width='100%' height='100%' style='stroke: none; fill: none;'/>", t)
      t <- gsub("<rect x='(.*)' y='(.*)' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: #FFFFFF; fill: #FFFFFF;' />",
                "<rect x='\\1' y='\\2' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: none; fill: none;' />", t)
      t <- gsub("'Arial';", "'urw-din, Arial, Helvetica, sans-serif';", t)
      
      
      write.table(t, p0(ll[Contest == i]$ContestName,".svg"), row.names = F, col.names = F, quote = F)
      svgall <- c(svgall,   paste0(t, collapse=""))
      
      t <- readLines(p0(ll[Contest == i]$ContestName,"Black.svg"))
      t <- gsub(lcolor[i], p0("url(#linear-gradient", i, ")"), t)
      t <- gsub('"', "'", t)
      t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)
      t <- c(t[1:2], p0("<defs><linearGradient id='linear-gradient", i, "' x1='0%' x2='", '"&[GradientLimit(', ll[Contest == i]$Contest, ')]&"%', "' y1='0%' y2='0%'><stop offset='100%' stop-color='", ll[Contest == i]$ColorCID, "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.2)'></stop></linearGradient></defs>"), t[3:length(t)])
      t <- gsub("<rect width='100%' height='100%' style='stroke: none; fill: #FFFFFF;'/>", "<rect width='100%' height='100%' style='stroke: none; fill: none;'/>", t)
      t <- gsub("<rect x='(.*)' y='(.*)' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: #FFFFFF; fill: #FFFFFF;' />",
                "<rect x='\\1' y='\\2' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: none; fill: none;' />", t)
      t <- gsub("'Arial';", "'urw-din, Arial, Helvetica, sans-serif';", t)
    
      write.table(t, p0(ll[Contest == i]$ContestName,"Black.svg"), row.names = F, col.names = F, quote = F)
      svgallblack <- c(svgallblack,   paste0(t, collapse=""))
      
    } else {
      
      t <- ""
      svgall <- c(svgall,   paste0(t, collapse=""))
      svgallblack <- c(svgallblack,   paste0(t, collapse=""))
      
    }
    
  }
  
  # UDF ---------------------------------------------------------------------
  
  svgallUDF <- copy(svgall)
  svgallblackUDF<- copy(svgallblack)
  svgallUDFcheck <- copy(svgall)
  svgallblackUDFcheck <- copy(svgallblack)
  
  # I change it here on 20260501 not sure it works 
  # I change it here on 20260501 not sure it works 
  # I change it here on 20260501 not sure it works 
  # I change it here on 20260501 not sure it works 
  # I change it here on 20260501 not sure it works 
  # I change it here on 20260501 not sure it works 
  
  startDivString <- '"<div id=""elevation_chart"" style=""100%"">'
  endDivString <- '</div>"'
  
  # UDF for small amount of Contest
  svgallUDF <- paste0(c(startDivString, '" & choose([x];"', paste0(svgallUDF, collapse='"; "'),  '")& "', endDivString), collapse="")
  svgallblackUDF <- paste0(c(startDivString, '" & choose([x];"', paste0(svgallblackUDF, collapse='"; "'), '")& "', endDivString), collapse="")

  svgallUDFcheck <- paste0(c(startDivString, paste0(svgallUDFcheck, collapse='<br>'),  endDivString), collapse="")
  svgallblackUDFcheck <- paste0(c(startDivString, paste0(svgallblackUDFcheck, collapse='<br>'),   endDivString), collapse="")
  
  UDF <- c("svg(x)", svgallUDF, "svgblack(x)" , svgallblackUDF, "svgCHECK", svgallUDFcheck, "svgblackCHECK", svgallblackUDFcheck)
  
  writeLines(UDF, "UDF.ada")
  
  
  # UNtil here ---------------------
  
  
  
  # UF for big amount of Contest
  UDF2 <- data.table(Contest = 1:max(ll$Contest), What = rep(c("svg", "svgblack"), each = max(ll$Contest)))
  UDF2[, Name := p0(What, Contest)]
  UDF2[, code := c(svgall, svgallblack)]
  UDF2[, todelete := F]
  UDF2[code == "", todelete := T]
  UDF2[, code := p0(startDivString, code, endDivString)]
  
  UDF2 <- rbind(data.table(Contest="", What="", Name="svg(x)",   code=p0('choose([x];[', paste0(UDF2[What == "svg"]$Name, collapse = ']; ['), '])')
                           , todelete=F), UDF2)
  UDF2 <- rbind(data.table(Contest="", What="", Name="svgblack(x)",   code=p0('choose([x];[', paste0(UDF2[What == "svgblack"]$Name, collapse = ']; ['), '])&"'),  todelete=F), UDF2)
  
  UDF2 <- rbind(data.table(Contest="", What="", Name="svgcheck",   code=p0('[', paste0(UDF2[What == "svg"]$Name, collapse = ']&"<br>"& ['), ']'),  todelete=F), UDF2)
  UDF2 <- rbind(data.table(Contest="", What="", Name="svgblackcheck",   code=p0('[', paste0(UDF2[What == "svgblack"]$Name, collapse = ']&"<br>"& ['), ']'),  todelete=F), UDF2)
  
  UDF2 <- UDF2[todelete != TRUE]
  
  writeLines(UDF2$Name, "UDF_for_lot_of_contest.ada")
  write(UDF2$code, "UDF_for_lot_of_contest.ada", append=TRUE)
  
  
  # write check local
  svgallblackUDFchecklocal <- paste0(c('<div id="elevation_chart style="100%>', paste0(gsub('"&\\[GradientLimit.*?\\]&"', "50", svgallblack), collapse='<br>'),  '</div>'), collapse="")
  writeLines(svgallblackUDFchecklocal, "test.html")
  for(i in 1:length(svgallblack) ) {
    temp <- svgallblack[i]
    writeLines(temp, p0(ll[Contest == i]$ContestName, "Black_Test_local.html"))
  }
  
  
  
  
  
  
  
  
  cat(green("--- END ---"))
  
  
} else {
  cat(red("\n[DEBUG] - No elevation for svg profile\n\n"))
  
}

