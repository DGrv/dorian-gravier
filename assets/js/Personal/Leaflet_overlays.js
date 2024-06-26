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
var lHike = L.layerGroup();
var lSchitour = L.layerGroup();
var lSchitourProject = L.layerGroup();
var Hutten = L.layerGroup();
var refugepoi = L.layerGroup();
var openslopemapOverlayAlpsPeaks = L.layerGroup();
var waymarkedSkipisten = L.layerGroup();
var opensnowmapPiste = L.layerGroup();

var overlays = {
	"DG - Bike": lBike,
	"DG - Hike": lHike,
	"DG - SchiTour": lSchitour,
	"DG - Project SchiTour": lSchitourProject,
	"Hillshading": hill,
	"POI - Refuge.info POI": refugepoi,
	"POI - DAV-SAC-CAS Hutten": Hutten,
	"Slope - OpenSlopeMapHR": OpenSlopeMap_HR,
	"Slope - OpenSlopeMapLR": OpenSlopeMap_LR,
	"Stamen TonerHybrid": Stamen_TonerHybrid,
	"Transport - Pt": OpenPtMap,
	"Transport - Train": OpenRailwayMap,
	"Ways - Hiking trails": hiketrails,
	"Ways - Cycling routes": cycleroutes,
	"Ways - Ski pistes": pistes,
	"Wintersport (opensnowmap.org)": opensnowmapPiste,
	"Wintersport (waymarkedtrails.org)": waymarkedSkipisten,
	"Gipfel Alpen": openslopemapOverlayAlpsPeaks
};

var hutteIcon = L.icon({
	iconUrl: 'icon/hutte.png',
	iconSize: [30] // size of the icon
});

var loopinfo = {
	what: [Bike.concat(Bike_trip_2022), Hike,  Schitour, SchitourProject],
	layer: [lBike, lHike, lSchitour, lSchitourProject],
	trackcolor: ['green', 'red', 'red', 'blue', 'blue', 'purple'],
	project: [false, false, true, false, true, true]
};