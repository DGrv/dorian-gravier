---
layout: "post"
title: "New leaflet layers: DAV Huts"
date: "2019-02-28 21:25"
---

While I was planing a Ski tour I landed on a DAV website to reserve Hut. I realize that their URL is ending by an ID: `https://www.alpsonline.org/reservation/calendar?hut_id=`
Meaning that the all info from their hut are easily available for few lines of code with R for example.
I decide to take the step and give me a challenge to have a Leaflet marker for all those Hut with a link to the reservation site.

Here the summarized workflow I have built in the [Rscript](/files/R/DAV_getcoord_v01.R):

- I first got all the hut name from the different url.
- Use ggmap package to find the localisation of the names ([geocoding](https://www.r-bloggers.com/geocoding-with-ggmap-and-the-google-api/))
- convert those info in a js variable
- change the default icon
- and ja other little things ...


You will have then 1 new layer available:

- `POI - DAV-SAC-CAS Hutten`
