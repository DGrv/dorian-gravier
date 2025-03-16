var test = {
    "Devices": [{
        "Customer": 846,
        "DeviceID": "D-4013",
        "Received": "2024-12-31T09:48:27.109639511Z",
        "DeviceName": "D-4013",
        "FileNo": 359,
        "BatteryCharge": -1,
        "Temperature": 21.48,
        "RecordsCount": 0,
        "IsRunTime": false,
        "RealTime": "2025-03-14T17:12:43.656496605+01:00",
        "RealTimeAtRequest": "2024-12-31T10:48:27.059+01:00",
        "RunTime": 0,
        "RunTimeAtRequest": 0,
        "UTCOffset": 3600,
        "TimeZoneName": "Europe/Amsterdam",
        "Position": {
            "Flag": "S",
            "Latitude": 48.29741,
            "Longitude": 11.170029
        },
        "Connected": false,
        "DeviceType": "Decoder",
        "DecoderStatus": {
            "Protocol": 3.3,
            "Firmware": "2.65",
            "Antennas": "11111111",
            "HasPower": true,
            "Ext12Volt": 0.03,
            "IsInTimingMode": true,
            "ReaderIsHealthy": true,
            "TimeIsRunning": true,
            "ReaderTemperature": 21,
            "DeadTime": 5000,
            "ReactionTime": 850,
            "Notification": "BLINK",
            "TimeSource": 1,
            "AutomaticStandbyEnabled": false,
            "IsInStandby": false,
            "ErrorFlags": 0
        }
    }, {
        "Customer": 846,
        "DeviceID": "D-4040",
        "Received": "2019-04-28T08:31:59.893Z",
        "DeviceName": "D-4040",
        "FileNo": 359,
        "BatteryCharge": 44,
        "Temperature": 29.68,
        "RecordsCount": 6837,
        "IsRunTime": false,
        "RealTime": "2025-03-14T16:12:43.019141527Z",
        "RealTimeAtRequest": "2019-04-28T08:31:59.205Z",
        "RunTime": 0,
        "RunTimeAtRequest": 0,
        "UTCOffset": 7200,
        "Position": {
            "Flag": "S",
            "Latitude": 47.360847,
            "Longitude": 8.535442
        },
        "Connected": false,
        "DeviceType": "Decoder",
        "DecoderStatus": {
            "Protocol": 2.8,
            "Antennas": "11111111",
            "HasPower": false,
            "IsInTimingMode": true,
            "ReaderIsHealthy": true,
            "TimeIsRunning": true,
            "ReaderTemperature": 38,
            "UHFFrequency": 2,
            "TimeSource": 1,
            "AutomaticStandbyEnabled": false,
            "IsInStandby": false,
            "ErrorFlags": 0
        }
    }]}


console.log(test.Devices)

var deviceData = test.Devices.find(device => device.DeviceID === "D-4040");
var devicesData = test.Devices.filter(device => ["D-4040", "D-4013"].includes(device.DeviceID));

devicesData.forEach(function(id) {
    console.log(id.Position);  // Output: "D-4040"
})