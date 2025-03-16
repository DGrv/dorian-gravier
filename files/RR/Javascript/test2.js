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
    console.log(responseData)
    // console.log(accessToken)

    if (!response.ok) {
        throw new Error(`API Request Failed: ${response.status}`);
    }
    return await responseData; // Return API response
}


// setInterval(async () => {
    try {

        // await fetchrrst(["T-20346", "T-21009"]).then(data => {
        fetchrrst(["T-20346", "T-21009"]).then(data => {
            // console.log('API Response:', data);
            const data2=data;
            // aktivBoxLayer.clearLayers()
            console.log("I got this from fetchrrst:", data)
            data.position.forEach(function (id) {
                console.log("Device:", id.DeviceID, "Flag:", id.Position.Flag, "Lat:", id.Position.Latitude, "Lon:", id.Position.Longitude, "Received:", id.Received)
            })


        }).catch(error => console.error('Error:', error));

    } catch (error) {
        console.error('Error during periodic fetch:', error);
    }
