

# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/'
# Sys.setlocale('LC_ALL', 'German')

suppressWarnings(suppressMessages(source(paste0(rootpath, "BM_Function_v01.r"), encoding="utf-8")))


wd <- rP("file:///C:/Users/doria/Downloads/gdrive/RR/2025/20250404__OFFA/Code/")
setwd(wd)

lcolor <- c("#FFFF00", "#0000FF", "#00FF00", "#FF0000", "#FF6600", "#6600FF")


# Plot the progress bar
p <- ggplot() +
  geom_bar(aes(x = 1, y = 1), stat = "identity", width = 0.5, colour="white", fill = lcolor[1]) +
  # scale_fill_manual(values = c("Remaining" = alpha("#353535", 0.2), "Completed" = lcolor[1])) +
  coord_flip() +  # Flip to horizontal
  labs(y="Progess")+
  noYlabel()+
  theme(legend.position = "none")+
  scale_y_continuous(labels = scales::percent, limits = c(0,1))+
# Remove panel borders and grid lines
  theme(panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_rect(fill = "#353535", color = "#353535"),
        panel.background = element_rect(fill = "#353535"),
        text = element_text(color = "white"),
        axis.text.x = element_text(colour = "white"),
        axis.ticks.x = element_line(color = "white", size=2),
        axis.ticks.length = unit(0.1, "inches"))
  # theme_void() +  # Remove background elements
p


ggsave("temp.svg", plot = p, device = "svg", width = 2500, height = 500, units = "px")

# Modification  ------------------------------------------------------------------


t <- readLines("temp.svg")
t <- gsub('"', "'", t)

i <- 1
t %like% lcolor[i]
t <- gsub(lcolor[i], p0("url(#linear-gradient", i, ")"), t)
t <- c(t[1:2], p0("<defs><linearGradient id='linear-gradient",
                  i,
                  "' x1='0%' x2='", '"&[GradientLimit',
                  i,
                  ']&"%', "' y1='0%' y2='0%'><stop offset='100%' stop-color='",
                  "#E61D5B",
                  "'></stop><stop offset='100%' stop-color='rgba(156, 156, 156,0.2)'></stop></linearGradient></defs>"),
       t[3:length(t)])


t <- gsub("lass='svglite' width='.*' height='.*' viewBox", "lass='svglite' viewBox", t)


write.table(t, "temp.svg", row.names = F, col.names = F, quote = F)
# file.remove("temp.svg")

