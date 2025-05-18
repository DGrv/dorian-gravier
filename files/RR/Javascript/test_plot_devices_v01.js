const fs = require('fs');

// Synchronously read JSON file
const data = fs.readFileSync('resp2.json', 'utf-8');
const json = JSON.parse(data);
// const allowedIDs=["T-20022", "T-20021"]
// var devicesData = json.Devices.filter(device => allowedIDs.includes(device.DeviceID));

// Get current time and subtract 2 days (in ms)
const twoDaysAgo = new Date(Date.now() - 2 * 24 * 60 * 60 * 1000);

// Filter
const recentData = json.Devices.filter(item => new Date(item.Received) > twoDaysAgo);


console.log(recentData);