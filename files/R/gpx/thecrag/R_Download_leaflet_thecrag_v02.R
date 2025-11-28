
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')



# Explanation -------------------------------------------------------------

# go on the map from the crag and choose the zoom you wanna have data, then move around and it should load in the Networt tab from devtool some "heirachy" which are json data for the leaflet
# once you are done go in the console and run :
# it will download all those json.
# then mv them in your wd and change user choices

# // Grab all network requests in the current session
# performance.getEntriesByType("resource")
# .filter(r => r.name.includes("heir")) // change this to match your filter
# .forEach((r, i) => {
#   fetch(r.name)
#   .then(resp => resp.text())
#   .then(text => {
#     // Save each file (will prompt download)
#     const blob = new Blob([text], {type: "text/plain"});
#     const a = document.createElement("a");
#     a.href = URL.createObjectURL(blob);
#     a.download = `resp_${i}.json`; // change extension if needed
#     a.click();
#   });
# });




# user choices ------------------------------------------------------------

country.list <- c("Greece")
nminRoutes <- 100
wd <- rP("file:///C:/Users/doria/Downloads/Outdoor/Gpx/thecrag/greece/")


# area and tiles ----------------------------------------------------------

world <- data.table(map_data("world"))
world2 <- world[region %like% paste0(country.list, collapse = "|")]
world2[, .N, region]
ggplot(world2, aes(long, lat, group = group))+
  geom_polygon(colour='black', fill=NA)


# Leaflet localisation --------------------------------------------------------------------

setwd(wd)
ll <- list.files(wd, pattern = "*.json")


data <- data.table()
for(i in seq_along(ll)) {
  
  cat("\nFile:\t", green(ll[i]))
  
  t0 <- jsonlite::fromJSON(ll[i], flatten = TRUE)

  # extract data -----
  # https://www.r-bloggers.com/2018/10/converting-nested-json-to-a-tidy-data-frame-with-r/
  d <- data.table(enframe(unlist(t0)))[name %like% "children"][name %like% "name|stub|numberRoutes|numberAscents|center"]
  
  if( nrow(d) > 0 ) {
    
    d[, id := gsub("\\d*", "", basename(gsub("\\.", "/", name)))]
    d[, children.id := str_count(name, "children")]
    d[, row := 1:.N]
    d <- d[order(children.id, row)]
    
    d3 <- d[name %like% "stub|numberRoutes|numberAscents"]
    d3[, variable := gsub("\\d", "", gsub(".*children.", "",  name))]
    d3[, row := 1:.N, variable]
    d3 <- dcast.data.table(d3[, .(value, variable, row)], row~variable, value.var = "value")
    d3 <- d3[order(row)]
    d3
    
    
    d3[, lon := as.numeric(d[name %like% "center"][seq(1, nrow(d3)*2, 2)]$value)]
    d3[, lat := as.numeric(d[name %like% "center"][seq(2, nrow(d3)*2, 2)]$value)]
    d3[, name := d[name %like% "name"]$value]
    d3[, row := NULL]
        
    
    # bind and count -------
    data <- rbind(data, u(d3))
    data <-  data[lat > min(world2$lat) & lon > min(world2$long) & lat < max(world2$lat) & lon < max(world2$long)]
    data <- u(data)
  
  }
  # # print plot and info-----
  # a <- ggplot(temp, aes(lon, lat))+geom_point()+
  #   geom_polygon(data=world2, aes(long, lat, group = group), colour='black', fill=NA)+
  #   geom_point(data = data, aes(lon, lat), color = "red")+
  #   labs(title = titlegg)
  # a
  
}

    
data[, name := gsub('\\"', "", name)]

data[, numberAscents := as.numeric(numberAscents)]
data[, numberRoutes := as.numeric(numberRoutes)]

data[is.na(numberAscents), numberAscents := 0]
data[is.na(numberRoutes), numberRoutes := 0]
data[, url := p0("https://www.thecrag.com/climbing/", stub)]
data <- data[!is.na(lon)][!is.na(lat)]
# new filter
temp <- data[, .SD[stub %like% stub, .N], by = stub]
data <- dtjoin(data, temp)
setnames(data, "V1", "nstub")
data <- data[nstub == 1][numberRoutes>0 & numberAscents > 0 ]
data[, desc := p0("Routes:", numberRoutes, " - Ascents:", numberAscents, "\n")]
data[, country := gsub("^(.*?)\\/.*", "\\1", stub)]
data[, .N, country]



data[, filterNroutes := F]
data[numberRoutes >= nminRoutes, filterNroutes := T]


data2 <- data[filterNroutes == T]


a <- ggplot(data, aes(lon, lat))+ geom_point(aes(color=filterNroutes))+
  geom_polygon(data=world2, aes(long, lat, group = group), colour='black', fill=NA)
a


for(i in seq_along(country.list)) {
  filenameout <- p0(wd, "th3cra4g_", country.list[i])
  export.gpx2(data2[grepl(country.list[i], country, ignore.case = T)], p0(filenameout , ".gpx"))
  temp <- data2[grepl(country.list[i], country, ignore.case = T), .(name,
                                                                   coord=p0(lat,",", lon),
                                                                   desc = p0(desc, "\n<a href='", url, "' target='_blank'>Thecrag link</a>"),
                                                                   group="Climbing")]
  temp
  write.table(temp, p0(filenameout, "_for_PlanMap.tsv"), sep = "\t",  fileEncoding = "UTF-8", row.names = F)
}
      






