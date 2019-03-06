---
title: Leaflet
layout: page
show_in_nav: false
---

<html>
	<head>

    	<title>A Leaflet map!</title>


			<!-- leaflet -->
    	<link rel="stylesheet" href="https://unpkg.com/leaflet@1.4.0/dist/leaflet.css" />
    	<script src="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js"></script>

    	<!-- gpx.min -->
    	<!-- Copyright (C) 2013 Maxime Petazzoni <maxime.petazzoni@bulix.org> -->
    	<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet-gpx/1.4.0/gpx.min.js"></script>


			<!-- hash -->
    	<!-- Copyright (c) 2013 Michael Lawrence Evans -->
    	<script src="js/Hash/leaflet-hash.js"></script>
    	<script src="js/Hash/togeojson.js"></script>

    	<!-- fullscreen -->
    	<script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js'></script>
    	<link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css' rel='stylesheet' />

    	<!-- GeoJSON.Ajax -->
    	<link  href="js/GeoJSON.Ajax/GeoJSON.Style.css" rel="stylesheet"/>
    	<script src="js/GeoJSON.Ajax/GeoJSON.Style.js"></script>
    	<script src="js/GeoJSON.Ajax/GeoJSON.Ajax.js"></script>
    	<script src="js/GeoJSON.Ajax/GeoJSON.Ajax.WRI.js"></script>

			<!-- Minimap -->
			<!-- https://github.com/Norkart/Leaflet-MiniMap
			Copyright (c) 2012, Norkart AS
			All rights reserved. -->
			<script src="js/Minimap/Control.MiniMap.js"></script>
			<link  href="js/Minimap/Control.MiniMap.css" rel="stylesheet"/>

			<!-- topcenter -->
			<link  href="js/topcenter/leaflet-control-topcenter.css" rel="stylesheet"/>
			<script src="js/topcenter/leaflet-control-topcenter.js"></script>

			<!-- geocoder -->
			<link rel="stylesheet" href="https://unpkg.com/leaflet-control-geocoder/dist/Control.Geocoder.css" />
			<script src="https://unpkg.com/leaflet-control-geocoder/dist/Control.Geocoder.js"></script>

			<!-- leaflet-routing-machine -->
			<script src="https://unpkg.com/leaflet-routing-machine@latest/dist/leaflet-routing-machine.js"></script>
			<link rel="stylesheet" href="https://unpkg.com/leaflet-routing-machine@latest/dist/leaflet-routing-machine.css" />

			<!-- lrm-graphhopper -->
			<!-- <script src="js/lrm-graphhopper/lrm-graphhopper.js"></script>-->

			<!-- FileLayer -->
			<script src="js/FileLayer/leaflet.filelayer.js"></script>

    	<!-- Personal js -->
    	<script src="js/Personal/DAVHut.js"></script>
    	<script src="js/Personal/gpx.js"></script>
    	<script src="js/Personal/Leaflet_map.js"></script>
    	<script src="js/Personal/Leaflet_overlays.js"></script>
    	<script src="js/Personal/control.js"></script>

    	<style>#map{ width: 100%; height: 500px; }</style>

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
    			center: [47.5, 9.6],
    			zoom: 8,
    			layers: Stamen_Toner,
    			fullscreenControl: {
    				pseudoFullscreen: true // if true, fullscreen to page width and height
    			}
    		});

    		L.control.layers(baseLayers, overlays).addTo(map);
				L.control.scale({imperial: false, position: 'bottomcenter'}).addTo(map);

				L.Control.geocoder({
					position: 'topleft',
					expand: 'click',
					defaultMarkGeocode: false
		    }).on('markgeocode', function(e) {
	        map.setView(e.geocode.center, 11);
		    }).addTo(map);


    		// popup info : https://meggsimum.de/webkarte-mit-gps-track-vom-sport/

    		for (var j = 0; j < loopinfo.what.length; j += 1) {
    			for (var i = 0; i < loopinfo.what[j].length; i += 1) {

    				var g = new L.GPX(loopinfo.what[j][i], {async: true, parseElements: ['track'], polyline_options: { color: loopinfo.trackcolor[j]}});

    				var link = loopinfo.what[j][i];

    				g.on('loaded', function(e) {
    					var gpx = e.target,
    						distM = gpx.get_distance(),
    						distKm = distM / 1000,
    						distKmRnd = distKm.toFixed(1),
    						eleGain = gpx.get_elevation_gain().toFixed(0),
    						eleLoss = gpx.get_elevation_loss().toFixed(0),
    						cen = gpx.getBounds().getCenter();

    					var share = 'https://dgrv.github.io/dorian.gravier.github.io/leaflet.html?lat=' + cen.lat + '&lng=' + cen.lng;

    					var info = "Name: " + link + "</br>" +
    						"Distance: " + distKmRnd + " km </br>" +
    						"Elevation Gain: " + eleGain + " m </br>" +
    						"<a href='" + link + "' target='_blank'>Link</a></br>" +
    						"<a href='" + share + "' target='_blank'>Share location</a> </br>";
    						// register popup on click
     					gpx.getLayers()[0].bindPopup(info);

    					if ( loopinfo.project[j] == true ) {
    						gpx.setStyle({opacity: 0.95, dashArray: '3 6'});
    					};
    				});

    				g.on('mouseover', function(e) {
          		e.target.setStyle({opacity: 0.7, weight: 6});
        		});

    				g.on('mouseout', function(e) {
          		e.target.setStyle({opacity: 1, weight: 3});
        		});

    				g.addTo(loopinfo.layer[j]);
    			};
    		};



    		// DAV Hutten
    		for (var i = 0; i < DAVhutten.length; i++) {
    			var p = new L.marker([DAVhutten[i][2], DAVhutten[i][1]], {icon: hutteIcon}).bindPopup("Name: " + DAVhutten[i][0] + "</br>" +
    			"<a href='" + DAVhutten[i][3] + "' target='_blank'>Check places</a> </br>");
    			p.addTo(Hutten);
    		};


    		new L.GeoJSON.Ajax.WRIpoi({ // Europe mountain points of interest // GeoJSON.Ajax point from Refuge.info
    			idAjaxStatus: 'ajax-status'
    		}).addTo(refugepoi);

				// Minimap
				var miniMap = new L.Control.MiniMap(OpenStreetMap_France_mini, {
					position: 'bottomleft'
				}).addTo(map);

    		// Copyright (c) 2013 Michael Lawrence Evans
    		var hash = new L.Hash(map);

				// FileLayer
				L.Control.fileLayerLoad({
					layer: L.geoJson,
					layerOptions: {style: {color:'red'}},
					addToMap: true,
					fileSizeLimit: 3000,
				}).addTo(map);






		//		L.Routing.control({
		//	    waypoints: [
		//	        L.latLng(47.58, 8.90),
		//	        L.latLng(47.424, 9.37)
		//	    ],
		//			show: false, // do not show the itinerary
		//	    router: L.Routing.graphHopper('177389ec-e9ce-4c3e-bade-c44b22062ef1'),
		//	    routeWhileDragging: true
		//	}).addTo(map);
		//	var router = routingControl.getRouter();
		//	router.on('response',function(e){
		//	  console.log('This request consumed ' + e.credits + ' credit(s)');
		//	  console.log('You have ' + e.remaining + ' left');
		//	});

    	</script>
    </body>

</html>
