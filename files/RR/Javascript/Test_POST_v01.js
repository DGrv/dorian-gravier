async function authenticateAndRequest() {
    try {
        // Step 1: First POST request to get access token
        const authResponse = await fetch('https://rest.devices.raceresult.com/token', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'apikey': '846.dccb7479c667d522bbfe79d4f815251f0780317462a2f1a1d7e5de258efa3a79ca96e6facc7b6ce67d63d590f6c71854'
            },
            body: ""
        });

        if (!authResponse.ok) {
            throw new Error('Authentication failed');
        }

        const authData = await authResponse.json();
        const accessToken = authData.access_token;
        // const accessToken = 'eyJhbGciOiJlZDI1NTE5IiwidHlwIjoiSldUIn0.eyJhdWQiOiJkZXZpY2VzIiwiZXhwIjoxNzQxMTI5MDIyLCJzdWIiOiI4NDYifQ.UMjDADuJYqIiQgoHSY08QFuqEuGcE74b7-Pzb178COJDP9Zl37XLBaTwLoM4XVfiHXpavEavx57Pp6re7erOBw'

        console.log('Access Token:', accessToken);

        console.log("Headers:", {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${accessToken}`
        });

        // Step 2: Use access token to make a new request
        const apiResponse = await fetch('https://rest.devices.raceresult.com/customers/846/devices/T-20346', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${accessToken}`
            }
        });

        const responseData = await apiResponse.json();
        console.log('Response:', responseData);

        if (!apiResponse.ok) {
            throw new Error('API request failed');
        }

        const apiData = await apiResponse.json();
        console.log('API Response:', apiData);

    } catch (error) {
        console.error('Error:', error.message);
    }
}

// Run the function
authenticateAndRequest();
