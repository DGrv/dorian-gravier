---
permalink: /maps/bt/
author_profile: false
layout: single
---

<html>
	<head>
	
	<title>Bike Trip 2022</title>
	
	<style>
		#circle {
			width: 30px;
			height: 30px;
			-webkit-border-radius: 25px;
			-moz-border-radius: 25px;
			border-radius: 25px;
		}
		table th {
			background-color: #424242;
			color: #ffffff;
			border-bottom-color: #e77728;
		}
		img {
			max-width: 100%;
		}
		.legend {
			line-height: 13px;
			color: #555;
			padding: 4px 6px;
			background: rgba(255, 255, 255, 0.85);
			box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
			border-radius: 5px;
		}
		.legend i {
			width: 12px;
			height: 12px;
			float: left;
			margin-right: 8px;
			opacity: 0.8;
		}
		.leaflet-control {
			float: left;
			clear: none; /* normally 'both'  this is changing the position of the controls when they are situated on the same thin : bottomleft for exampl*/
		}
		.page {
			width: 100%; /* Overwrite default page css to get map on all the width */
			padding-right: 0px;
		}
	</style>
	

 

    </head>

    <body>

	<iframe width="100%" height="700px" src="https://dgrv.github.io/dorian-gravier/files/gpx/html_output/BikeTrip2022.html"> </iframe>
	
	
	
	<br>
	<br>
	<center><script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script><script type='text/javascript'>kofiwidget2.init('Support Me on Ko-fi', '#ff00e6', 'G2G7GK8LM');kofiwidget2.draw();</script> </center>

	<br>
	<center><iframe src="{{ "/assets/images/BikeTrip2022/text.txt" | relative_url }}" frameBorder="0"></iframe></center>
	<br>
	<center><img src="{{ "/assets/images/BikeTrip2022/Elevation.png" | relative_url }}"></center>
	<br>
	<center><img src="{{ "/assets/images/BikeTrip2022/Distance.png" | relative_url }}"/></center>
	<br>
	<center><img src="{{ "/assets/images/BikeTrip2022/Ascent.png" | relative_url }}"/></center>
	<br>



[![youtube_icon]({{ "/assets/images/BikeTrip2022/youtube.png" | relative_url }}){: .align-center width="10%"}](https://www.youtube.com/@oYoLibro)

<center><a href="https://www.youtube.com/@oYoLibro">All the youtube videos here</a></center>


Software used to create all of this:

- Video
	- [Losslesscut](https://mifi.github.io/lossless-cut/) to cut the video
	- [FFmpeg](https://ffmpeg.org/)
	- [Gpx-animator](https://gpx-animator.app/)
		- I used once [gpxfaketimer](https://github.com/mikaello/gpxfaketimer) to add some fake timestamp to use in gpx-animator
	- [youtube-dl]() for the music
	- [mpv](https://mpv.io/) as player and with some [lua scripts](../files/Batch/Lua) that I wrote to calling some batch files easily (see below)
	- Batch files that I created ([here](..files/Batch/FFmpeg))
	- lua scripts that I created for mpv ([mpv-easyblur](https://github.com/DGrv/mpv-easyblur))
	- for subtitles
		- [whisper-faster](https://github.com/Purfview/whisper-standalone-win)
- Map
	- [leaflet](https://github.com/Leaflet/Leaflet) and a lot other addon
		- **to finish**
	- [GPSBabel](https://www.gpsbabel.org/) to work on the gpx
	- [gpx_reduce](https://github.com/Alezy80/gpx_reduce) with the original author [here](https://wiki.openstreetmap.org/wiki/User:Travelling_salesman/gpx_reduce) to clean the gpx
	- Batch files that I created ([here](..files/Batch/Gpx))
- Graphics
	- [R](https://www.r-project.org/)
- Planning
	- [gpx.studio](https://gpx.studio/)
	- [Locus Android app](https://www.locusmap.app/) with the incredible [OpenAndroMaps](https://www.openandromaps.org/en)

	<center><script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script><script type='text/javascript'>kofiwidget2.init('Support Me on Ko-fi', '#ff00e6', 'G2G7GK8LM');kofiwidget2.draw();</script> </center>

    </body>

</html>


