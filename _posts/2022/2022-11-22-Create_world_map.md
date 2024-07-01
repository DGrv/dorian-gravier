---
title: "Create a simple world map with the borders of countries with R"
date: "2022-11-22 09:00"
comments_id: 53
---

```r
library(ggmap)
library(data.table)
library(ggplot2)

world <- data.table(map_data("world"))

ggplot(world)+
  geom_map(map = world, aes(long, lat, map_id = region), color = "white", fill = "lightgray", size = 0.1)
```
 
![Picture](../assets/images/posts/2022/world_map.jpg)
  
```r
ggplot(world[region %like% "France|Spain|Portuga"])+
  geom_map(map = world, aes(long, lat, map_id = region), color = "white", fill = "lightgray", size = 0.1)
```

![Picture](../assets/images/posts/2022/world_map2.jpg)


