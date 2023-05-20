// create layers
var hill = L.tileLayer('https://tiles.wmflabs.org/hillshading/{z}/{x}/{y}.png', {
	maxZoom: 17,
	minZoom: 1,
	attribution: 'Hillshading: SRTM3 v2 (<a href="http://www2.jpl.nasa.gov/srtm/">NASA</a>)'
});
var OpenSlopeMap_HR = L.tileLayer('https://tileserver{s}.openslopemap.org/OSloOVERLAY_UHR_AlpsEast_16/{z}/{x}/{y}.png', {
	subdomains: '1234',
	maxZoom: 25,
	minZoom: 1,
	opacity: 0.5,
	attribution: 'Map data: &copy; <a href="https://www.openslopemap.org/">OpenSlopeMap</a>'
});
var OpenSlopeMap_LR = L.tileLayer('https://tileserver{s}.openslopemap.org/OSloOVERLAY_LR_All_16/{z}/{x}/{y}.png', {
	subdomains: '1234',
	maxZoom: 25,
	minZoom: 1,
	opacity: 0.5,
	attribution: 'Map data: &copy; <a href="https://www.openslopemap.org/">OpenSlopeMap</a>'
});
var Stamen_TonerHybrid = L.tileLayer('https://stamen-tiles-{s}.a.ssl.fastly.net/toner-hybrid/{z}/{x}/{y}{r}.{ext}', {
	attribution: 'Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
	subdomains: 'abcd',
	minZoom: 0,
	maxZoom: 20,
	ext: 'png'
});
var OpenPtMap = L.tileLayer('http://openptmap.org/tiles/{z}/{x}/{y}.png', {
		maxZoom: 17,
		attribution: 'Map data: &copy; <a href="http://www.openptmap.org">OpenPtMap</a> contributors'
});
var OpenRailwayMap = L.tileLayer('https://{s}.tiles.openrailwaymap.org/standard/{z}/{x}/{y}.png', {
		maxZoom: 19,
		minZoom: 1,
		attribution: 'Map data: &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors | Map style: &copy; <a href="https://www.OpenRailwayMap.org">OpenRailwayMap</a> (<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA</a>)'
});
var cycleroutes = L.tileLayer('https://tile.waymarkedtrails.org/cycling/{z}/{x}/{y}.png', {
	maxZoom: 17,
	minZoom: 1,
	attribution: 'Map Data: © <a href="https://cycling.waymarkedtrails.org">Waymarked Trails Cycling</a> contributors'
});
var hiketrails = L.tileLayer('https://tile.waymarkedtrails.org/hiking/{z}/{x}/{y}.png', {
	maxZoom: 17,
	minZoom: 1,
	attribution: 'Map Data: © <a href="https://hiking.waymarkedtrails.org">Waymarked Trails Hiking</a> contributors'
});
var pistes = L.tileLayer('https://tile.waymarkedtrails.org/slopes/{z}/{x}/{y}.png', {
	maxZoom: 17,
	minZoom: 1,
	attribution: 'Map Data: © <a href="https://slopes.waymarkedtrails.org">Waymarked Trails Slopes</a> contributors'
});
var waymarkedHiking = L.tileLayer('https://tile.waymarkedtrails.org/hiking/{z}/{x}/{y}.png', {
	minZoom: 1,
	maxZoom: 19,
	attribution: '&copy; <a href="http://www.waymarkedtrails.org" target="_blank">waymarkedtrails.org</a>, <a href="https://creativecommons.org/licenses/by-sa/3.0/de/deed.de" target="_blank">CC BY-SA 3.0 DE</a>'
});
var opensnowmapPiste = L.tileLayer('https://tiles.opensnowmap.org/tiles-pistes/{z}/{x}/{y}.png', {
	minZoom: 1,
	maxZoom: 19,
	opacity: 1.0,
	subdomains: ['0','1','2','3'],
	attribution: '&copy; <a href="https://www.opensnowmap.org" target="_blank">OpenSnowMap.org</a>, <a href="https://creativecommons.org/licenses/by-sa/3.0/" target="_blank">CC-BY-SA</a>'
});
var openslopemapOverlayAlpsPeaks = L.tileLayer('https://peaks.openslopemap.org/{z}/{x}/{y}.png', {
	minZoom: 1,
	maxZoom: 19,
	attribution: '&copy; <a href="https://www.openslopemap.org/projekt/lizenzen/" target="_blank">OpenSlopeMap</a>, <a href="https://creativecommons.org/licenses/by-sa/4.0/" target="_blank">CC-BY-SA</a>'
});



var lBike = L.layerGroup();
var lStop = L.layerGroup();
var lBikeProject = L.layerGroup();
var lHike = L.layerGroup();
var lSchneeS = L.layerGroup();
var lHikeProject = L.layerGroup();
var lSchitour = L.layerGroup();
var lSchitourProject = L.layerGroup();
var lSchneeSProject = L.layerGroup();
var Hutten = L.layerGroup();
var refugepoi = L.layerGroup();
var openslopemapOverlayAlpsPeaks = L.layerGroup();
var waymarkedSkipisten = L.layerGroup();
var opensnowmapPiste = L.layerGroup();

var overlays = {
	"Bike Trip 2022": lBike,
};

var hutteIcon = L.icon({
	iconUrl: 'icon/hutte.png',
	iconSize: [30] // size of the icon
});

var loopinfoBikeTrip2022 = {
	what: [Bike_trip_2022, Stop],
	layer: [lBike, lStop],
	trackcolor: ['#2b88ff', '#929292'],
	project: [false, false]
};






// json value for pointsbiketrip


var pointsbiketrip = [
	{"type": "Feature", "properties": {"popupContent": "Gregoire et sa famille" }, "geometry": {"type": "Point", "coordinates":  [5.17031, 47.58763] }},
	{"type": "Feature", "properties": {"popupContent": "Laurent et Michael, Woofing au clos des Chevres" }, "geometry": {"type": "Point", "coordinates":  [4.15917, 47.19581] }},
	{"type": "Feature", "properties": {"popupContent": "Virginie" }, "geometry": {"type": "Point", "coordinates":  [3.4976, 46.0209] }},
	{"type": "Feature", "properties": {"popupContent": "Woofing chez Kim" }, "geometry": {"type": "Point", "coordinates":  [3.72795, 46.09200] }},
	{"type": "Feature", "properties": {"popupContent": "Vendanges au Domaine Miolanne" }, "geometry": {"type": "Point", "coordinates":  [3.15439, 45.59475] }},
	{"type": "Feature", "properties": {"popupContent": "Buron de Jean-Marie" }, "geometry": {"type": "Point", "coordinates":  [2.94960, 45.23054] }},
	{"type": "Feature", "properties": {"popupContent": "L'ami Paul" }, "geometry": {"type": "Point", "coordinates":  [3.4133, 43.6849] }},
	{"type": "Feature", "properties": {"popupContent": "Pacha" }, "geometry": {"type": "Point", "coordinates":  [3.0806, 44.0971] }},
	{"type": "Feature", "properties": {"popupContent": "Serge" }, "geometry": {"type": "Point", "coordinates":  [-0.2600, 42.9609] }},
	{"type": "Feature", "properties": {"popupContent": "Alice, Andoni, Maya y Unai" }, "geometry": {"type": "Point", "coordinates":  [-2.1972, 43.1531] }},
	{"type": "Feature", "properties": {"popupContent": "Un cher ami basque espagnol :)" }, "geometry": {"type": "Point", "coordinates":  [-1.9906, 43.2469] }},
	{"type": "Feature", "properties": {"popupContent": "Aline, Maité et Célia" }, "geometry": {"type": "Point", "coordinates":  [-1.73840,43.37779] }},
	{"type": "Feature", "properties": {"popupContent": "Arthur "}, "geometry": {"type": "Point", "coordinates":  [2.2678, 43.5388] }}
];

var tosee = [
	{"type": "Feature", "properties": {"popupContent": "Gorges d'Héric" }, "geometry": {"type": "Point", "coordinates":  [2.95624, 43.59989] }},
	{"type": "Feature", "properties": {"popupContent": "Causse ?" }, "geometry": {"type": "Point", "coordinates":  [3.5055, 43.8023] }},
	{"type": "Feature", "properties": {"popupContent": "Cirque de Navacelles" }, "geometry": {"type": "Point", "coordinates":  [3.5122, 43.8940] }},
	{"type": "Feature", "properties": {"popupContent": "Près du Mont Aigoual" }, "geometry": {"type": "Point", "coordinates":  [3.4845, 44.1154] }},
	{"type": "Feature", "properties": {"popupContent": "Gorges de la Dourbie" }, "geometry": {"type": "Point", "coordinates":  [3.2754, 44.0845] }},
	{"type": "Feature", "properties": {"popupContent": "Gorges de la Jonte" }, "geometry": {"type": "Point", "coordinates":  [3.3276, 44.2037] }},
	{"type": "Feature", "properties": {"popupContent": "Causse Méjéan" }, "geometry": {"type": "Point", "coordinates":  [3.5431, 44.2357] }},
	{"type": "Feature", "properties": {"popupContent": "Gorges du Tarn" }, "geometry": {"type": "Point", "coordinates":  [3.2461, 44.3053] }},
	{"type": "Feature", "properties": {"popupContent": "Causse ?" }, "geometry": {"type": "Point", "coordinates":  [3.2219, 44.3821] }},
	{"type": "Feature", "properties": {"popupContent": "L'Aubrac" }, "geometry": {"type": "Point", "coordinates":  [3.1010, 44.6241] }},
	{"type": "Feature", "properties": {"popupContent": "Le Cantal" }, "geometry": {"type": "Point", "coordinates":  [2.6965, 45.1042] }},
	{"type": "Feature", "properties": {"popupContent": "? " }, "geometry": {"type": "Point", "coordinates":  [2.9351, 45.3519] }},
	{"type": "Feature", "properties": {"popupContent": "Lac Pavin" }, "geometry": {"type": "Point", "coordinates":  [2.8914, 45.4944] }},
	{"type": "Feature", "properties": {"popupContent": "Murol" }, "geometry": {"type": "Point", "coordinates":  [2.9304, 45.5811] }},
	{"type": "Feature", "properties": {"popupContent": "La montagne Bourbonnaise" }, "geometry": {"type": "Point", "coordinates":  [3.6336, 45.8862] }},
	{"type": "Feature", "properties": {"popupContent": "Le mont Beuvray et Biberacte" }, "geometry": {"type": "Point", "coordinates":  [4.0387, 46.9214] }},
	{"type": "Feature", "properties": {"popupContent": "?" }, "geometry": {"type": "Point", "coordinates":  [5.0672, 47.6196] }}
];

var climb = [
	{"type": "Feature", "properties": {"popupContent": "Saint Béat-Lez" }, "geometry": {"type": "Point", "coordinates":  [0.6988, 42.9117] }},
	{"type": "Feature", "properties": {"popupContent": "Lordat" }, "geometry": {"type": "Point", "coordinates":  [1.746009, 42.775946] }},
	{"type": "Feature", "properties": {"popupContent": "Cantobre" }, "geometry": {"type": "Point", "coordinates":  [3.3068, 44.0605] }},
	{"type": "Feature", "properties": {"popupContent": "Hauteroche" }, "geometry": {"type": "Point", "coordinates":  [4.6082, 47.4800] }},
	{"type": "Feature", "properties": {"popupContent": "Cohons" }, "geometry": {"type": "Point", "coordinates":  [5.35665, 47.79054] }}
];



var listpoint = {
	what: [pointsbiketrip, tosee, climb, sleep],
	color: ['#ff2b56', '#fff416', '#9646e3', '#c6cb2e'],
	radius: [2, 2, 2, 2]
};




