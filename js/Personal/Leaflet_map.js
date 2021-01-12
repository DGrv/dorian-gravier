var topo = L.tileLayer('https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png', {
  attribution: 'Map data: &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, <a href="http://viewfinderpanoramas.org">SRTM</a> | Map style: &copy; <a href="https://opentopomap.org">OpenTopoMap</a> (<a href="https://creativecommons.org/licenses/by-sa/3.0/">CC-BY-SA</a>)',
    maxZoom: 17,
    minZoom: 1
  }),
  OpenStreetMap_France = L.tileLayer('https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png', {
    maxZoom: 20,
    attribution: '&copy; Openstreetmap France | &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }),
  GeoportailFrance_ignMaps = L.tileLayer('https://wxs.ign.fr/{apikey}/geoportail/wmts?REQUEST=GetTile&SERVICE=WMTS&VERSION=1.0.0&STYLE={style}&TILEMATRIXSET=PM&FORMAT={format}&LAYER=GEOGRAPHICALGRIDSYSTEMS.MAPS&TILEMATRIX={z}&TILEROW={y}&TILECOL={x}', {
	attribution: '<a target="_blank" href="https://www.geoportail.gouv.fr/">Geoportail France</a>',
	bounds: [[-75, -180], [81, 180]],
	minZoom: 2,
	maxZoom: 18,
	apikey: 'choisirgeoportail',
	format: 'image/jpeg',
	style: 'normal'
	}),
  OpenStreetMap_France_mini = L.tileLayer('https://{s}.tile.openstreetmap.fr/osmfr/{z}/{x}/{y}.png', {
    maxZoom: 20,
    attribution: '&copy; Openstreetmap France | &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }),
  OpenStreetMap_CH = L.tileLayer('https://tile.osm.ch/switzerland/{z}/{x}/{y}.png', {
	maxZoom: 18,
    attribution: '&copy; Openstreetmap CH | &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
  }),
  OpenCycleMap = L.tileLayer('https://{s}.tile.thunderforest.com/cycle/{z}/{x}/{y}.png?apikey={apikey}', {
    attribution: '&copy; <a href="http://www.thunderforest.com/">Thunderforest</a>, &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    apikey: 'e2ca2754befd4a5ea91cbafc804c47fe',
    maxZoom: 22
  }),
  CyclOSM = L.tileLayer('https://{s}.tile-cyclosm.openstreetmap.fr/cyclosm/{z}/{x}/{y}.png', {
	maxZoom: 20,
	attribution: '<a href="https://github.com/cyclosm/cyclosm-cartocss-style/releases" title="CyclOSM - Open Bicycle render">CyclOSM</a> | Map data: &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
	}),
	MtbMap = L.tileLayer('http://tile.mtbmap.cz/mtbmap_tiles/{z}/{x}/{y}.png', {
	attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors &amp; USGS'
	}),
  outdoors = L.tileLayer('https://tile.thunderforest.com/outdoors/{z}/{x}/{y}.png?apikey=e2ca2754befd4a5ea91cbafc804c47fe', {
    attribution: 'Maps © <a href="http://www.thunderforest.com">Thunderforest</a>, Data © <a href="http://www.openstreetmap.org/copyright">OpenStreetMap contributors</a>',
    maxZoom: 17,
    minZoom: 1,
    apikey: 'e2ca2754befd4a5ea91cbafc804c47fe'
  }),
  Stamen_Toner = L.tileLayer('https://stamen-tiles-{s}.a.ssl.fastly.net/toner/{z}/{x}/{y}{r}.{ext}', {
    attribution: 'Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    subdomains: 'abcd',
    minZoom: 0,
    maxZoom: 20,
    ext: 'png'
  }),
  Stamen_Terrain = L.tileLayer('https://stamen-tiles-{s}.a.ssl.fastly.net/terrain/{z}/{x}/{y}{r}.png', {
    attribution: 'Map tiles by <a href="http://stamen.com">Stamen Design</a>, <a href="http://creativecommons.org/licenses/by/3.0">CC BY 3.0</a> &mdash; Map data &copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
    subdomains: 'abcd',
    minZoom: 0,
    maxZoom: 18
  }),
  GeoAdmin = L.tileLayer('https://wmts20.geo.admin.ch/1.0.0/ch.swisstopo.pixelkarte-farbe/default/current/3857/{z}/{x}/{y}.jpeg', {
    attribution: 'Map tiles by &copy;<a href="http://www.swisstopo.admin.ch/internet/swisstopo/fr/home.html">swisstopo, BAFU</a>',
    minZoom: 1,
    maxZoom: 18
  }),
  // Kompass = L.tileLayer('http://ec{s}.cdn.ecmaps.de/WmsGateway.ashx.jpg?Experience=kompass&MapStyle=KOMPASS%20Touristik&TileX={x}&TileY={y}&ZoomLevel={z}', {
  Kompass = L.tileLayer('https://map2.kompass.de/{z}/{x}/{y}/kompass_topo?key=2ba8c124-38b6-11e7-ade1-e0cb4e28e847', {
    attribution: 'Map tiles by &copy;<a href="https://www.kompass.de/wanderkarte/">Kompass</a>',
    subdomains: '0123',
    minZoom: 1,
    maxZoom: 18
  }),
  Austria_topo = L.tileLayer('https://w{s}.outdooractive.com/map/v1/raster/topo_bev/{z}/{x}/{y}/t.png?', {
    attribution: 'Map tiles by &copy;<a href="https://www.kompass.de/wanderkarte/">Kompass</a>',
    subdomains: '0123',
    minZoom: 1,
    maxZoom: 18
  }),
  Esri_WorldImagery = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
	attribution: 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community'
});

// Geoadmin info
// http://wmts.geo.admin.ch/1.0.0/WMTSCapabilities.xml

  var baseLayers = {
    "OpenTopo": topo,
    "OpenStreetMapFR": OpenStreetMap_France,
    "IGN Geoportail": GeoportailFrance_ignMaps,
    "OpenStreetMapCH": OpenStreetMap_CH,
    "OpenCycleMap": OpenCycleMap,
    "CyclOSM": CyclOSM	,
    "MtbMap": MtbMap,
    "StamenToner": Stamen_Toner,
    "StamenTerrain": Stamen_Terrain,
    "Thunderforest Outdoors": outdoors,
    "GeoAdmin": GeoAdmin,
    "Kompass": Kompass,
    "Austria topo": Austria_topo,
	"Esri_WorldImagery": Esri_WorldImagery
  };
