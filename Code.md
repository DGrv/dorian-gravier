---
layout: page
title: Code
permalink: /code/
---

# Batch

## Magick



## FFmpeg

## Record screen and audio

```Batch
ffmpeg -list_devices true -f dshow -i dummy
```

You will get information on your micro e.g.:

```console
[dshow @ 0000023325be21c0] DirectShow video devices (some may be both video and audio devices)
[dshow @ 0000023325be21c0]  "Integrated Camera"
[dshow @ 0000023325be21c0]     Alternative name "@device_pnp_\\?\usb#vid_0bda&pid_5719&mi_00#6&2f2aea22&0&0000#{65e8773d-8f56-11d0-a3b9-00a0c9223196}\global"
[dshow @ 0000023325be21c0] DirectShow audio devices
[dshow @ 0000023325be21c0]  "Internal Microphone (Conexant 20751 SmartAudio HD)"
[dshow @ 0000023325be21c0]     Alternative name "@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{282C5434-3354-4349-88E3-F7A5AD9ABD8B}"
```
Copy the **@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{282C5434-3354-4349-88E3-F7A5AD9ABD8B}**

```Batch
ffmpeg -f gdigrab -framerate 24 -i desktop -f dshow -i audio="@device_cm_{33D9A762-90C8-11D0-BD43-00A0C911CE86}\wave_{282C5434-3354-4349-88E3-F7A5AD9ABD8B}" output.mp4
```

Stop with ctrl-c.


# R

## data.table tricks

## Dose Response Curve

# Leaflet

## Gpx

[Leaflet-gpx Github](https://github.com/mpetazzoni/leaflet-gpx)

### Load multiple gpx

```javascript
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


### Popup on click

[Example in plnkr](https://embed.plnkr.co/NO2acQlJPjnyQ3cF9qqW/)

```javascript
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
       "Elevation Gain: " + eleGain + " m </br>"

     // register popup on click
			gpx.getLayers()[0].bindPopup(info)

   g.addTo(map);
```

### Popup on mouseover

[Example in plnkr](https://embed.plnkr.co/eJXZYyFXDjfjvyozyD8I/)

```javascript
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
