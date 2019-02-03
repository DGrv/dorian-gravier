---
title: Leaflet
layout: page
---


Enjoy :).
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
		<script src='js/Leaflet.LocationShare.js'></script>
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

		<br>
		<!-- To display the map -->
		<div id="map"></div>
		<br>
		<br>

		<script>
			// test your script on https://plnkr.co

			var topo = L.tileLayer('http://a.tile.opentopomap.org/{z}/{x}/{y}.png', {
				attribution: 'map data: © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, SRTM | map style: © OpenTopoMap (CC-BY-SA)',
					maxZoom: 17,
					minZoom: 1
				}),
				open = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png?{foo}', {
					foo: 'bar',
					attribution: 'map data: © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
					maxZoom: 17,
					minZoom: 1
				}),
				Transport = L.tileLayer('https://tile.thunderforest.com/transport/{z}/{x}/{y}.png?apikey=e2ca2754befd4a5ea91cbafc804c47fe', {
					attribution: 'Maps © <a href="http://www.thunderforest.com">Thunderforest</a>, Data © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap contributors</a>',
					maxZoom: 17,
					minZoom: 1
				}),
				atlas = L.tileLayer('https://tile.thunderforest.com/mobile-atlas/{z}/{x}/{y}.png?apikey=e2ca2754befd4a5ea91cbafc804c47fe', {
					attribution: 'Maps © <a href="http://www.thunderforest.com">Thunderforest</a>, Data © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap contributors</a>',
					maxZoom: 17,
					minZoom: 1
				}),
				outdoors = L.tileLayer('https://tile.thunderforest.com/outdoors/{z}/{x}/{y}.png?apikey=e2ca2754befd4a5ea91cbafc804c47fe', {
					attribution: 'Maps © <a href="http://www.thunderforest.com">Thunderforest</a>, Data © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap contributors</a>',
					maxZoom: 17,
					minZoom: 1
				}),
				hike = L.tileLayer('http://{s}.tiles.wmflabs.org/hikebike/{z}/{x}/{y}.png', {
					attribution: 'Map Data: © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
					maxZoom: 17,
					minZoom: 1
				});


				// initialize the map
			// only add 1 layer here to avoid the 2 layers to load
			var map = L.map('map', {
				center: [47.5, 9.6],
				zoom: 8,
				layers: topo,
				fullscreenControl: true,
			});

			var baseLayers = {
				"OpenTopo": topo,
				"OpenStreet": open,
				"Thunderforest Outdoors": outdoors,
				"Hike and Bike": hike,
				"Mobile Atlas": atlas,
				"Transport": transport
			};

			// create layers
			var hill = L.tileLayer('http://c.tiles.wmflabs.org/hillshading/{z}/{x}/{y}.png', {
				maxZoom: 17,
				minZoom: 1,
				attribution: 'Hillshading: SRTM3 v2 (<a href="http://www2.jpl.nasa.gov/srtm/">NASA</a>)'
			});

			var lBike = L.layerGroup();
			var lBikeProject = L.layerGroup();
			var lHike = L.layerGroup();
			var lSchneeS = L.layerGroup();
			var lHikeProject = L.layerGroup();
			var lSchiTour = L.layerGroup();
			var lSchiTourProject = L.layerGroup();
			var lSchneeSProject = L.layerGroup();


			var overlays = {"Hillshading": hill,
			"Bike": lBike,
			"Hike": lHike,
			"SchiTour": lSchiTour,
			"SchneeSchuhe": lSchneeS,
			"Project Bike": lBikeProject,
			"Project Hike": lHikeProject,
			"Project SchiTour": lSchiTourProject,
			"Project SchneeSchuhe": lSchneeSProject
			};

			L.control.layers(baseLayers, overlays).addTo(map);

			// create variable with path from the gpx
			// create file
var Bike = ['gpx/Bike/B_201511_mtb.gpx',
'gpx/Bike/B_2017_Stockach_DonauTalRadoflzell-Konstanz.gpx.gpx',
'gpx/Bike/B_201709_Bike_Travel.gpx',
'gpx/Bike/B_201808_Schwarzwald.gpx',
'gpx/Bike/B_201809_Bike_Switzerland.gpx',
'gpx/Bike/B_201812_LesForges.gpx']

var Hike = ['gpx/Hike/2017_Grosser_Mythen.gpx',
'gpx/Hike/2017_KS_2TAllgauerHochalpen-NebelhornzuGrosserDaumen.gpx',
'gpx/Hike/2017_KS1T_Hinterstein-Rotspitze.gpx',
'gpx/Hike/2017_Luetispitze.gpx',
'gpx/Hike/2017_Nord_LechtalElbigenalp-Krotenkopf-Ubeleskarspitze-Hinterbornbach.gpx',
'gpx/Hike/201708_Druesberg.gpx',
'gpx/Hike/201711_Wgausflug.gpx',
'gpx/Hike/2018_W_HochYbrig_Druesberg.gpx',
'gpx/Hike/201804_Bockmattli.gpx',
'gpx/Hike/201804_Pfaender.gpx',
'gpx/Hike/201805_WG_Hike_0001.gpx',
'gpx/Hike/201805_WG_Hike_0002.gpx',
'gpx/Hike/201806_Zimba.gpx',
'gpx/Hike/201808_Feldberg.gpx',
'gpx/Hike/201809_Ottenhofen_imSchwarzwaldHiking.gpx',
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

var SchitourProject = ['gpx/Schitour/Project/P_ST_moe-st-2t-carschinahuette.gpx',
'gpx/Schitour/Project/P_ST_moe-st-2t-carschinahuette_2.gpx',
'gpx/Schitour/Project/P_ST_moe-st-2t-claridenhuette.gpx',
'gpx/Schitour/Project/P_ST_moe-st-2t-heilbronner_huette.gpx',
'gpx/Schitour/Project/P_ST_moe-st-hirschberg.gpx',
'gpx/Schitour/Project/P_ST_moe-st-mattjischhorn.gpx',
'gpx/Schitour/Project/P_ST_moe-st_alpilakopf.gpx',
'gpx/Schitour/Project/P_ST_moe-st_analperjoch.gpx',
'gpx/Schitour/Project/P_ST_moe-st_gafier.gpx',
'gpx/Schitour/Project/P_ST_moe-st_gampapingalpe.gpx',
'gpx/Schitour/Project/P_ST_moe-st_gerenspitze.gpx',
'gpx/Schitour/Project/P_ST_moe-st_windeggerspitze.gpx',
'gpx/Schitour/Project/P_ST_st-moematona.gpx',
'gpx/Schitour/Project/P_ST_st-moemoerzelspitze.gpx']

var Schitour = ['gpx/Schitour/ST_2016_biet_weglosen.gpx',
'gpx/Schitour/ST_2016_ober_kamorschitour.gpx',
'gpx/Schitour/ST_2017_Innerlatenrns.gpx',
'gpx/Schitour/ST_201711_LindauHutte.gpx',
'gpx/Schitour/ST_2018_Fullfirst.gpx',
'gpx/Schitour/ST_201901_Gamperdun.gpx',
'gpx/Schitour/ST_201901_Stockberg.gpx']

var SchneeSProject = ['gpx/SchneeS/Project/P_SW_Malans-Tschugga.gpx',
'gpx/SchneeS/Project/P_SW_Mattner_first.gpx',
'gpx/SchneeS/Project/P_SW_Nussen_innertal.gpx',
'gpx/SchneeS/Project/P_SW_Silberen.gpx',
'gpx/SchneeS/Project/P_SW_Wilhaus_1.gpx']













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
						"Elevation Gain: " + eleGain + " m </br>" +
						"<a href=" + SchneeS[i] + ">Link</a> </br>"

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
						"Elevation Gain: " + eleGain + " m </br>" +
						"<a href=" + SchneeS[i] + ">Link</a> </br>"

					// register popup on click
					 gpx.getLayers()[0].bindPopup(info);
				 });
				g.addTo(lHike);
			};




			//HikeProject -------------------------------------------------------------------------------------

			for (var i = 0; i < HikeProject.length; i += 1) {
				var g = new L.GPX(HikeProject[i], {async: true, parseElements: ['track'], polyline_options: { color: 'red', opacity: 0.95, dashArray: '3 6'}});
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
						"Elevation Gain: " + eleGain + " m </br>" +
						"<a href=" + SchneeS[i] + ">Link</a> </br>"

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
						"Elevation Gain: " + eleGain + " m </br>" +
						"<a href=" + SchneeS[i] + ">Link</a> </br>"

					// register popup on click
 					gpx.getLayers()[0].bindPopup(info);
				});
				g.addTo(lSchiTour);
			};




			//SchitourProject -------------------------------------------------------------------------------------

			for (var i = 0; i < SchitourProject.length; i += 1) {
				var g = new L.GPX(SchitourProject[i], {async: true, parseElements: ['track'], polyline_options: { color: 'blue', opacity: 0.95, dashArray: '3 6'}});
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
						"Elevation Gain: " + eleGain + " m </br>" +
						"<a href=" + SchneeS[i] + ">Link</a> </br>"

					// register popup on click
					 gpx.getLayers()[0].bindPopup(info);
				 });
				g.addTo(lSchiTourProject);
			};

			//SchitourProject -------------------------------------------------------------------------------------

			for (var i = 0; i < SchneeS.length; i += 1) {
				var g = new L.GPX(SchneeS[i], {async: true, parseElements: ['track'], polyline_options: { color: 'blue'}});
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
						"Elevation Gain: " + eleGain + " m </br>" +
						"<a href=" + SchneeS[i] + ">Link</a> </br>"

					// register popup on click
					 gpx.getLayers()[0].bindPopup(info);
				 });
				g.addTo(lSchneeS);
			};

			//SchneeTourProject -------------------------------------------------------------------------------------

			for (var i = 0; i < SchneeSProject.length; i += 1) {
				var g = new L.GPX(SchneeSProject[i], {async: true, parseElements: ['track'], polyline_options: { color: 'blue', opacity: 0.95, dashArray: '3 6'}});
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
						"Elevation Gain: " + eleGain + " m </br>" +
						"<a href=" + SchneeS[i] + ">Link</a> </br>"

					// register popup on click
					 gpx.getLayers()[0].bindPopup(info);
				 });
				g.addTo(lSchneeSProject);
			};



		</script>
	</body>
</html>




# List of the gpx
