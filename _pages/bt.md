---
permalink: /bt/
author_profile: false
layout: single
---

<html>
	<head>
	
	<title>A Leaflet map!</title>
	
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
	</style>
	<!-- Browserify	 --> 
    	<!-- <script src="../assets/js/node_modules/browserify/index.js"></script> -->

	<!-- leaflet -->
    	<link rel="stylesheet" href="../assets/js/node_modules/leaflet/dist/leaflet.css" />
    	<script src="../assets/js/node_modules/leaflet/dist/leaflet.js"></script>

    	<!-- gpx.min -->
    	<!-- Copyright (C) 2013 Maxime Petazzoni <maxime.petazzoni@bulix.org> -->
    	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet-gpx/1.4.0/gpx.min.js"></script> -->
    	<script src="../assets/js/node_modules/leaflet-gpx/gpx.js"></script>

	<!-- Legend -->
	<link rel="stylesheet" href="../assets/js/Personal/leaflet.legend.css" />
    <script src="../assets/js/Personal/leaflet.legend.js"></script>

	<!-- hash -->
	<!-- A JavaScript library that keeps track of the history of changes to the hash part in the address bar. -->
    	<script src="../assets/js/node_modules/leaflet-fullhash/leaflet-fullHash.js"></script>

    	<!-- fullscreen -->
	<!-- Not in npm -->
    	<script src="../assets/js/node_modules/leaflet.fullscreen/Control.FullScreen.js"></script>
    	<link href="../assets/js/node_modules/leaflet.fullscreen/Control.FullScreen.css" rel='stylesheet' />

    	<!-- GeoJSON.Ajax -->
	<!-- to update with https://www.npmjs.com/package/leaflet-ajax -->
	<!-- to update with https://www.npmjs.com/package/leaflet-ajax -->
	<!-- to update with https://www.npmjs.com/package/leaflet-ajax -->
	<!-- to update with https://www.npmjs.com/package/leaflet-ajax -->
	<!-- to update with https://www.npmjs.com/package/leaflet-ajax -->
	<!-- to update with https://www.npmjs.com/package/leaflet-ajax -->
	<!-- to update with https://www.npmjs.com/package/leaflet-ajax -->
	<!-- to update with https://www.npmjs.com/package/leaflet-ajax -->
	<!-- to update with https://www.npmjs.com/package/leaflet-ajax -->
    	<link  href="../assets/js/GeoJSON.Ajax/GeoJSON.Style.css" rel="stylesheet" />
    	<script src="../assets/js/GeoJSON.Ajax/GeoJSON.Style.js"></script>
    	<script src="../assets/js/GeoJSON.Ajax/GeoJSON.Ajax.js"></script>
    	<script src="../assets/js/GeoJSON.Ajax/GeoJSON.Ajax.WRI.js"></script>

	<!-- Minimap -->
	<!-- https://github.com/Norkart/Leaflet-MiniMap
	Copyright (c) 2012, Norkart AS
	All rights reserved. -->
	<script src="../assets/js/node_modules/leaflet-minimap/src/Control.MiniMap.js"></script>
	<link  href="../assets/js/node_modules/leaflet-minimap/src/Control.MiniMap.css" rel="stylesheet"/>


	<!-- topcenter -->
	<!-- Not in npm -->
	<!-- Not in npm -->
	<link  href="../assets/js/topcenter/leaflet-control-topcenter.css" rel="stylesheet"/>
	<script src="../assets/js/topcenter/leaflet-control-topcenter.js"></script>

	<!-- geocoder -->
	<link rel="stylesheet" href="../assets/js/node_modules/leaflet-control-geocoder/dist/Control.Geocoder.css" />
	<script src="../assets/js/node_modules/leaflet-control-geocoder/dist/Control.Geocoder.js"></script>

	<!-- leaflet-routing-machine -->
	<!-- browserify leaflet-routing-machine.js -o leaflet-routing-machine2.js -->
	<!-- <script src="../assets/js/node_modules/leaflet-routing-machine/dist/leaflet-routing-machine2.js"></script> -->
	<!-- <link rel="stylesheet" href="../assets/js/node_modules/leaflet-routing-machine/dist/leaflet-routing-machine.css" /> -->

	<!-- lrm-graphhopper -->
	<!-- Run in cmd: -->
	<!-- C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\js\node_modules\lrm-graphhopper\src > browserify L.Routing.GraphHopper.js -o L.Routing.GraphHopper2.js -->
	<!-- <script src="../assets/js/node_modules/lrm-graphhopper/src/L.Routing.GraphHopper2.js"></script> -->

	<!-- FileLayer -->
	<script src="../assets/js/node_modules/leaflet-filelayer/src/leaflet.filelayer.js"></script>
	
	<!-- Leaflet.PolylineMeasure -->
	<link rel="stylesheet" href="https://ppete2.github.io/Leaflet.PolylineMeasure/Leaflet.PolylineMeasure.css" />
	<script src="https://ppete2.github.io/Leaflet.PolylineMeasure/Leaflet.PolylineMeasure.js"></script>
	<!-- need those to download track -->
	<script src="https://unpkg.com/togeojson@0.16.0/togeojson.js"></script>
	<script src="https://unpkg.com/togpx@0.5.4/index.js"></script>

    	<!-- Personal js -->
    	<!-- <script src="../assets/js/Personal/DAVHut.js"></script> -->
    	<!-- <script src="../assets/js/Personal/gpx.js"></script> -->
    	<script src="../assets/js/Personal/gpx_biketrip2022.js"></script>
    	<script src="../assets/js/Personal/Leaflet_map.js"></script>
    	<script src="../assets/js/Personal/Bike_trip_2022_Leaflet_overlays.js"></script>

    	<style>
		#map { 
			width: 100%;
			height: 500px;
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
		<\style>
	</style>

    </head>
    <body>

    	<br>
    	<!-- To display the map -->
    	<div id="map"></div>
    	<br>
    	<br>




    	<script>


    			// initialize the map
    		// only add 1 layer here to avoid the 2 layers to load
    		var map = L.map('map', {
    			center: [44.590, 2.153],
    			zoom: 5,
    			layers: CyclOSM,
    			fullscreenControl: {
    				pseudoFullscreen: true // if true, fullscreen to page width and height
    			}
    		});
			
		map.attributionControl.setPosition('topcenter');
			
		// Create necessary panes in correct order (i.e. "bottom-most" first). to order line and points : https://stackoverflow.com/questions/38599280/leaflet-overlay-order-points-lines-and-polygons/
		// and https://gis.stackexchange.com/questions/240738/control-custom-panes-for-leaflet-geojson-svg-icons
		map.createPane("linesPane");
		map.createPane("pointsPane");

		L.control.layers(baseLayers, overlays).addTo(map);
			
		L.control.scale({imperial: false, position: 'bottomcenter'}).addTo(map);

    		// popup info : https://meggsimum.de/webkarte-mit-gps-track-vom-sport/

    		for (var j = 0; j < loopinfoBikeTrip2022.what.length; j += 1) {
    			for (var i = 0; i < loopinfoBikeTrip2022.what[j].length; i += 1) {

				var url = loopinfoBikeTrip2022.what[j][i];
				var trackcolor = loopinfoBikeTrip2022.trackcolor[j];
				var project = loopinfoBikeTrip2022.project[j];
				
								
				var g = new L.GPX(url,
					{async: true,
					pane: "linesPane" ,
					parseElements: ['track'],
					polyline_options: { color: trackcolor},
					marker_options: {
						startIconUrl: '',
						endIconUrl: '',
						shadowUrl: '',
						wptIconUrls : {
							'wpt': '',
						},
						wptIconTypeUrls : {
							'wpt': '',
						},
						clickable: true
						}
					});
					
					
				
				// Important https://github.com/mpetazzoni/leaflet-gpx/issues/105
				// I needed help from someone to understand how to retrieve (or not) the url of the gpx :
				// The library doesn't have a way to get you back the URL of the GPX that was loaded, because it doesn't just take URLs as input (you can also directly pass GPX XML to the L.GPX(...) constructor). But since you already have that URL in your code, you don't need the library to give it back to you.
				// Your problem here is a classic Javascript callback scope capture problem. You can read more about this here: https://www.pluralsight.com/guides/javascript-callbacks-variable-scope-problem


				// g.on('loaded', (function() {
					// var _url = url;
					// var _project = project;
					// return function(e) {
						// var gpx = e.target;
						// namegpx = gpx.get_name(),
						// distM = gpx.get_distance(),
						// distKm = distM / 1000,
						// distKmRnd = distKm.toFixed(1),
						// eleGain = gpx.get_elevation_gain().toFixed(0),
						// eleLoss = gpx.get_elevation_loss().toFixed(0),
						// cen = gpx.getBounds().getCenter();
						
						// var share = 'https://dgrv.github.io/dorian.gravier.github.io/leaflet/#15/' + cen.lat + '/' + cen.lng;
					

						// // register popup on click
						// var info = "<b>Name: " + namegpx + "</b></br>" +
							// "<b>Distance:</b> " + distKmRnd + " km </br>" +
							// "<b>Elevation Gain:</b> " + eleGain + " m </br>" +
						// "<b>Elevation Loss:</b> " + eleLoss + " m </br>" +
							// "<a href='" + _url + "' target='_blank'>Download gpx</a></br>" +
							// "<a href='" + share + "' target='_blank'>Share location</a></br>";
							
						// gpx.getLayers()[0].bindPopup(info);
						
						// if ( _project == true ) {
							// gpx.setStyle({opacity: 0.95, dashArray: '10 5'});
						// };
						// }})() ); // important to have this : )() )
				

				g.on('mouseover', function(e) {
					e.target.setStyle({opacity: 0.7, weight: 6});
				});

				g.on('mouseout', function(e) {
					e.target.setStyle({opacity: 1, weight: 3});
				});

				g.addTo(loopinfoBikeTrip2022.layer[j]);
			};
		};
		

	


		var hash = new L.Hash(map, baseLayers);

		for (var j = 0; j < listpoint.what.length; j += 1) {
			L.geoJSON(listpoint.what[j], {
			// onEachFeature: onEachFeature, style: myStyle,
			pointToLayer: function(feature, latlng) {
				return new L.CircleMarker(latlng, {pane: "pointsPane", radius: listpoint.radius[j], fillOpacity: 1, color : listpoint.color[j], stroke: true, weight: 2});
			},
			onEachFeature: function (feature, layer) {
				// layer.bindPopup(feature.properties.popupContent); // to click on popup
				layer.bindTooltip(feature.properties.popupContent); // to mouseover to popup
			}
			}).addTo(map);
		}

		map.addLayer(lBike); // add by default the bike gpx overlays
		map.addLayer(lStop); // add by default the bike gpx overlays
		
		
		
		
		// // POints
		// L.geoJSON(pointsbiketrip, {
			// // onEachFeature: onEachFeature, style: myStyle,
			// pointToLayer: function(feature, latlng) {
				// return new L.CircleMarker(latlng, {pane: "pointsPane", radius: 3, fillOpacity: 1, color : "#ff2b56", stroke: true, weight: 2});
			// },
			// onEachFeature: function (feature, layer) {
				// // layer.bindPopup(feature.properties.popupContent); // to click on popup
				// layer.bindTooltip(feature.properties.popupContent); // to mouseover to popup
			// }
		// }).addTo(map);
		
		// L.geoJSON(tosee, {
			// // onEachFeature: onEachFeature, style: myStyle,
			// pointToLayer: function(feature, latlng) {
				// return new L.CircleMarker(latlng, {pane: "pointsPane", radius: 3, fillOpacity: 1, color : "#fff416", stroke: true, weight: 2});
			// },
			// onEachFeature: function (feature, layer) {
				// // layer.bindPopup(feature.properties.popupContent); // to click on popup
				// layer.bindTooltip(feature.properties.popupContent); // to mouseover to popup
			// }
		// }).addTo(map);
		
		// L.geoJSON(climb, {
			// // onEachFeature: onEachFeature, style: myStyle,
			// pointToLayer: function(feature, latlng) {
				// return new L.CircleMarker(latlng, {pane: "pointsPane", radius: 3, fillOpacity: 1, color : "#9646e3", stroke: true, weight: 2});
			// },
			// onEachFeature: function (feature, layer) {
				// // layer.bindPopup(feature.properties.popupContent); v
				// layer.bindTooltip(feature.properties.popupContent); // to mouseover to popup
			// }
		// }).addTo(map);
		
		
		
		
		L.Control.geocoder({
			position: 'topleft',
			expand: 'click',
			defaultMarkGeocode: false
		}).on('markgeocode', function(e) {
			map.setView(e.geocode.center, 11);
		}).addTo(map);


		L.control.Legend({
			position: "bottomright",
			collapsed: false,
			symbolWidth: 15,
			symbolHeight: 15,
			opacity: 1,
			column: 1,
			legends: [{
				label: " Friend",
				type: "circle",
				radius: 3,
				color: listpoint.color[0],
				fillColor: listpoint.color[0],
				// fillOpacity: 0.6,
				weight: 1
			}, {
				label: " Nice area",
				type: "circle",
				radius: 3,
				color: listpoint.color[1],
				fillColor: listpoint.color[1],
				// fillOpacity: 0.6,
				weight: 1
			}, {
				label: " Spot where I climbed",
				type: "circle",
				radius: 3,
				color: listpoint.color[2],
				fillColor: listpoint.color[2],
				// fillOpacity: 0.6,
				weight: 1
			}, {
				label: " Wildcamping",
				type: "circle",
				radius: 3,
				color: listpoint.color[3],
				fillColor: listpoint.color[3],
				// fillOpacity: 0.6,
				weight: 1
			},{
				label: " Biking",
				type: "polyline",
				color: "#2b88ff",
				weight: 1
			}, {
				label: " Hitchiking",
				type: "polyline",
				color: "#929292",
				weight: 1
			}]
		}).addTo(map);

		// Minimap
		var miniMap = new L.Control.MiniMap(OpenStreetMap_France_mini, {
			position: 'bottomleft'
		}).addTo(map);
	


    	</script>
	<center><script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script><script type='text/javascript'>kofiwidget2.init('Support Me on Ko-fi', '#ff00e6', 'G2G7GK8LM');kofiwidget2.draw();</script> </center>

	<br>
	<center><iframe src="../assets/images/BikeTrip2022/text.txt" frameBorder="0"></iframe></center>
	<br>
	<center><img src="../assets/images/BikeTrip2022/Elevation.png"></center>
	<br>
	<center><img src="../assets/images/BikeTrip2022/Distance.png"/></center>
	<br>
	<center><img src="../assets/images/BikeTrip2022/Ascent.png"/></center>
	<br>


    </body>

</html>

[![youtube_icon](/assets/images/BikeTrip2022/youtube.png){: .align-center width="10%"}](https://www.youtube.com/@oYoLibro)

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

<html><center><script type='text/javascript' src='https://storage.ko-fi.com/cdn/widget/Widget_2.js'></script><script type='text/javascript'>kofiwidget2.init('Support Me on Ko-fi', '#ff00e6', 'G2G7GK8LM');kofiwidget2.draw();</script> </center></html>


