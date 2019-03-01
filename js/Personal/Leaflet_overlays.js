			// create layers
			var hill = L.tileLayer('https://tiles.wmflabs.org/hillshading/{z}/{x}/{y}.png', {
				maxZoom: 17,
				minZoom: 1,
				attribution: 'Hillshading: SRTM3 v2 (<a href="http://www2.jpl.nasa.gov/srtm/">NASA</a>)'
			}),
			OpenSlopeMap_HR = L.tileLayer('https://tileserver{s}.openslopemap.org/OSloOVERLAY_UHR_AlpsEast_16/{z}/{x}/{y}.png', {
				subdomains: '1234',
				maxZoom: 17,
				minZoom: 1,
				opacity: 0.5,
				attribution: 'Map data: &copy; <a href="https://www.openslopemap.org/">OpenSlopeMap</a>'
			}),
			OpenSlopeMap_LR = L.tileLayer('https://tileserver{s}.openslopemap.org/OSloOVERLAY_LR_All_16/{z}/{x}/{y}.png', {
				subdomains: '1234',
				maxZoom: 17,
				minZoom: 1,
				opacity: 0.5,
				attribution: 'Map data: &copy; <a href="https://www.openslopemap.org/">OpenSlopeMap</a>'
			}),
			 OpenPtMap = L.tileLayer('http://openptmap.org/tiles/{z}/{x}/{y}.png', {
					maxZoom: 17,
					attribution: 'Map data: &copy; <a href="http://www.openptmap.org">OpenPtMap</a> contributors'
			}),
			OpenRailwayMap = L.tileLayer('https://{s}.tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png', {
					maxZoom: 19,
					minZoom: 1,
					attribution: 'Map data: &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors | Map style: &copy; <a href="https://www.OpenRailwayMap.org">OpenRailwayMap</a> (<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA</a>)'
			})
			cycleroutes = L.tileLayer('https://tile.waymarkedtrails.org/cycling/{z}/{x}/{y}.png', {
				maxZoom: 17,
				minZoom: 1,
				attribution: 'Map Data: © <a href="https://cycling.waymarkedtrails.org">Waymarked Trails Cycling</a> contributors'
			}),
			hiketrails = L.tileLayer('https://tile.waymarkedtrails.org/hiking/{z}/{x}/{y}.png', {
				maxZoom: 17,
				minZoom: 1,
				attribution: 'Map Data: © <a href="https://hiking.waymarkedtrails.org">Waymarked Trails Hiking</a> contributors'
			}),
			pistes = L.tileLayer('https://tile.waymarkedtrails.org/slopes/{z}/{x}/{y}.png', {
				maxZoom: 17,
				minZoom: 1,
				attribution: 'Map Data: © <a href="https://slopes.waymarkedtrails.org">Waymarked Trails Slopes</a> contributors'
			});

			var lBike = L.layerGroup();
			var lBikeProject = L.layerGroup();
			var lHike = L.layerGroup();
			var lSchneeS = L.layerGroup();
			var lHikeProject = L.layerGroup();
			var lSchitour = L.layerGroup();
			var lSchitourProject = L.layerGroup();
			var lSchneeSProject = L.layerGroup();
			var Hutten = L.layerGroup();
			var refugepoi = L.layerGroup();


			var overlays = {
				"POI - Refuge.info POI": refugepoi,
				"POI - DAV-SAC-CAS Hutten": Hutten,
				"Hillshading": hill,
				"Slope - OpenSlopeMapHR": OpenSlopeMap_HR,
				"Slope - OpenSlopeMapLR": OpenSlopeMap_LR,
				"Transport - Pt": OpenPtMap,
				"Transport - Train": OpenRailwayMap,
				"Ways - Hiking trails": hiketrails,
				"Ways - Cycling routes": cycleroutes,
				"Ways - Ski pistes": pistes,
				"DG - Bike": lBike,
				"DG - Hike": lHike,
				"DG - SchiTour": lSchitour,
				"DG - SchneeSchuhe": lSchneeS,
				"DG - Project Bike": lBikeProject,
				"DG - Project Hike": lHikeProject,
				"DG - Project SchiTour": lSchitourProject,
				"DG - Project SchneeSchuhe": lSchneeSProject
			};

			var hutteIcon = L.icon({
				iconUrl: 'icon/hutte.png',
				iconSize: [30] // size of the icon
			});

			var loopinfo = {
				what: [Bike, Hike, HikeProject, Schitour, SchitourProject, SchneeSProject],
				layer: [lBike, lHike, lHikeProject, lSchitour, lSchitourProject, lSchneeSProject],
				trackcolor: ['green', 'red', 'red', 'blue', 'blue', 'purple'],
				project: [false, false, true, false, true, true]
			};
