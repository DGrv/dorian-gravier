---
lazout: post
title: New layers in leaflet - Slope
---

I was looking for such informations since a long time Slope.
I finally discovered the recent project from [OpenSlopeMap](https://www.openslopemap.org/). Exactly like me their goal is to be able to provide information to people going in the montain in order to make better decision. For more information I invite you to read their really complete website.

You will find 2 layers:

- High resolution which concerns only Austria, a part of Italy
- Low resolution which concerns all the alps and other massif

I actually by reading it discovered really nice website to plan Skitour:

- [skitourenguru.ch](https://www.skitourenguru.ch/index.php)
- [tourenwelt.at](http://www.tourenwelt.at)

In addition I remove few maps that I did not find useful for my purpose and added a [StamenToner](http://maps.stamen.com/toner/#12/37.7706/-122.3782).

I added a layer regarding public transport and train, hike and bike ways, as well as the possibility to just copy paste the url to share the actual position of the map (via the [leaflet-hash plugin](https://github.com/mlevans/leaflet-hash)).

My next goals would be to:

- [ ] when click on gpx see a elevation graphic
- [ ] be able to draw a gpx (like [OpenSlopeMap](https://www.openslopemap.org/)) and save it
