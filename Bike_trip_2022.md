---
title: Bike Trip 2022
layout: page
show_in_nav: true
order: 5
---

<html>
	<head>
	
    	<title>A Leaflet map!</title>


	<!-- Browserify	 --> 
    	<!-- <script src="js/node_modules/browserify/index.js"></script> -->

	<!-- leaflet -->
    	<link rel="stylesheet" href="js/node_modules/leaflet/dist/leaflet.css" />
    	<script src="js/node_modules/leaflet/dist/leaflet.js"></script>

    	<!-- gpx.min -->
    	<!-- Copyright (C) 2013 Maxime Petazzoni <maxime.petazzoni@bulix.org> -->
    	<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet-gpx/1.4.0/gpx.min.js"></script> -->
    	<script src="js/node_modules/leaflet-gpx/gpx.js"></script>


	<!-- hash -->
	<!-- A JavaScript library that keeps track of the history of changes to the hash part in the address bar. -->
    	<script src="js/node_modules/leaflet-fullhash/leaflet-fullHash.js"></script>

    	<!-- fullscreen -->
		<!-- Not in npm -->
		<!-- Not in npm -->
		<!-- Not in npm -->
    	<script src='js/node_modules/leaflet.fullscreen/Control.FullScreen.js'></script>
    	<link href='js/node_modules/leaflet.fullscreen/Control.FullScreen.css' rel='stylesheet' />

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
    	<link  href="js/GeoJSON.Ajax/GeoJSON.Style.css" rel="stylesheet" />
    	<script src="js/GeoJSON.Ajax/GeoJSON.Style.js"></script>
    	<script src="js/GeoJSON.Ajax/GeoJSON.Ajax.js"></script>
    	<script src="js/GeoJSON.Ajax/GeoJSON.Ajax.WRI.js"></script>

	<!-- Minimap -->
	<!-- https://github.com/Norkart/Leaflet-MiniMap
	Copyright (c) 2012, Norkart AS
	All rights reserved. -->
	<script src="js/node_modules/leaflet-minimap/src/Control.MiniMap.js"></script>
	<link  href="js/node_modules/leaflet-minimap/src/Control.MiniMap.css" rel="stylesheet"/>


	<!-- topcenter -->
	<!-- Not in npm -->
	<!-- Not in npm -->
	<!-- Not in npm -->
	<!-- Not in npm -->
	<link  href="js/topcenter/leaflet-control-topcenter.css" rel="stylesheet"/>
	<script src="js/topcenter/leaflet-control-topcenter.js"></script>

	<!-- geocoder -->
	<link rel="stylesheet" href="js/node_modules/leaflet-control-geocoder/dist/Control.Geocoder.css" />
	<script src="js/node_modules/leaflet-control-geocoder/dist/Control.Geocoder.js"></script>

	<!-- leaflet-routing-machine -->
	<!-- browserify leaflet-routing-machine.js -o leaflet-routing-machine2.js -->
	<script src="js/node_modules/leaflet-routing-machine/dist/leaflet-routing-machine2.js"></script>
	<link rel="stylesheet" href="js/node_modules/leaflet-routing-machine/dist/leaflet-routing-machine.css" />

	<!-- lrm-graphhopper -->
	<!-- Run in cmd: -->
	<!-- C:\Users\doria\Downloads\GitHub\dorian.gravier.github.io\js\node_modules\lrm-graphhopper\src > browserify L.Routing.GraphHopper.js -o L.Routing.GraphHopper2.js -->
	<script src="js/node_modules/lrm-graphhopper/src/L.Routing.GraphHopper2.js"></script>

	<!-- FileLayer -->
	<script src="js/node_modules/leaflet-filelayer/src/leaflet.filelayer.js"></script>
	
	<!-- Leaflet.PolylineMeasure -->
	<link rel="stylesheet" href="https://ppete2.github.io/Leaflet.PolylineMeasure/Leaflet.PolylineMeasure.css" />
	<script src="https://ppete2.github.io/Leaflet.PolylineMeasure/Leaflet.PolylineMeasure.js"></script>
		<!-- need those to download track -->
		<script src="https://unpkg.com/togeojson@0.16.0/togeojson.js"></script>
		<script src="https://unpkg.com/togpx@0.5.4/index.js"></script>

    	<!-- Personal js -->
    	<!-- <script src="js/Personal/DAVHut.js"></script> -->
    	<!-- <script src="js/Personal/gpx.js"></script> -->
    	<script src="js/Personal/gpx_biketrip2022.js"></script>
    	<script src="js/Personal/Leaflet_map.js"></script>
    	<script src="js/Personal/Bike_trip_2022_Leaflet_overlays.js"></script>
    	<script src="js/Personal/Points_bike_trip_2022.json"></script>

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
    			center: [46.529, 9.009],
    			zoom: 5,
    			layers: CyclOSM,
    			fullscreenControl: {
    				pseudoFullscreen: true // if true, fullscreen to page width and height
    			}
    		});

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


				g.on('loaded', (function() {
					var _url = url;
					var _project = project;
					return function(e) {
						var gpx = e.target;
						namegpx = gpx.get_name(),
						distM = gpx.get_distance(),
						distKm = distM / 1000,
						distKmRnd = distKm.toFixed(1),
						eleGain = gpx.get_elevation_gain().toFixed(0),
						eleLoss = gpx.get_elevation_loss().toFixed(0),
						cen = gpx.getBounds().getCenter();
						
						var share = 'https://dorian-gravier.com/leaflet.html#15/' + cen.lat + '/' + cen.lng;
					

						// register popup on click
						var info = "<b>Name: " + namegpx + "</b></br>" +
							"<b>Distance:</b> " + distKmRnd + " km </br>" +
							"<b>Elevation Gain:</b> " + eleGain + " m </br>" +
						"<b>Elevation Loss:</b> " + eleLoss + " m </br>" +
							"<a href='" + _url + "' target='_blank'>Download gpx</a></br>" +
							"<a href='" + share + "' target='_blank'>Share location</a></br>";
							
						gpx.getLayers()[0].bindPopup(info);
						
						if ( _project == true ) {
							gpx.setStyle({opacity: 0.95, dashArray: '10 5'});
						};
						}})() ); // important to have this : )() )
				

				g.on('mouseover', function(e) {
					e.target.setStyle({opacity: 0.7, weight: 6});
				});

				g.on('mouseout', function(e) {
					e.target.setStyle({opacity: 1, weight: 3});
				});

				g.addTo(loopinfoBikeTrip2022.layer[j]);
			};
		};
		
		map.addLayer(lBike); // add by default the bike gpx overlays

	
		// Minimap
		var miniMap = new L.Control.MiniMap(OpenStreetMap_France_mini, {
			position: 'bottomleft'
		}).addTo(map);

		var hash = new L.Hash(map, baseLayers);




		
		// POints
		L.geoJSON(pointsbiketrip, {
			// onEachFeature: onEachFeature, style: myStyle,
			pointToLayer: function(feature, latlng) {
				return new L.CircleMarker(latlng, {radius: 5, fillOpacity: 1, color : "#ff2b56", stroke: true, weight: 2});
			},
			onEachFeature: function (feature, layer) {
				layer.bindPopup(feature.properties.popupContent);
			}
		}).addTo(map);
		
		L.geoJSON(tosee, {
			// onEachFeature: onEachFeature, style: myStyle,
			pointToLayer: function(feature, latlng) {
				return new L.CircleMarker(latlng, {radius: 5, fillOpacity: 1, color : "#fff416", stroke: true, weight: 2});
			},
			onEachFeature: function (feature, layer) {
				layer.bindPopup(feature.properties.popupContent);
			}
		}).addTo(map);
		
		L.geoJSON(climb, {
			// onEachFeature: onEachFeature, style: myStyle,
			pointToLayer: function(feature, latlng) {
				return new L.CircleMarker(latlng, {radius: 4, fillOpacity: 1, color : "#9646e3", stroke: true, weight: 2});
			},
			onEachFeature: function (feature, layer) {
				layer.bindPopup(feature.properties.popupContent);
			}
		}).addTo(map);
		
		
		
		
		L.Control.geocoder({
			position: 'topleft',
			expand: 'click',
			defaultMarkGeocode: false
		}).on('markgeocode', function(e) {
			map.setView(e.geocode.center, 11);
		}).addTo(map);




    	</script>
		
		
	
		
		
    </body>

</html>


<center><img src="files/picture/BikeTrip2022/Info.png"></center>
<br>
<center><img src="files/picture/BikeTrip2022/Elevation.jpg"></center>
<br>
<center><img src="files/picture/BikeTrip2022/Distance.jpg"/></center>
<br>

<center><img src="files/picture/BikeTrip2022/Ascent.jpg"/></center>



