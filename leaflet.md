---
title: Leaflet
layout: page
---


Please wait a bit that all the gpx are loaded. This page will be updated and improved soon.
As legend :

- <span style="color:green">Green : Bike</span>
- <span style="color:red">Red : Hike</span>
- <span style="color:blue">Blue : SkiTour</span>

Then comes a bit more transparent gpx with a dash array, this are 'Projects' :)



<html>
	<head>
		<title>A Leaflet map!</title>
		<link rel="stylesheet" href="https://unpkg.com/leaflet@1.4.0/dist/leaflet.css" />
		<script src="https://unpkg.com/leaflet@1.4.0/dist/leaflet.js"></script>
		<!-- Copyright (C) 2011-2012 Pavel Shramov -->
		<!-- Copyright (C) 2013 Maxime Petazzoni <maxime.petazzoni@bulix.org> -->
		<script src="https://cdnjs.cloudflare.com/ajax/libs/leaflet-gpx/1.4.0/gpx.min.js"></script>

		<!-- For full screen -->
		<script src='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/Leaflet.fullscreen.min.js'></script>
		<link href='https://api.mapbox.com/mapbox.js/plugins/leaflet-fullscreen/v1.0.1/leaflet.fullscreen.css' rel='stylesheet' />


		<style>
			#map{ width: 900px; height: 500px; }
		</style>
	</head>
	<body>
		<!-- To display the map -->
		<div id="map"></div>

		<script>
			// test your script on https://plnkr.co

			var topo = L.tileLayer('http://a.tile.opentopomap.org/{z}/{x}/{y}.png', {
	        attribution: 'Tiles by <a href="https://opentopomap.org/">OpenTopoMap</a>',
	        maxZoom: 17,
	        minZoom: 1
	      }),
	      open = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png?{foo}', {
	        foo: 'bar',
	        attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>',
	        maxZoom: 17,
	        minZoom: 1
	      });


	    // initialize the map
	    var map = L.map('map', {
	      center: [47.5, 9.6],
	      zoom: 8,
	      layers: [topo, open],
    		fullscreenControl: true,
	    });

	    var baseLayers = {
	      "OpenTopo": topo,
	      "OpenStreet": open
	    };

	   	// create layers
			var hill = L.tileLayer('http://c.tiles.wmflabs.org/hillshading/{z}/{x}/{y}.png', {
				maxZoom: 17,
				minZoom: 1
			});

			var lBike = L.layerGroup();
			var lBikeProject = L.layerGroup();
			var lHike = L.layerGroup();
			var lHikeProject = L.layerGroup();
			var lSchiTour = L.layerGroup();
			var lSchiTourProject = L.layerGroup();

			var overlays = {"Hillshading": hill,
			"Bike": lBike,
			"Hike": lHike,
			"SchiTour": lSchiTour,
			"Project Bike": lBikeProject,
			"Project Hike": lHikeProject,
			"Project SchiTour": lSchiTourProject
			};

			L.control.layers(baseLayers, overlays).addTo(map);

			// create variable with path from the gpx
			var Bike = ['gpx/Bike/201511_mtb.gpx',
			'gpx/Bike/2017_Stockach_DonauTalRadoflzell-Konstanz.gpx',
			'gpx/Bike/201709_Bike_Travel.gpx',
			'gpx/Bike/201808_Schwarzwald.gpx',
			'gpx/Bike/201809_Bike_Switzerland.gpx']

			var Hike = ['gpx/Hike/2017_Grosser_Mythen.gpx',
			'gpx/Hike/2017_KS_2TAllgäuerHochalpen-NebelhornzuGrosserDaumen.gpx',
			'gpx/Hike/2017_KS1T_Hinterstein-Rotspitze.gpx',
			'gpx/Hike/2017_Lütispitze.gpx',
			'gpx/Hike/2017_Nord_LechtalElbigenalp-Krotenkopf-Ubeleskarspitze-Hinterbornbach.gpx',
			'gpx/Hike/2017_W_RotspitzeHinterstein.gpx',
			'gpx/Hike/201708_Druesberg.gpx',
			'gpx/Hike/201711_Wgausflug.gpx',
			'gpx/Hike/2018_W_HochYbrig_Druesberg.gpx',
			'gpx/Hike/201804_Bockmattli.gpx',
			'gpx/Hike/201804_Pfaender.gpx',
			'gpx/Hike/201805_WG_Hike_0001.gpx',
			'gpx/Hike/201805_WG_Hike_0002.gpx',
			'gpx/Hike/201806_Zimba.gpx',
			'gpx/Hike/201808_Feldberg.gpx',
			'gpx/Hike/201809_Ottenhöfen_imSchwarzwaldHiking.gpx',
			'gpx/Hike/201810_Pizol.gpx',
			'gpx/Hike/201811_Silberplatte_Klettern.gpx',
			'gpx/Hike/brunnenhochflue-t4.gpx',
			'gpx/Hike/chaeserrugg_vonwalenstadt.gpx',
			'gpx/Hike/hohenschwangauwildsulzhuette-saeuling-saeulinghau.gpx',
			'gpx/Hike/murgtal_murgseeturm.gpx',
			'gpx/Hike/plattberg_upssitzeostreich.gpx',
			'gpx/Hike/saentis_vonsudden.gpx',
			'gpx/Hike/sarek_2016.gpx',
			'gpx/Hike/um_herumdergimpel.gpx',
			'gpx/Hike/via_dellebochette.gpx']

			var HikeProject = ['gpx/Hike/Project/AKD_project.gpx',
			'gpx/Hike/Project/moe_saladinspitze_rotewand_.gpx',
			'gpx/Hike/Project/moew-paiserspitze_.gpx']

			var gpx = ['gpx/Name_var_js-html_tocopy_in_leaflet.txt',
			'gpx/R_Create_variable_for_js-html.R']

			var Schitour = ['gpx/Schitour/2016_biet_weglosen.gpx',
			'gpx/Schitour/2016_ober_kamorschitour.gpx',
			'gpx/Schitour/2017_Innerlatenrns.gpx',
			'gpx/Schitour/201711_LindauHutte.gpx',
			'gpx/Schitour/2018_Fullfirst.gpx']

			var SchitourProject = ['gpx/Schitour/Project/mo1.gpx',
			'gpx/Schitour/Project/mo11.gpx',
			'gpx/Schitour/Project/mo12.gpx',
			'gpx/Schitour/Project/mo2.gpx',
			'gpx/Schitour/Project/mo3.gpx',
			'gpx/Schitour/Project/mo4.gpx',
			'gpx/Schitour/Project/mo5.gpx',
			'gpx/Schitour/Project/mo6.gpx',
			'gpx/Schitour/Project/mo8.gpx',
			'gpx/Schitour/Project/mo9.gpx',
			'gpx/Schitour/Project/no10.gpx']



			// popup info : https://meggsimum.de/webkarte-mit-gps-track-vom-sport/

			//Bike -------------------------------------------------------------------------------------

			for (var i = 0; i < Bike.length; i += 1) {
				var g = new L.GPX(Bike[i], {async: true, parseElements: ['track'], polyline_options: { color: 'green'}});
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
 					gpx.getLayers()[0].bindPopup(info);
				});
				g.addTo(lBike);
			};


			//Hike -------------------------------------------------------------------------------------


			for (var i = 0; i < Hike.length; i += 1) {
				var g = new L.GPX(Hike[i], {async: true, parseElements: ['track'], polyline_options: { color: 'red'}});
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
					 gpx.getLayers()[0].bindPopup(info);
				 });
				g.addTo(lHike);
			};




			//HikeProject -------------------------------------------------------------------------------------

			for (var i = 0; i < HikeProject.length; i += 1) {
				var g = new L.GPX(HikeProject[i], {async: true, parseElements: ['track'], polyline_options: { color: 'brown', opacity: 0.95, dashArray: '3 6'}});
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
					 gpx.getLayers()[0].bindPopup(info);
				 });
				g.addTo(lHikeProject);
			};



			//Schitour -------------------------------------------------------------------------------------

			for (var i = 0; i < Schitour.length; i += 1) {
				var g = new L.GPX(Schitour[i], {async: true, parseElements: ['track'], polyline_options: { color: 'blue'}});
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
 					gpx.getLayers()[0].bindPopup(info);
				});
				g.addTo(lSchiTour);
			};




			//SchitourProject -------------------------------------------------------------------------------------

			for (var i = 0; i < SchitourProject.length; i += 1) {
				var g = new L.GPX(Schitour[i], {async: true, parseElements: ['track'], polyline_options: { color: 'blue', opacity: 0.95, dashArray: '3 6'}});
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
					 gpx.getLayers()[0].bindPopup(info);
				 });
				g.addTo(lSchiTourProject);
			};









		</script>
	</body>
</html>