const fs = import('fs');

async function fetchrrstdevices() {

    const response = await fetch('https://rrstdevices-app-zntch.ondigitalocean.app/api/get-devices', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });

    const responseData = await response.json();
    console.log(responseData)

    // responseData.position.forEach(function (id) {
    //     console.log("Device:", id.DeviceID, "Received:", id.Received, "Flag:", id.Position.Flag, "Lat:", id.Position.Latitude, "Lon:", id.Position.Longitude)
    // })

    if (!response.ok) {
        throw new Error(`API Request Failed: ${response.status}`);
    }
    return await responseData; // Return API response
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

// fetchrrst("T-20022");
fetchrrstdevices();
