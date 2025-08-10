




# SETUP -------------------------------------------------------------------

suppressWarnings(suppressMessages(library(geosphere)))
suppressWarnings(suppressMessages(library(svglite)))  # To save as SVG
suppressWarnings(suppressMessages(library(ggrepel)))



# Plots -------------------------------------------------------------------

# if( !exists("nylabel") ) {
#   nylabel <- 0
# }
# if( !exists("breaksx") ) {
#   breaksx <- 10
# }

lcolor <- c("#FFFF00", "#0000FF", "#00FF00", "#FF0000", "#FF6600", "#6600FF", "#FF0066")
create.dir(wd, "svg", "wdsvg")


for(i in seq_along(ll$ContestName)) {
  # Create the elevation profile plot
  p <- ggplot(data[ContestName == ll$ContestName[i]], aes(x = dist, y = ele)) +
    geom_polygon(fill=lcolor[i])+
    geom_line(linewidth = 0.2)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*1), x = dist - (0.005*1)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*2), x = dist - (0.005*2)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*3), x = dist - (0.005*3)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*4), x = dist - (0.005*4)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*5), x = dist - (0.005*5)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*6), x = dist - (0.005*6)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*7), x = dist - (0.005*7)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*8), x = dist - (0.005*8)), size = 0.1)+
    # geom_line(aes(y=ylim1 + (ele-ylim1)*(0.1*9), x = dist - (0.005*9)), size = 0.1)+
    theme(
      # panel.border = element_blank(),
      # panel.grid.major = element_blank(),
      # panel.grid.minor = element_blank(),
      # plot.background = element_rect(fill = "#353535", color = "#353535"),
      # panel.background = element_rect(fill = "#353535"),
      axis.ticks.length = unit(0.1, "inches"))+
    theme(plot.margin = margin(r=10, t=10))+ # default = margin(t = 5.5, r = 5.5, b = 5.5, l = 5.5, unit = "pt")
    geom_point(data=data[ContestName == ll$ContestName[i]][Split!=""], size=3)+
    geom_label_repel(data=data[ContestName == ll$ContestName[i]][Split!=""],aes(label = Split), vjust = 0, hjust= 0, nudge_y = ll$nylabel[i], nudge_x=ll$nxlabel[i], direction = "y", size=3)+
    scale_x_continuous(expand = c(0, 0), limits = c(0, NA), breaks = seq(0, max(data$dist), by = ll$breaksx[i]))+  # Remove space before 0 on x-axis
    labs(x = "Km", y = "Elevation (m)", title=ll$ContestName[i])
  p
  
  if( exists("ylim2") ) {
    p <- p+coord_cartesian(ylim=c(NA, ylim2))
  }
  p
  p2 <- p + theme(
    text = element_text(color = "white"),
    axis.text.y = element_text(colour = "white"),
    axis.text.x = element_text(colour = "white"),
    axis.ticks.y = element_line(color = "white"),
    axis.ticks.x = element_line(color = "white"))
  p2
  
  # Save as SVG
  ggsave(p0(ll$ContestName[i],".svg"), plot = p2, device = "svg", width = 4000, height = 1000, units = "px")
  ggsave(p0(ll$ContestName[i],"Black.svg"), plot = p, device = "svg", width = 4000, height = 1000, units = "px")
  
  
  # Modification  ------------------------------------------------------------------
  
  
  t <- readLines(p0(ll$ContestName[i],".svg"))
  t <- gsub(lcolor[i], p0("url(#linear-gradient", i, ")"), t)
  t <- gsub('"', "'", t)
  t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)
  t <- c(t[1:2], p0("<defs><linearGradient id='linear-gradient", i, "' x1='0%' x2='", '"&[GradientLimit(', ll$Contest[i], ')]&"%', "' y1='0%' y2='0%'><stop offset='100%' stop-color='", ll$color[i], "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.2)'></stop></linearGradient></defs>"), t[3:length(t)])
  t <- gsub("<rect width='100%' height='100%' style='stroke: none; fill: #FFFFFF;'/>", "<rect width='100%' height='100%' style='stroke: none; fill: none;'/>", t)
  t <- gsub("<rect x='(.*)' y='(.*)' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: #FFFFFF; fill: #FFFFFF;' />",
            "<rect x='\\1' y='\\2' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: none; fill: none;' />", t)
  
  write.table(t, p0(ll$ContestName[i],".svg"), row.names = F, col.names = F, quote = F)
  
  t <- readLines(p0(ll$ContestName[i],"Black.svg"))
  t <- gsub(lcolor[i], p0("url(#linear-gradient", i, ")"), t)
  t <- gsub('"', "'", t)
  t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)
  t <- c(t[1:2], p0("<defs><linearGradient id='linear-gradient", i, "' x1='0%' x2='", '"&[GradientLimit(', ll$Contest[i], ')]&"%', "' y1='0%' y2='0%'><stop offset='100%' stop-color='", ll$color[i], "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.2)'></stop></linearGradient></defs>"), t[3:length(t)])
  t <- gsub("<rect width='100%' height='100%' style='stroke: none; fill: #FFFFFF;'/>", "<rect width='100%' height='100%' style='stroke: none; fill: none;'/>", t)
  t <- gsub("<rect x='(.*)' y='(.*)' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: #FFFFFF; fill: #FFFFFF;' />",
            "<rect x='\\1' y='\\2' width='960.00' height='240.00' style='stroke-width: 1.07; stroke: none; fill: none;' />", t)
  
  write.table(t, p0(ll$ContestName[i],"Black.svg"), row.names = F, col.names = F, quote = F)
  
}


cat(green("--- END ---"))
