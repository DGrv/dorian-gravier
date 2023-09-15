---
permalink: /code/leaflet/
toc: true
---


Complexer example in [my leaflet page](../leaflet.md)

# Gpx

[Leaflet-gpx Github](https://github.com/mpetazzoni/leaflet-gpx)

## Load multiple gpx

``` javascript
var Schitour = ['gpx/Schitour/2016_biet_weglosen.gpx',
'gpx/Schitour/2016_ober_kamorschitour.gpx',
'gpx/Schitour/2017_Innerlatenrns.gpx',
'gpx/Schitour/201711_LindauHutte.gpx',
'gpx/Schitour/2018_Fullfirst.gpx']

for (var i = 0; i < Schitour.length; i += 1) {
  var g = new L.GPX(Schitour[i], {async: true, parseElements: ['track'], polyline_options: { color: 'blue'}});
  g.addTo(map);
};
```

## Popup on click

[Example in plnkr](https://embed.plnkr.co/NO2acQlJPjnyQ3cF9qqW)

``` js
var g = new L.GPX(gpx, {
     async: true,
     parseElements: ['track'],
     polyline_options: {
       color: 'blue'
     }
   });

     g.on('loaded', function(e) {
     var gpx = e.target,
       name = gpx.get_name(),
       distM = gpx.get_distance(),
       distKm = distM / 1000,
       distKmRnd = distKm.toFixed(1),
       eleGain = gpx.get_elevation_gain().toFixed(0),
       eleLoss = gpx.get_elevation_loss().toFixed(0);

     var info = "Name: " + name + "</br>" +
       "Distance: " + distKmRnd + " km </br>" +
       "Elevation Gain: " + eleGain + " m </br>";

     // register popup on click
            gpx.getLayers()[0].bindPopup(info);
        });

   g.addTo(map);
```

## Popup on mouseover

[Example in plnkr](https://embed.plnkr.co/eJXZYyFXDjfjvyozyD8I/)

``` javascript
var g = new L.GPX(gpx, {
     async: true,
     parseElements: ['track'],
     polyline_options: {
       color: 'blue'
     }
   });


   g.on('mouseover', function(e) {
     var gpx = e.target,
       name = gpx.get_name(),
       distM = gpx.get_distance(),
       distKm = distM / 1000,
       distKmRnd = distKm.toFixed(1),
       eleGain = gpx.get_elevation_gain().toFixed(0),
       eleLoss = gpx.get_elevation_loss().toFixed(0);
     var info = "Name: " + name + "</br>" +
       "Distance: " + distKmRnd + " km </br>" +
       "Elevation Gain: " + eleGain + " m </br>"
     var popLocation = e.latlng;
     var popup = L.popup()
       .setLatLng(popLocation)
       .setContent(info)
       .openOn(map);
   });

   g.on('mouseout', function(e) {
     map.closePopup();
   });

   g.addTo(map);
```

## Highlight or change color on mouseover

[Example in plnkr](https://embed.plnkr.co/plunk/BWsn5CFrsgarwcFa)

``` javascript
var g = new L.GPX(gpx, {
     async: true,
     parseElements: ['track'],
     polyline_options: {
       color: 'blue'
     }
   });

   g.on('mouseover', function(e) {
         e.target.setStyle({opacity: 0.7, weight: 10});
         // if you want only to keep same color and change weight and so on ...
         //e.target.setStyle({color: 'yellow'});
   });

   g.on('mouseout', function(e) {
         e.target.setStyle({color: 'blue'});
         // if you want only to keep same color and change weight and so on ...
         //e.target.setStyle({opacity: 1, weight: 3});
   });

   g.addTo(map);
```