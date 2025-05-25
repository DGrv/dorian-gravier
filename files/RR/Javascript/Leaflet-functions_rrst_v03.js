
var aktivBoxLayer = L.layerGroup(); // Define a global LayerGroup
var DevicesLayer = L.layerGroup(); // Define a global LayerGroup

var aktivBoxLayerAdded = false; // Control flag to ensure it's added only once
var DevicesLayerAdded = false; // Control flag to ensure it's added only once





async function addMarkerDevices(idhtmlwidget, datadevices) {
    var widget = window.HTMLWidgets.find(idhtmlwidget);

    if (widget) {
        var map = widget.getMap();

        if (map) {


            // Add layer control once
            if (!DevicesLayerAdded) {
                var DevicesLayerOverlay = {
                    "Devices": DevicesLayer
                };

                L.control.layers(null, DevicesLayerOverlay, { collapsed: false }).addTo(map);
                DevicesLayerAdded = true;
            }

            if (datadevices.position?.length) {

                datadevices.position.forEach(did => {
                    // console.log(`Connected: ${did.Connected}`);
                    var id = did.DeviceID
                    var latM = did.Position.Latitude;
                    var lonM = did.Position.Longitude;
                    var Flag = did.Position.Flag;


                    // console.log("DeviceID: ", id, " - latM: ", latM, " - lonM:", lonM, " - Flag: ", Flag)


                    if (Flag != "U") {

                        if (did.DeviceType2 === "U") {
                            // Do something with iconUrl, override it, log it, etc.
                            var iconUrltemp = did.Connected == true
                                ? "https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/RR/Images/ubidiumMapMarkerGreen.png"
                                : "https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/RR/Images/ubidiumMapMarkerRed.png";
                        }
                        if (did.DeviceType2 === "D") {
                            // Do something with iconUrl, override it, log it, etc.
                            var iconUrltemp = did.Connected == true
                                ? "https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/RR/Images/rrsMapMarkerGreen.png"
                                : "https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/RR/Images/rrsMapMarkerRed.png";
                        }
                        if (did.DeviceType2 === "T") {
                            // Do something with iconUrl, override it, log it, etc.
                            var iconUrltemp = did.Connected == true
                                ? "https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/RR/Images/ptbMapMarkerGreen.png"
                                : "https://raw.githubusercontent.com/DGrv/dorian-gravier/refs/heads/master/files/RR/Images/tbMapMarkerRed.png";
                        }

                        var iconType = L.icon({
                            iconUrl: iconUrltemp,
                            iconSize: [70, 70], // Size of the icon
                            iconAnchor: [35, 65], // Point of the icon that will correspond to marker's location, proportional to the pixel you want and the iconsize here, you have to calculate it
                            popupAnchor: [0, -60] // Popup position when opened
                        });

                        // Add marker dynamically ------------------------------------------------------------------------------------------------------------
                        // var markerAB = L.marker([latM, lonM], {icon: iconType}) 
                        //     .bindPopup("1st")
                        //     .openPopup();

                        // Initialize window.markerAB as an empty object if not already initialized
                        // window is to assign it globaly
                        if (!window.markerDevices) {
                            window.markerDevices = {};
                        }

                        if (window.markerDevices[id]) {

                            window.markerDevices[id].setLatLng([latM, lonM])
                            // console.log("Setlat for ", id)

                        } else {

                            // Add a new marker using the dynamic id as the key
                            window.markerDevices[id] = L.marker([latM, lonM], { icon: iconType })
                                .bindPopup(id)
                                .openPopup();
                            // Add marker to the LayerGroup
                            DevicesLayer.addLayer(markerDevices[id]);
                            // Ensure the layer is added to the map
                            DevicesLayer.addTo(map);
                            // console.log("create marker for ", id)
                        }
                    }
                });

            }

        } else {
            console.warn("Leaflet widget found, but map is not ready yet. Retrying...");
            setTimeout(() => addMarkerDevices(idhtmlwidget, datadevices), 500); // Retry after 500ms
        }
    } else {
        console.warn("Leaflet widget not found. Retrying...");
        setTimeout(() => addMarkerDevices(idhtmlwidget, datadevices), 500); // Retry after 500ms
    }
}

async function addMarkerToLeafletMap(id, idhtmlwidget, latM, lonM, flag, iconUser, iconUserSize, iconPulseColor, iconPulseFill) {
    var widget = window.HTMLWidgets.find(idhtmlwidget);

    if (widget) {
        var map = widget.getMap();

        if (map) {
            // console.log("Leaflet map is ready. Adding marker...");

            // Choose color based on status
            // Additional information about the systems position / movement at the time of upload.
            // U : Unknown
            // S : Box was stationary within the last minute
            // M : Box was moving within the last minute
            // T : Box was moving with a speed of at least 5km/h in the last minute
            // X : Position may not be accurate (box has moved since last GPS fix)
            // var iconEnd = flag === "X" ? icon2 : iconUser;

            // Add layer control once
            if (!aktivBoxLayerAdded) {
                var aktivBoxLayerOverlay = {
                    "AktivBox": aktivBoxLayer
                };

                L.control.layers(null, aktivBoxLayerOverlay, { collapsed: false }).addTo(map);
                aktivBoxLayerAdded = true;
            }

            if (!iconUserSize) {
                var iconUserSize = [40, 40]
            }
            if (!iconPulseColor) {
                var iconPulseColor = "red"
            }
            if (!iconPulseFill) {
                var iconPulseFill = "red"
            }

            if (iconUser) {
                // Awesome Icon ----------------------------------------------------------------------------------------------------------
                // Define custom Awesome Icon using Font Awesome
                var iconType = L.icon({
                    iconUrl: iconUser,
                    iconSize: iconUserSize, // Size of the icon
                    iconAnchor: [15, 30], // Point of the icon that will correspond to marker's location
                    popupAnchor: [0, -30] // Popup position when opened
                });
            } else {

                // leaflet-icon-pulse --------------------------------------------------------------------------------------------------
                var iconType = L.icon.pulse({
                    iconSize: iconUserSize,
                    color: iconPulseColor,
                    fillColor: iconPulseFill,
                    animate: true,
                    heartbeat: 2
                });
                // ### Options
                // | Property        | Description            | Default Value | Possible  values         |
                // | --------------- | ---------------------- | ------------- | ------------------------ |
                // | color           | color of pulse         | 'red'         | any CSS color            |
                // | fillColor       | color of dot           | 'red'         | any CSS color            |
                // | iconSize        | size of L.divIcon      | [12,12]       | <Point> [width,height]   |
                // | animate         | enable pulsing         | true          | true\|false            |
                // | heartbeat       | pulsing beat           | 1             | number (seconds)         |

            }

            // Add marker dynamically ------------------------------------------------------------------------------------------------------------
            // var markerAB = L.marker([latM, lonM], {icon: iconType}) 
            //     .bindPopup("1st")
            //     .openPopup();

            // Initialize window.markerAB as an empty object if not already initialized
            // window is to assign it globaly
            if (!window.markerAB) {
                window.markerAB = {};
            }

            if (window.markerAB[id]) {

                window.markerAB[id].setLatLng([latM, lonM])
                // console.log("Setlat for ", id)

            } else {

                // Add a new marker using the dynamic id as the key
                window.markerAB[id] = L.marker([latM, lonM], { icon: iconType })
                    .bindPopup("1st")
                    .openPopup();
                // Add marker to the LayerGroup
                aktivBoxLayer.addLayer(markerAB[id]);
                // Ensure the layer is added to the map
                aktivBoxLayer.addTo(map);
                // console.log("create marker for ", id)
            }


        } else {
            console.warn("Leaflet widget found, but map is not ready yet. Retrying...");
            setTimeout(() => addMarkerToLeafletMap(id, idhtmlwidget, latM, lonM, flag, iconUser, iconUserSize), 500); // Retry after 500ms
        }
    } else {
        console.warn("Leaflet widget not found. Retrying...");
        setTimeout(() => addMarkerToLeafletMap(id, idhtmlwidget, latM, lonM, flag, iconUser, iconUserSize), 500); // Retry after 500ms
    }
}




async function fetchrrst(boxids) {

    const data = { 'boxid': boxids }; // Create an object with the key 'boxid' and assign the array as its value
    // Now stringify the object
    const jsonString = JSON.stringify(data);
    // console.log('jsonString:', jsonString)

    // const response = await fetch('http://localhost:8080/api/get-data', {
    const response = await fetch('https://rrstdevices-app-zntch.ondigitalocean.app/api/get-data', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: jsonString
    });

    const responseData = await response.json();

    responseData.position.forEach(function (id) {
        console.log("Device:", id.DeviceID, "Received:", id.Received, "Flag:", id.Position.Flag, "Lat:", id.Position.Latitude, "Lon:", id.Position.Longitude)
    })

    if (!response.ok) {
        throw new Error(`API Request Failed: ${response.status}`);
    }
    return await responseData; // Return API response
}

async function fetchrrstdevices() {

    const response = await fetch('https://rrstdevices-app-zntch.ondigitalocean.app/api/get-devices', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        // body: jsonString
    });

    const responseData = await response.json();
    console.log("Got new get-devices");

    if (!response.ok) {
        throw new Error(`API Request Failed: ${response.status}`);
    }
    return await responseData; // Return API response
}