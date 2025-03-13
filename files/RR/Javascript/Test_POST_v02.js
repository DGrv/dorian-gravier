
async function fetchData(DeviceID) {
    async function apiRequest(token) {
        const response = await fetch('https://rest.devices.raceresult.com/customers/846/devices/' + DeviceID, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${accessToken}`
            }
        });

        const responseData = await response.json();
        // console.log(responseData)
        // console.log(accessToken)
        const position = responseData.Position;
        console.log("Latitude: ", position.Latitude)

        if (!response.ok) { 
            throw new Error(`API Request Failed: ${response.status}`); 
        }
        return await position; // Return API response
        // return await responseData; // Return API response
    }

    async function getNewToken() {
        const authResponse = await fetch('https://rest.devices.raceresult.com/token', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                // 'apikey': 'blabla'
                'apikey': '846.dccb7479c667d522bbfe79d4f815251f0780317462a2f1a1d7e5de258efa3a79ca96e6facc7b6ce67d63d590f6c71854'
            },
            body: ""
        });

        if (!authResponse.ok) { 
            throw new Error(`Auth Failed: ${authResponse.status}`); 
        }
        
        const data = await authResponse.json();
        // console.log('Response getNewToken:', data);
        return data.access_token;
    }

    try {
        if (typeof accessToken !== 'undefined' && accessToken !== null) {
            // First API request attempt
            console.log("I Have alread a token ahahaha");
            return await apiRequest(accessToken);
        } else {
            accessToken = await getNewToken();
            return await apiRequest(accessToken);
        }
    } catch (error) {
        if (error.message.includes('401')) { 
            console.warn("Token expired, getting a new one...");
            accessToken = await getNewToken();
            return await apiRequest(accessToken); // Retry with new token
        } else {
            throw error; // If not 401, throw other errors
        }
    }
}

// Run the function
fetchData("D-5022").then(data => console.log('API Response:', data)).catch(error => console.error('Error:', error));

// // Run the function every 5 seconds
// setInterval(async () => {
//     try {
//         await fetchData("D-5022").then(data => console.log('API Response:', data)).catch(error => console.error('Error:', error));;
//     } catch (error) {
//         console.error('Error during periodic fetch:', error);
//     }
// }, 5000);  // 5000 milliseconds = 5 seconds
