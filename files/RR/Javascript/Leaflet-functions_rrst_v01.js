document.addEventListener("DOMContentLoaded", function () {

    function addMarkerToLeafletMap(idhtmlwidget, latM, lonM, flag, icon1, icon2) {
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
                var iconEnd = flag === "X" ? icon2 : icon1;

                // Define custom Awesome Icon using Font Awesome
                var awesomeIcon = L.icon({
                    iconUrl: iconEnd,
                    iconSize: [50, 50], // Size of the icon
                    iconAnchor: [15, 30], // Point of the icon that will correspond to marker's location
                    popupAnchor: [0, -30] // Popup position when opened
                });

                // Add marker dynamically
                // var markerAB = L.marker([latM, lonM])
                var markerAB = L.marker([latM, lonM], { icon: awesomeIcon })
                    .bindPopup("1st")
                    .openPopup();

                // Add marker to the LayerGroup
                aktivBoxLayer.addLayer(markerAB);

                // Ensure the layer is added to the map
                aktivBoxLayer.addTo(map);


            } else {
                console.warn("Leaflet widget found, but map is not ready yet. Retrying...");
                setTimeout(() => addMarkerToLeafletMap(latM, lonM, flag, icon1, icon2), 500); // Retry after 500ms
            }
        } else {
            console.warn("Leaflet widget not found. Retrying...");
            setTimeout(() => addMarkerToLeafletMap(latM, lonM, flag, icon1, icon2), 500); // Retry after 500ms
        }
    }



})


async function fetchrrst(boxids) {

    const data = { boxid: boxids }; // Create an object with the key 'boxid' and assign the array as its value
    // Now stringify the object
    const jsonString = JSON.stringify(data);

    //   const response = await fetch('https://rest.devices.raceresult.com/customers/846/devices/' + DeviceID, {
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
