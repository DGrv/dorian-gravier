---
layout: "post"
title: "Leaflet: Geocoding"
date: "2019-03-02 14:52"
comments_id: 	18
---

I added the possibility to search a place a jump the map to the find location. I used the [leaflet-control-geocoder](https://github.com/perliedman/leaflet-control-geocoder) plugin.

Easy to handle. Load source and use it.

Only problem is that when you search I got a Marker with a popup on the found location which I do not want (maybe in future but right now not). I could not figure it out how to remove it. The author explain a bit but could not use it really.
I then took example from [map2gpx](https://github.com/tmuguet/map2gpx) and checked in the [code](https://github.com/tmuguet/map2gpx/blob/8068e2c4d999bbe8111a75cc3c8577d43a160147/src/js/controls.js#L116) to find out how it was done.


```js
L.Control.geocoder({
  position: 'topleft',
  expand: 'click',
  defaultMarkGeocode: false
}).on('markgeocode', function(e) {
  map.setView(e.geocode.center, 11
); }).addTo(map);
```
