---
layout: "post"
title: "Leaflet: Minimap and bottom center"
date: "2019-03-02 13:35"
comments_id: 	21
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

---
I added a scale in the center as well (needed a control plugin - [topcenter](https://github.com/FCOO/leaflet-control-topcenter))

Just load the css and js needed:
```html
<!-- topcenter -->
<link  href="js/topcenter/leaflet-control-topcenter.css" rel="stylesheet"/>
<script src="js/topcenter/leaflet-control-topcenter.js"></script>
```

You will have 2 new values available for the position option of the [Control from leaflet](https://leafletjs.com/reference-1.4.0.html#control):

- bottomcenter
- topcenter

E.g.
`L.control.scale({imperial: false, position: 'bottomcenter'}).addTo(map);
`
