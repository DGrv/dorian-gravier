
# setup
rm(list = ls())
rootpath <- 'C:/Users/doria/Downloads/GitHub/dorian.gravier.github.io/files/R/' 
# Sys.setlocale('LC_ALL', 'German')
source(paste0(rootpath, 'BM_Function_v01.r'), encoding='utf-8')

stop("[DEBUG] - Dorian - You have to update the code, plotKML, rayshaderanimate, rgdal are not anymore maintained, used the function read.gpx that I created")


library(httr)
library(rvest)
library(tibble)
library(rgdal)
library(sf)
library(concaveman)
# library(crrri)

# chrome <- Chrome$new(bin = "C:/Users/doria/scoop/shims/chrome.exe")

# if( paste0(Sys.info()[4]) == 'DELLDORI' ) {
  wd <- rP("file:///C:/Users/doria/Dropbox/Shared_Dorian/thecrag/")
  # country.list <- c("Corsica", "France", "Germany")
  country.list <- c("Croatia", "Slovenia", "Hunga", "Serbia", "Montenegro", "Albania", "Bosnia", "Macedonia", "Greece")
# }

# area and tiles ----------------------------------------------------------

world <- data.table(map_data("world"))
world2 <- world[region %like% paste0(country.list, collapse = "|")]
world2[, .N, region]
ggplot(world2, aes(long, lat, group = group))+
  geom_polygon(colour='black', fill=NA)


size.tile <- 0.2


# login -------------------------------------------------------------------

cat("\n\nTry to connect to thecrag...\n")


url <- "https://www.thecrag.com/dashboard"
# url <- "https://www.google.com"
session <-  session(url)
form <- html_form(session)[[2]]
fl_fm <- html_form_set(form,
                       "D:Login" = "les4kins",
                       "D:Password" = "&h7kuv&3yxXP4e*3")
main_page <- session_submit(session, fl_fm)




# Leaflet localisation --------------------------------------------------------------------


for(x in 1:length(country.list)) {

  namef <- p0(wd, country.list[x], ".csv")
  if( !file.exists(namef) ) {
    
      # matrix for country ------------
          world2 <- world[region %like% country.list[x]]
          # world2 <- world[subregion %like% country.list[x]]
          world2[is.na(subregion), subregion := region]
          world2sf <- concaveman(st_as_sf(world2, coords = c("long", "lat")))
          # poly <- concaveman(world2sf)
          
          lonl <- seq(min(world2$lon), max(world2$lon), size.tile)
          latl <- seq(min(world2$lat), max(world2$lat), size.tile/2)
          
          temp <- expand.table(data.table(lat = round(latl, 2)), round(lonl, 2), "lon")
          temp[, IDtile := 1:.N]
          tempsf <- st_as_sf(temp, coords = c("lon", "lat"))
          subr <- u(world2$subregion)
          temp[, keep := F]
          for(l in seq_along(subr)) {
            world2sf.subr <- concaveman(st_as_sf(world2[subregion == subr[l]], coords = c("long", "lat")))
            tempgood <- st_filter(tempsf, world2sf.subr)
            temp[IDtile %in% tempgood$IDtile, keep := T]
          }
          temp <- temp[keep == T]
          
          # a <- ggplot(temp, aes(lon, lat))+geom_point()+
          #   geom_polygon(data=world2, aes(long, lat, group = group), colour='black', fill=NA)
          # a
          
          # only search a specific area for testing around a location
          # look <- c(5.575196, 45.05373)
          # temp2 <- temp[lon > c(look[1] - size.tile * 4) & lon < c(look[1] + size.tile * 4)]
          # temp2 <- temp2[lat > c(look[2] - size.tile * 2) & lat < c(look[2] + size.tile * 2)]
          # a + geom_point(data = temp2, color = "red") + geom_point(aes(x = look[1], y = look[2]), color = "blue")
          # temp <- temp2
      
      # Loop get the json -----------
          
          data <- data.table()
          for(i in 1:nrow(temp)) {
            
            # read json ----
                # area <- data.table(lon=c(temp$lon[i]-size.tile/2, temp$lon[i]-size.tile/2, temp$lon[i]+size.tile/2, temp$lon[i]+size.tile/2, temp$lon[i]-size.tile/2),
                                   # lat=c(temp$lat[i]-size.tile/4, temp$lat[i]+size.tile/4, temp$lat[i]+size.tile/4, temp$lat[i]-size.tile/4, temp$lat[i]-size.tile/4))
                # area
                # a +geom_path(data=area, color = "red")
                
                url <- p0("https://www.thecrag.com/api/map/bbox/heirachy?s=",temp$lon[i]-size.tile/2, ",", temp$lat[i]-size.tile/4,",", temp$lon[i]+size.tile/2,",", temp$lat[i]+size.tile/4, "&f=geometry,gearStyles,numberRoutes,numberAscents,closedTag")
                main_page <- session_jump_to(main_page, url)
                # session_history(main_page)
                # yes <- rawToChar(main_page$response$content)
                yes <- stringi::stri_encode(main_page$response$content)
                t0 <- jsonlite::fromJSON(yes, flatten = TRUE)
          
            
                # extract data -----
                # https://www.r-bloggers.com/2018/10/converting-nested-json-to-a-tidy-data-frame-with-r/
                d <- data.table(enframe(unlist(t0)))[name %like% "children"][name %like% "name|stub|numberRoutes|numberAscents|center"]
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
            
            # print plot and info-----
            titlegg <- p0(country.list[x], " : ", i, "/", nrow(temp), "\n")
            # a <- ggplot(temp, aes(lon, lat))+geom_point()+
            #   geom_polygon(data=world2, aes(long, lat, group = group), colour='black', fill=NA)+
            #   geom_point(data = data, aes(lon, lat), color = "red")+
            #   geom_point(data = temp[i], aes(lon, lat), size = 3, color = "blue")+
            #   labs(title = titlegg)
            # a
            # printfast(a, p0(wd, country.list[x], ".jpg"), ext = ".jpg",
                      # width = 600, height = 400)
            
            cat(titlegg)
            
          }
      
          
      data[, name := gsub('\\"', "", name)]
          
      namef <- p0(wd, country.list[x], "_raw.csv")
      write.csv.wawi(data, namef)
      # data <- read.csv.wawi(namef)
      dataBU <- copy(data)
      # data <- copy(dataBU)
      data[is.na(numberAscents), numberAscents := 0]
      data[is.na(numberRoutes), numberRoutes := 0]
      data[, url := p0("https://www.thecrag.com/climbing/", stub)]
      # data[, grepcol("number|stub|row", data) := NULL]
      data[, country := country.list[x]]
      data <- data[!is.na(lon)][!is.na(lat)]
      
      
      # new filter
      temp <- data[, .SD[stub %like% stub, .N], by = stub]
      data <- dtjoin(data, temp)
      setnames(data, "V1", "nstub")
      data <- data[nstub == 1]
      
      
      
      a <- ggplot(data, aes(lon, lat))+ geom_point()+
        geom_polygon(data=world2, aes(long, lat, group = group), colour='black', fill=NA)+
        labs(title = p0(country.list[x], " - ALL"))
      a
      printfast(a, p0(wd, country.list[x], "__ALL.jpg"), ext = ".jpg",
                width = 600*2, height = 400*2)  
      
      data[, all := ""]
      data[, infodone := F]
      
      namef <- p0(wd, country.list[x], "_filter.csv")
      write.csv.wawi(data, namef)
      if(! "desc" %in% names(data)) {
          data[, desc := p0("Routes:", numberRoutes, " - Ascents:", numberAscents, "\n", all)]
      }
      namef <- p0(wd, country.list[x], ".csv")
      write.csv.wawi(data, namef)
      # data <- read.csv.wawi(namef)
      
      
      
      
  } # end file exist
  
}
  
  
# a <- ggplot(all, aes(lon, lat))+ geom_point()+
#   geom_polygon(data=world, aes(long, lat, group = group), colour='black', fill=NA)+
#   labs(title = "All")
# printfast(a, rP("file:///C:/Users/doria/Downloads/Outdoor/Topo/thecrag/v03/gpx/ALL.jpg"), ext = ".jpg",
#           width = 600*2, height = 400*2)  
  
  
  
  
  

# temp clean
# for(x in 1:length(country.list)) {
#   
#   namef <- p0(wd, country.list[x], ".csv")
#   data <- read.csv.wawi(namef)
#   temp <- data[, .SD[stub %like% stub, .N], by = stub]
#   data <- dtjoin(data, temp)
#   setnames(data, "V1", "nstub")
#   data <- data[!(nstub > 1 & all == "")]
#   write.csv.wawi(data, namef)
#   
# }

# temp clean
# for(x in 1:length(country.list)) {
# 
#   namef <- p0(wd, country.list[x], ".csv")
#   data0 <- read.csv.wawi(namef)
#   namef <- p0(wd, country.list[x], "_filter.csv")
#   data <- read.csv.wawi(namef)
#     
#     # data0[, all := NULL]
#     # data0[, all := ""]
#     # data0
#   
#   data <- dtjoin(data, data0[, .(stub, all)])
#   data[is.na(all), all := ""]
#   data[all == "", infodone := F]
#   data[all != "", infodone := T]
#   data[, .N, infodone]
#   data
#   
#   namef <- p0(wd, country.list[x], ".csv")
#   write.csv.wawi(data, namef)
# 
  # data[, desc := p0("Routes:", numberRoutes, " - Ascents:", numberAscents, "\n", all)]
#   export.gpx(data, p0(wd, country.list[x], ".gpx"))
#   # export.gpx(data[all != ""], p0(wd, country.list[x], ".gpx"))
# 
# }
  
  
  
# for(x in 1:length(country.list)) {
# 
#   namef <- p0(wd, country.list[x], "_raw.csv")
#   data <- read.csv.wawi(namef)
#   data[, count := NULL]
#   data <- u(data)
#   data[, name := gsub('\\"', "", name)]
#   data[is.na(numberAscents), numberAscents := 0]
#   data[is.na(numberRoutes), numberRoutes := 0]
#   data[, url := p0("https://www.thecrag.com/climbing/", stub)]
#   data[, country := country.list[x]]
#   data <- data[!is.na(lon)][!is.na(lat)]
#   temp <- data[, .SD[stub %like% stub, .N], by = stub]
#   data <- dtjoin(data, temp)
#   setnames(data, "V1", "nstub")
#   data <- data[nstub == 1]
#   namef <- p0(wd, country.list[x], "_filter.csv")
#   write.csv.wawi(data, namef)
# 
# }





# temp <- read.csv.wawi(rP("file:///C:/Users/dorian.BSPM/Dropbox/Shared_Dorian/thecrag/Italy_filter.csv"))
# temp
# data
# data <- dtjoin(data, temp[,.(lat, lon, stub)], type = "inner")



# country.list <- c("Switzerland", "France", "Germany", "Corsica", "Italy",  "Germany")
#   
# for(x in 1:length(country.list)) {
#   namef <- p0(wd, country.list[x], ".csv")
#   data <- read.csv.wawi(namef)
#   
#   cat("\n", namef, " ", nrow(data[infodone == TRUE]), "/", nrow(data))
#   # data <- u(data)
#   # if(! "desc" %in% names(data)) {
#   #   data[, desc := p0("Routes:", numberRoutes, " - Ascents:", numberAscents, "\n", all)]
#   # }
#   # capture.output(write.csv.wawi(data, namef), file = nullfile())
#   # export.gpx(data, p0(wd, country.list[x], ".gpx"))
#   
# }  
  
  

# routes ------------------------------------------------------------------


for(x in 1:length(country.list)) {
  
  namef <- p0(wd, country.list[x], ".csv")
  data <- read.csv.wawi(namef)
  
  # data[desc %like% "Routes:0 -" & infodone == FALSE]
  data[desc %like% "Routes:0 -" & infodone == FALSE, infodone := TRUE]
  data[, desc := gsub("\nNA$", "\n", desc)]
  
  linep <- "\n-------------------------------------------------------------------------------------------------------\n"
  
  crawling <- F
  if( crawling ) {
    for(i in 1:nrow(data)) {
    
      if( !data$infodone[i] ){
        cat("\n", i, "/", nrow(data), "\n")
      
        tryCatch({
            
            url <- data$url[i]
            cat(url, "\n")
            
            # with proxy
            yes <- system(p0('curl -k --proxy cVpCQcNxcLCvcGYhqUzhBw@smartproxy.crawlbase.com:8012 "', url, '"'), intern = TRUE)
            yes <- paste0(yes, collapse = "\n")
            
            # # with rvest
            # main_page <- session_jump_to(main_page, url)
            # yes <- stringi::stri_encode(main_page$response$content)
            
            yes2 <- minimal_html(yes)
            temp <- data.table()
            
            checkgym <- yes2 %>%  html_nodes(".h1") %>% html_elements("a") %>% html_text()
            if ( any(checkgym %like% "Halle|gym|Gym|Halle") ) {
              tt <- c()
            } else {
              tt <- yes2 %>%  html_nodes(".route") %>% html_elements(".name") %>% html_text2()
            }
            
            
            if( length(tt) != 0 ) {
              
              
              temp[, route := tt[!is.na(tt)]]
              temp
              
              tt <- yes2 %>%  html_nodes(".route") %>% html_attr("data-route-tick")
              tt <- tt[!is.na(tt)]
              temp[, row := 1:.N]
              temp[, tt := tt]
              temp[, mp := ifelse(!is.null(jsonlite::fromJSON(tt)$pitch),
                                  p0("-(", p0(t(jsonlite::fromJSON(tt)$pitch)[1, ], collapse = " "), ")"),
                                  ""), by = row]
              temp[, mp := gsub("-\\(1\\)", "", mp)]
              temp[, level := jsonlite::fromJSON(tt)$gradeAtom$grade, by=row]
              if( !"level" %in% colnames(temp) ) {
                temp[, level := ""]
              }
              temp[, high := ifelse(!is.null(jsonlite::fromJSON(tt)$displayHeight[1]), 
                                    p0("-",jsonlite::fromJSON(tt)$displayHeight[1], "m"),
                                    ""), by=row]
              
              temp[, info := p0(level, " - ", route, " ", high, mp)]
              info <- p0(temp$info, collapse = "\n")
              info
              info <- gsub('\"', '', info)
              
              
              data[i, all := info]
              cat("\n", info, "\n")
              
            } else {
              
              
              
              new <- yes2 %>% html_nodes(".area[data-nid]") %>% html_nodes(".mappin") %>% html_attr("href")
              newDT <- data.table(stub = gsub("/locate", "", new))
              newDT[, url := p0("https://www.thecrag.com", stub)]
              
              new <- yes2 %>% html_nodes(".area") %>% html_nodes(".mappin") %>% html_text()
              newDT[, name := new]
              newDT[, numberAscents := yes2 %>% html_nodes(".area[data-nid]") %>% html_elements(".ticks") %>% html_text2()]
              newDT[, numberRoutes := yes2 %>% html_nodes(".area[data-nid]") %>% html_elements(".routes") %>% html_text2()]
              newDT[, country := country.list[x]]
              newDT[, nstub := 0]
              newDT[, nstub := 0]
              newDT[, infodone := F]
              newDT[, lat := data[i]$lat]
              newDT[, lon := data[i]$lon]
              
              data <- rbind(data, newDT, fill = T)
              
            }
                
            data[i, infodone := T]
            
            
            
            # data[, desc := stri_unescape_unicode(gsub("U\\+2605", "\\\\u2605", desc))]
            capture.output(write.csv.wawi(u(data), namef), file = nullfile())
            cat(green("Success"), "\n-------------------------------------\n")
            
            # sleept <- sample((60*2):(60*3),1)
            # cat("   Sleep: ", blue(sleept), "s\n")
            # sleepbar(sleept)
            
          }, error=function(e) {
          print(e)
          # data[i, infodone := T]
          # data[i, all := "ERROR"]
          cat(red("ERROR"), linep)
          wait <- 60*60*3
          cat("Wait for", wait, "seconds\n")
          # sleepbar(wait)
        })
      
      ## write gpx
      data[, desc := p0("Routes:", numberRoutes, " - Ascents:", numberAscents, "\n", all)]
      export.gpx(data, p0(wd, country.list[x], ".gpx"))
      
      } else {
        cat(green(p0("Skip line ", i, "\n")), linep)
      }
      
    } 
  } else { # no crawling
    data[, desc := p0("Routes:", numberRoutes, " - Ascents:", numberAscents, "\n", all)]
    export.gpx(data, p0(wd, country.list[x], ".gpx"))
  }

  
}
 






