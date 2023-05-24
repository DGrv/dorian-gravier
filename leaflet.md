---
title: Leaflet
layout: page
show_in_nav: false
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
    	<script src="js/Personal/DAVHut.js"></script>
    	<script src="js/Personal/gpx.js"></script>
    	<script src="js/Personal/Leaflet_map.js"></script>
    	<script src="js/Personal/Leaflet_overlays.js"></script>

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

    		for (var j = 0; j < loopinfo.what.length; j += 1) {
    			for (var i = 0; i < loopinfo.what[j].length; i += 1) {

				var url = loopinfo.what[j][i];
				var trackcolor = loopinfo.trackcolor[j];
				var project = loopinfo.project[j];
				
								
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

		// Legend from OpenSlopeMap : https://www.openslopemap.org/leaflet/js/map.js
		var legend = L.control({position: 'bottomleft'});
		legend.onAdd = function (map) {
			var div = L.DomUtil.create('div', 'info legend');
			var labels = [
				'Legend from',
				'OpenSlopeMap',
				'<i style="background:#FFFFFF"></i>0&deg;&ndash;9&deg;',
				'<i style="background:#00FF00"></i>10&deg;&ndash;29&deg;',
				'<i style="background:#F0E100"></i>30&deg;&ndash;34&deg;',
				'<i style="background:#FF9B00"></i>35&deg;&ndash;39&deg;',
				'<i style="background:#FF0000"></i>40&deg;&ndash;42&deg;',
				'<i style="background:#FF26FF"></i>43&deg;&ndash;45&deg;',
				'<i style="background:#A719FF"></i>46&deg;&ndash;49&deg;',
				'<i style="background:#6E00FF"></i>50&deg;&ndash;54&deg;',
				'<i style="background:#0000FF"></i>55&deg;&ndash;90&deg;'];

			div.innerHTML = labels.join('<br>');
			return div;
		};
		legend.addTo(map);
		
		// Minimap
		var miniMap = new L.Control.MiniMap(OpenStreetMap_France_mini, {
			position: 'bottomleft'
		}).addTo(map);

		var hash = new L.Hash(map, baseLayers);



		
		




		// // FileLayer - add gpx
		// var style = {
			// color: 'red',
			// opacity: 1.0,
			// fillOpacity: 1.0,
			// weight: 3,
			// clickable: false
		// };
		// //L.Control.FileLayerLoad.LABEL = '<img class="icon" src="https://www.openslopemap.org/leaflet/images/folder.svg" alt="f"/>';
		// L.Control.FileLayerLoad({
			// fitBounds: true,
			// layerOptions: {
				// style: style,
				// pointToLayer: function (data, latlng) {
					// return L.circleMarker(
					// latlng,
					// { style: style }
					// );
				// }
			// }
		// }).addTo(map);
		
		
		
		// L.Control.fileLayerLoad({
			// layer: L.geoJson,
			// layerOptions: {style: {color:'red'}},
			// addToMap: true,
			// fileSizeLimit: 3000,
		// }).addTo(map);



		// Functionniert :)
		// Functionniert :)
		// Functionniert :)
		// Functionniert :)
		// L.Routing.control({
			// router: new L.Routing.GraphHopper('177389ec-e9ce-4c3e-bade-c44b22062ef1'),
			// waypoints: [
				// L.latLng(57.74, 11.94),
				// L.latLng(57.6792, 11.949)
			// ],
			// routeWhileDragging: true
		// }).addTo(map);

		// var router = myRoutingControl.getRouter();
		// router.on('response',function(e){
		  // console.log('This routing request consumed ' + e.credits + ' credit(s)');
		  // console.log('You have ' + e.remaining + ' left');
		// });
		
		
		// ----------------------------- Polylinemeasure -----------------------------
		
		
		var options = {
			position: 'topleft',            // Position to show the control. Values: 'topright', 'topleft', 'bottomright', 'bottomleft'
			unit: 'metres',                 // Show imperial or metric distances. Values: 'metres', 'landmiles', 'nauticalmiles'
			clearMeasurementsOnStop: true,  // Clear all the measurements when the control is unselected
			showBearings: false,            // Whether bearings are displayed within the tooltips
			bearingTextIn: 'In',            // language dependend label for inbound bearings
			bearingTextOut: 'Out',          // language dependend label for outbound bearings
			tooltipTextFinish: 'Click to <b>finish line</b><br>',
			tooltipTextDelete: 'Press SHIFT-key and click to <b>delete point</b>',
			tooltipTextMove: 'Click and drag to <b>move point</b><br>',
			tooltipTextResume: '<br>Press CTRL-key and click to <b>resume line</b>',
			tooltipTextAdd: 'Press CTRL-key and click to <b>add point</b>',
											// language dependend labels for point's tooltips
			measureControlTitleOn: 'Turn on PolylineMeasure',   // Title for the control going to be switched on
			measureControlTitleOff: 'Turn off PolylineMeasure', // Title for the control going to be switched off
			measureControlLabel: '&#8614;', // Label of the Measure control (maybe a unicode symbol)
			measureControlClasses: [],      // Classes to apply to the Measure control
			showClearControl: true,        // Show a control to clear all the measurements
			clearControlTitle: 'Clear Measurements', // Title text to show on the clear measurements control button
			clearControlLabel: '&times',    // Label of the Clear control (maybe a unicode symbol)
			clearControlClasses: [],        // Classes to apply to clear control button
			showUnitControl: true,         // Show a control to change the units of measurements
			distanceShowSameUnit: false,    // Keep same unit in tooltips in case of distance less then 1 km/mi/nm
			unitControlTitle: {             // Title texts to show on the Unit Control button
				text: 'Change Units',
				metres: 'metres',
				landmiles: 'land miles',
				nauticalmiles: 'nautical miles'
			},
			unitControlLabel: {             // Unit symbols to show in the Unit Control button and measurement labels
				metres: 'm',
				kilometres: 'km',
				feet: 'ft',
				landmiles: 'mi',
				nauticalmiles: 'nm'
			},
			tempLine: {                     // Styling settings for the temporary dashed line
				color: '#00f',              // Dashed line color
				weight: 2                   // Dashed line weight
			},          
			fixedLine: {                    // Styling for the solid line
				color: '#006',              // Solid line color
				weight: 2                   // Solid line weight
			},
			startCircle: {                  // Style settings for circle marker indicating the starting point of the polyline
				color: '#000',              // Color of the border of the circle
				weight: 1,                  // Weight of the circle
				fillColor: '#0f0',          // Fill color of the circle
				fillOpacity: 1,             // Fill opacity of the circle
				radius: 3                   // Radius of the circle
			},
			intermedCircle: {               // Style settings for all circle markers between startCircle and endCircle
				color: '#000',              // Color of the border of the circle
				weight: 1,                  // Weight of the circle
				fillColor: '#ff0',          // Fill color of the circle
				fillOpacity: 1,             // Fill opacity of the circle
				radius: 3                   // Radius of the circle
			},
			currentCircle: {                // Style settings for circle marker indicating the latest point of the polyline during drawing a line
				color: '#000',              // Color of the border of the circle
				weight: 1,                  // Weight of the circle
				fillColor: '#f0f',          // Fill color of the circle
				fillOpacity: 1,             // Fill opacity of the circle
				radius: 3                   // Radius of the circle
			},
			endCircle: {                    // Style settings for circle marker indicating the last point of the polyline
				color: '#000',              // Color of the border of the circle
				weight: 1,                  // Weight of the circle
				fillColor: '#f00',          // Fill color of the circle
				fillOpacity: 1,             // Fill opacity of the circle
				radius: 3                   // Radius of the circle
			},
		};
		
		
		L.Control.PolylineMeasureOSM = L.Control.PolylineMeasure.extend({
			onAdd: function(map) {
				var container = L.Control.PolylineMeasure.prototype.onAdd.call(this, map);

				this._createControl("&#10515;", "Download Track in gpx", this.options.measureControlClasses, container, this.exportGpx, this);

				return container;
			},

			exportGpx: function(){
				this.downloadFile(togpx(this._layerPaint.toGeoJSON()));
			},

			downloadFile: function(content){
				var textToSave = content;
				var textToSaveAsBlob = new Blob([textToSave], {type:"text/plain"});
				var textToSaveAsURL = window.URL.createObjectURL(textToSaveAsBlob);
				var fileNameToSaveAs = "Track.gpx"
				
				var downloadLink = document.createElement("a");
				downloadLink.download = fileNameToSaveAs;
				downloadLink.innerHTML = content;
				downloadLink.href = textToSaveAsURL;
				downloadLink.onclick = function(event){document.body.removeChild(event.target)};
				downloadLink.style.display = "none";
				document.body.appendChild(downloadLink);
				
				downloadLink.click();
			}
		});
		
		new L.Control.PolylineMeasureOSM(options).addTo(map);

		// map.addControl( new L.Control.Gps({marker: new L.Marker([0,0])}) );
		
		
		L.Control.geocoder({
			position: 'topleft',
			expand: 'click',
			defaultMarkGeocode: false
		}).on('markgeocode', function(e) {
			map.setView(e.geocode.center, 11);
		}).addTo(map);

		map.addLayer(lBike);


    	</script>
    </body>

</html>
