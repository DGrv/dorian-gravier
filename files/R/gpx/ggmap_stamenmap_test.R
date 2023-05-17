
## basic usage
########################################

bbox <- c(left = -97.1268, bottom = 31.536245, right = -97.099334, top = 31.559652)

ggmap(get_stamenmap(bbox, zoom = 13))
ggmap(get_stamenmap(bbox, zoom = 14))
ggmap(get_stamenmap(bbox, zoom = 15))
ggmap(get_stamenmap(bbox, zoom = 17, messaging = TRUE))

place <- "mount everest"
(google <- get_googlemap(place, zoom = 9))
ggmap(google)
bbox <- c(left = 86.05, bottom = 27.21, right = 87.81, top = 28.76)
ggmap(get_stamenmap(bbox_everest, zoom = 9))



## map types
########################################

place <- "rio de janeiro"
google <- get_googlemap(place, zoom = 10)
ggmap(google)

bbox <- bb2bbox(attr(google, "bb"))

get_stamenmap(bbox, maptype = "terrain")            %>% ggmap()
get_stamenmap(bbox, maptype = "terrain-background") %>% ggmap()
get_stamenmap(bbox, maptype = "terrain-labels")     %>% ggmap()
get_stamenmap(bbox, maptype = "terrain-lines")      %>% ggmap()
get_stamenmap(bbox, maptype = "toner")              %>% ggmap()
get_stamenmap(bbox, maptype = "toner-2010")         %>% ggmap()
get_stamenmap(bbox, maptype = "toner-2011")         %>% ggmap()
get_stamenmap(bbox, maptype = "toner-background")   %>% ggmap()
get_stamenmap(bbox, maptype = "toner-hybrid")       %>% ggmap()
get_stamenmap(bbox, maptype = "toner-labels")       %>% ggmap()
get_stamenmap(bbox, maptype = "toner-lines")        %>% ggmap()
get_stamenmap(bbox, maptype = "toner-lite")         %>% ggmap()
get_stamenmap(bbox, maptype = "watercolor")         %>% ggmap()


## zoom levels
########################################

get_stamenmap(bbox, maptype = "watercolor", zoom = 11) %>% ggmap(extent = "device")
get_stamenmap(bbox, maptype = "watercolor", zoom = 12) %>% ggmap(extent = "device")
get_stamenmap(bbox, maptype = "watercolor", zoom = 13) %>% ggmap(extent = "device")
# get_stamenmap(bbox, maptype = "watercolor", zoom = 14) %>% ggmap(extent = "device")
# get_stamenmap(bbox, maptype = "watercolor", zoom = 15) %>% ggmap(extent = "device")
# get_stamenmap(bbox, maptype = "watercolor", zoom = 16) %>% ggmap(extent = "device")
# get_stamenmap(bbox, maptype = "watercolor", zoom = 17) %>% ggmap(extent = "device")
# get_stamenmap(bbox, maptype = "watercolor", zoom = 18) %>% ggmap(extent = "device")


## https
########################################

bbox <- c(left = -97.1268, bottom = 31.536245, right = -97.099334, top = 31.559652)
get_stamenmap(bbox, zoom = 14, urlonly = TRUE)
get_stamenmap(bbox, zoom = 14, urlonly = TRUE, https = TRUE)
ggmap(get_stamenmap(bbox, zoom = 15, https = TRUE, messaging = TRUE))


## more examples
########################################

gc <- geocode("rio de janeiro")

get_stamenmap(bbox, zoom = 10) %>% ggmap() +
  geom_point(aes(x = lon, y = lat), data = gc, colour = "red", size = 2)

get_stamenmap(bbox, zoom = 10, crop = FALSE) %>% ggmap() +
  geom_point(aes(x = lon, y = lat), data = gc, colour = "red", size = 2)

get_stamenmap(bbox, zoom = 10, maptype = "watercolor") %>% ggmap() +
  geom_point(aes(x = lon, y = lat), data = gc, colour = "red", size = 2)

get_stamenmap(bbox, zoom = 10, maptype = "toner") %>% ggmap() +
  geom_point(aes(x = lon, y = lat), data = gc, colour = "red", size = 2)


# continental united states labels
c("left" = -125, "bottom" = 25.75, "right" = -67, "top" = 49) %>%
  get_stamenmap(zoom = 5, maptype = "toner-labels") %>%
  ggmap()




# accuracy check - white house
gc <- geocode("the white house")

qmap("the white house", zoom = 16)  +
  geom_point(aes(x = lon, y = lat), data = gc, colour = "red", size = 3)

qmap("the white house", zoom = 16, source = "stamen", maptype = "terrain")  +
  geom_point(aes(x = lon, y = lat), data = gc, colour = "red", size = 3)



## known issues
########################################

# in some cases stamen's servers will not return a tile for a given map
# this tends to happen in high-zoom situations, but it is not always
# clear why it happens. these tiles will appear as blank parts of the map.

# ggmap provides some tools to try to recover the missing tiles, but the
# servers seem pretty persistent at not providing the maps.

bbox <- c(left = -97.1268, bottom = 31.536245, right = -97.099334, top = 31.559652)
ggmap(get_stamenmap(bbox, zoom = 17))
get_stamen_tile_download_fail_log()
retry_stamen_map_download()



