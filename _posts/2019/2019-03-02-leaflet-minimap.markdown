---
layout: "post"
title: "Leaflet: Minimap"
date: "2019-03-02 13:35"
---

I added a [minimap](https://github.com/Norkart/Leaflet-MiniMap) on the [leaflet page](/leaflet.html).
Pretty easy to integrate:

- Host the 2 important file from the plugin
  - Control.MiniMap.js
  - Control.MiniMap.css
- Load them in your `head` balise
  - ```html
    <!-- Minimap -->
    <!-- https://github.com/Norkart/Leaflet-MiniMap
    Copyright (c) 2012, Norkart AS
    All rights reserved. -->
    <script src="js/Minimap/Control.MiniMap.js"></script>
    <link  href="js/Minimap/Control.MiniMap.css" rel="stylesheet"/>
    ```
- Load in on the map (`OpenStreetMap_France` is a L.tileLayer already loaded before)
  - ```js
  // Minimap
  var miniMap = new L.Control.MiniMap(OpenStreetMap_France, {
  	position: 'bottomleft'
  }).addTo(map);
    ```
