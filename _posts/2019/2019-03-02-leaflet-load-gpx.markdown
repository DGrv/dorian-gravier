---
layout: "post"
title: "Leaflet: load gpx"
date: "2019-03-02 15:58"
---

Again a new leaflet option to laod a gpx using [leaflet.FileLayer](https://github.com/makinacorpus/Leaflet.FileLayer).

In `head`:
```html
<!-- FileLayer -->
<script src="js/FileLayer/leaflet.filelayer.js"></script>
```

In `body`:
```js
// FileLayer
L.Control.fileLayerLoad({
        layer: L.geoJson,
        layerOptions: {style: {color:'red'}},
        addToMap: true,
        fileSizeLimit: 3000,
    }).addTo(map);
```
