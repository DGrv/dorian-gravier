(function () {

    /**
     * Sends a status update message from the Page World to the Content Script World.
     * @param {string} text The text to display.
     */
    function reportStatus(text) {
        window.postMessage({
            type: "STATUS_UPDATE",
            message: text
        }, "*");
    }

    /**
     * Send device data back to content script
     */
    function sendDeviceData(data) {
        window.postMessage({
            type: "DEVICE_DATA_UPDATE",
            data: data
        }, "*");
    }

    /**
     * Main function to get devices and links data
     */
    async function getDevicesAndLinks() {
        try {
            console.log('Fetching devices and links data...');

            const data = await parent.RM().Timing.Devices();
            
            if (!data) {
                reportStatus('❌ No data received');
                return null;
            }

            const devices = data.Devices || {};
            const links = data.Links || {};

            // Extract and combine data
            const combinedData = [];

            for (const linkKey in links) {
                const link = links[linkKey];
                const deviceID = link.DeviceID;
                const device = devices[deviceID];

                if (device) {
                    combinedData.push({
                        LinkID: link.LinkID,
                        DeviceID: deviceID,
                        TimingPoint: link.TimingPoint,
                        PassingsWritten: link.PassingsWritten,
                        SinceLastPassing: link.SinceLastPassing,
                        Paused: link.Paused,
                        // Device info
                        DeviceName: device.Name,
                        DeviceType: device.Type,
                        LastSeen: device.LastSeen,
                        SinceLastSeen: device.SinceLastSeen,
                        BatteryCharge: device.Status?.BatteryCharge || 'N/A',
                        MemoryLeft: device.Status?.MemoryLeft || 'N/A',
                        Temperature: device.Status?.Temperature || 'N/A',
                        NetProvider: device.Status?.NetProvider || 'N/A',
                        NetSignal: device.Status?.NetSignal || 'N/A',
                        BoxMode: device.Status?.BoxMode || 'N/A',
                        BoxPower: device.Status?.BoxPower || 'N/A',
                        ReaderStatus: device.Status?.ReaderStatus || 'N/A',
                        ConnStatus: device.Status?.ConnStatus || 0
                    });
                } else {
                    console.warn(`Device ${deviceID} not found in Devices list`);
                }
            }

            console.log(`Found ${combinedData.length} links with device data`);
            
            // Send data back to content script
            sendDeviceData(combinedData);

            return combinedData;

        } catch (error) {
            console.error('Error:', error);
            reportStatus(`❌ Error: ${error.message}`);
            return null;
        }
    }

    // Call the function
    getDevicesAndLinks();

})();
