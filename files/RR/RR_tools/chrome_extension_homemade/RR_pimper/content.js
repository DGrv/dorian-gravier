console.log("%c RR Pimper", "font-weight: bold; font-size: 30px; color: #293BFF; text-shadow: 3px 3px 0 #2BCCCC , 6px 6px 0 #57CCFF , 9px 9px 0 #33FF57 , 12px 12px 0 #FFC300 , 15px 15px 0 #FF5733 , 18px 18px 0 #F52B9A , 21px 21px 0 #9A2BF5;");


// Add these variables at the top of content.js
let deviceMonitorInterval = null;
let deviceStatusDiv = null;





function clickDiv() {
    const div = document.querySelector("#divDockRight");
    if (div) {
        div.click();
        console.log("✅ divDockRight clicked!");
    } else {
        console.log("❌ divDockRight not found.");
    }
}





/**
 * Finds the notification element with the ID 'out' on the page.
 * If the element doesn't exist, it creates and styles it, then appends it to the page.
 * @returns {HTMLElement} The 'out' element.
 */
function getOrCreateOutElement() {
    let out = document.getElementById("out");

    if (!out) {
        out = document.createElement('div');
        out.id = 'out';
        Object.assign(out.style, {
            position: 'fixed',
            top: '50%',
            left: '50%',
            transform: 'translate(-50%, -50%)',
            backgroundColor: 'rgba(0, 0, 0, 0.85)',
            color: 'white',
            padding: '25px',
            borderRadius: '10px',
            zIndex: '9999',
            fontSize: '20px',
            textAlign: 'center',
            minWidth: '350px',
            boxShadow: '0 5px 15px rgba(0,0,0,0.5)'
        });
        document.body.appendChild(out);

        // Simple: hide on any click
        let hideListener;
        hideListener = () => {
            const outElement = document.getElementById('out');
            if (outElement) {
                outElement.style.display = 'none';
            }
            document.removeEventListener('click', hideListener, true);
        };

        // Delay adding the listener so it doesn't trigger immediately
        setTimeout(() => {
            document.addEventListener('click', hideListener, true);
        }, 100);
    }

    out.style.display = 'block';
    return out;
}




// 1. Create a single, reusable function to handle all status displays.
function displayStatus(text) {
    const out = getOrCreateOutElement(); // Uses the function we created earlier
    out.innerText = text;

    // Automatically hide final-state messages
    const isFinalState = text.includes("✅") || text.includes("❌");
    if (isFinalState) {
        setTimeout(() => {
            if (out) {
                out.style.display = 'none';
            }
        }, 4000);
    }
}



/**
 * Start monitoring devices (inject script every 5 seconds)
 */
function startDeviceMonitoring() {
    console.log("Starting device monitoring...");

    // Create the floating div if it doesn't exist
    if (!deviceStatusDiv) {
        createDeviceStatusDiv();
    }

    // Initial fetch
    injectDeviceScript();

    // Set interval to refresh every 10 seconds
    deviceMonitorInterval = setInterval(() => {
        injectDeviceScript();
    }, 10000);
}

/**
 * Stop monitoring devices
 */
function stopDeviceMonitoring() {
    console.log("Stopping device monitoring...");

    if (deviceMonitorInterval) {
        clearInterval(deviceMonitorInterval);
        deviceMonitorInterval = null;
    }

    if (deviceStatusDiv) {
        deviceStatusDiv.remove();
        deviceStatusDiv = null;
    }
}

/**
 * Inject the device script
 */
function injectDeviceScript() {
    const script = document.createElement("script");
    script.src = chrome.runtime.getURL("getDevicesLinks.js");
    script.onload = () => {
        script.remove();
    };
    (document.head || document.documentElement).appendChild(script);
}

/**
 * Create the floating device status div
 */
function createDeviceStatusDiv() {

// Inject CSS animation for blinking border
    if (!document.getElementById('device-status-style')) {
        const style = document.createElement('style');
        style.id = 'device-status-style';
        style.textContent = `
            @keyframes device-alert-blink {
                0%, 100% { 
                    border-color: #c41011;
                    border-width: 2px;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
                }
                50% { 
                    border-color: #ff0000;
                    border-width: 4px;
                    box-shadow: 0 0 20px rgba(196, 16, 17, 0.8);
                }
            }
            .device-alert {
                animation: device-alert-blink 1s infinite !important;
            }
        `;
        document.head.appendChild(style);
    }


    deviceStatusDiv = document.createElement("div");
    deviceStatusDiv.id = "racemgr-device-status";
    deviceStatusDiv.style.cssText = `
        position: fixed;
        top: 10px;
        left: 50%;
        transform: translateX(-50%);
        background: rgba(255, 255, 255, 0.95);
        border: 2px solid #c41011;
        border-radius: 8px;
        padding: 10px 20px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        z-index: 999999;
        display: flex;
        gap: 10px;
        align-items: center;
        font-family: sans-serif;
    `;
    deviceStatusDiv.innerHTML = '<span style="font-size: 12px; color: #666;">Loading devices...</span>';
    document.body.appendChild(deviceStatusDiv);
}

/**
 * Update the device status div with new data
 */
function updateDeviceStatusDiv(devices) {
    if (!deviceStatusDiv) return;

    deviceStatusDiv.innerHTML = '';


    // Check if any device is disconnected
    const hasDisconnected = devices.some(device => device.ConnStatus <= 0);

    // Add or remove blinking animation based on connection status
    if (hasDisconnected) {
        deviceStatusDiv.classList.add('device-alert');
    } else {
        deviceStatusDiv.classList.remove('device-alert');
    }

    devices.forEach(device => {
        const deviceIcon = document.createElement("div");
        deviceIcon.style.cssText = `
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 4px;
        `;

        const img = document.createElement("img");
        img.src = chrome.runtime.getURL(device.ConnStatus > 0 ? "icons/connected.png" : "icons/disconnected.png");
        img.style.cssText = "width: 16px; height: 16px;";
        img.title = `${device.DeviceID} - ${device.TimingPoint}\nPassings: ${device.PassingsWritten}\nLast: ${device.SinceLastPassing}s ago`;

        const labelDeviceID = document.createElement("span");
        labelDeviceID.textContent = device.DeviceID;
        labelDeviceID.style.cssText = "font-size: 10px; color: #333; font-weight: 500;";
        
        const labelTimingPoint = document.createElement("span");
        labelTimingPoint.textContent = device.TimingPoint;
        labelTimingPoint.style.cssText = "font-size: 8px; color: #333; font-weight: 500;";

        const labelReads = document.createElement("span");
        labelReads.textContent = device.PassingsWritten;
        labelReads.style.cssText = "font-size: 6px; color: #333; font-weight: 100; font-style: italic;";

        const labelSinceLastPassing = document.createElement("span");
        labelSinceLastPassing.textContent = device.SinceLastPassing;
        labelSinceLastPassing.style.cssText =
          "font-size: 6px; color: #333; font-weight: 100; font-style: italic;";

        deviceIcon.appendChild(labelTimingPoint);
        deviceIcon.appendChild(img);
        deviceIcon.appendChild(labelDeviceID);
        deviceIcon.appendChild(labelReads);
        deviceIcon.appendChild(labelSinceLastPassing);
        deviceStatusDiv.appendChild(deviceIcon);
    });
}





window.addEventListener("message", (event) => {
    // Make sure the message is from our script
    if (event.source !== window || !event.data.type) {
        return;
    }
    if (event.data.type === "IMPORT_PROGRESS") {
        const out = document.getElementById("out");
        out.innerText = `⏳ Imported ${event.data.current} of ${event.data.total}: ${event.data.name}`;
        chrome.runtime.sendMessage(event.data);

        if (event.data.current === event.data.total) {
            out.innerText = "✅ All imports finished!";
            importBtn.disabled = false;
        }
    }
    if (event.data.type === "DELETE_PROGRESS") {
        chrome.runtime.sendMessage({
            action: "DELETE_PROGRESS",
            current: event.data.current,
            total: event.data.total
        });
    }

    if (event.data.type === "DELETE_ALL_FINISHED") {
        chrome.runtime.sendMessage({ action: "DELETE_ALL_FINISHED" });
    }

    // Check for the specific message type from importAllItems.js
    if (event.data.type === "STATUS_UPDATE") {
        displayStatus(event.data.message);
    }

    if (event.data.type === "DEVICE_DATA_UPDATE") {
        updateDeviceStatusDiv(event.data.data);
    }


});


// Listen for messages from popup
chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {

    const out = getOrCreateOutElement();
    out.style.display = 'none';

    // Handle the request to click the section header
    if (msg.action === "CLICK_SECTION_HEADER") {
        const listHeader = [...document.querySelectorAll(".SectionHeader")]
            .find(div => ["Lists", "Listen", "Listes / Éditions", "Liste", "Listas"].includes(div.innerText.trim()));

        if (listHeader) {
            listHeader.click();
            console.log("✅ Clicked section header.");
        } else {
            console.log("❌ Section header not found.");
        }
        sendResponse({ success: true });
        return true;
    }



    if (msg.type === "SHOW_STATUS") {
        const out = getOrCreateOutElement();
        out.innerText = msg.message; // Set the text from the message

        // Smart-hide: Automatically hide final-state messages
        const isFinalState = msg.message.includes("✅") || msg.message.includes("❌");
        if (isFinalState) {
            setTimeout(() => {
                if (out) {
                    out.style.display = 'none';
                }
            }, 4000);
        }
    }

    if (msg.action === "clickDiv") clickDiv();

    if (msg.action === "DELETE_ALL") {
        const script = document.createElement("script");
        script.src = chrome.runtime.getURL("deleteAllItems.js"); // runs in page
        script.onload = () => script.remove();
        (document.head || document.documentElement).appendChild(script);
        sendResponse({ success: true });
    }

    if (msg.action === "IMPORT_FILES_BATCH") {
        console.log("📥 IMPORT_FILES_BATCH received", msg.files.length, "files");

        if (!window.__importInjected) {
            console.log("🧩 Injecting importAllItems.js");

            const script = document.createElement("script");
            script.src = chrome.runtime.getURL("importAllItems.js");
            script.onload = () => {
                console.log("✅ importAllItems.js injected");
                script.remove();

                // 🔁 send AFTER injection
                window.postMessage({
                    type: "IMPORT_FILE_DATA",
                    files: msg.files
                }, "*");
            };

            (document.head || document.documentElement).appendChild(script);
            window.__importInjected = true;

        } else {
            // script already there → send immediately
            window.postMessage({
                type: "IMPORT_FILE_DATA",
                files: msg.files
            }, "*");
        }

        sendResponse({ success: true });
        return true;
    }

    if (msg.action === "EXPORT_ALL") {
        const script = document.createElement('script');
        script.src = chrome.runtime.getURL('exportAllItems.js');
        script.onload = () => {
            script.remove();
            // console.log("Script injected");

            let zipCreated = false;

            window.addEventListener("message", async (event) => {
                if (event.source !== window) return;
                if (event.data.type !== "EXPORT_ALL_ZIP") return;
                if (zipCreated) return; // 🔒
                zipCreated = true;


                const files = event.data.files;
                if (!files?.length) return;


                // Now that we are SURE the 'out' element exists on the page, we update its text.
                out.innerText = `⏳ Creating ZIP with ${files.length} items...`;

                // Load JSZip if needed
                if (!window.JSZip) {
                    await new Promise(resolve => {
                        const s = document.createElement("script");
                        s.src = chrome.runtime.getURL("jszip.min.js");
                        s.onload = resolve;
                        document.documentElement.appendChild(s);
                    });
                }

                const zip = new JSZip();

                files.forEach(({ filename, blob }) => {
                    const safeName = (filename || "item.lvs")
                        .replace(/[\\/\\\\:*?"<>|]/g, "_");

                    const prettifiedContentPromise = blob.text().then(text => {
                        try {
                            const jsonObject = JSON.parse(text);
                            return JSON.stringify(jsonObject, null, 2);
                        } catch (e) {
                            return text;
                        }
                    }).catch(() => {
                        return blob;
                    });

                    zip.file(safeName, prettifiedContentPromise);
                });


                // 1️⃣ Get event name
                let eventName =
                    document.querySelector("#eventname")?.innerText ||
                    "AllList_exported";

                // 2️⃣ Sanitize
                eventName = eventName
                    .replace(/[\\/\\\\:*?"<>|]/g, "")
                    .replace(/\\s+/g, "_");

                // 3️⃣ YYYYMMDD prefix
                // 3️⃣ YYYYMMDD_HHMM prefix
                const now = new Date();
                const y = now.getFullYear();
                const m = String(now.getMonth() + 1).padStart(2, "0");
                const d = String(now.getDate()).padStart(2, "0");
                const h = String(now.getHours()).padStart(2, "0");
                const min = String(now.getMinutes()).padStart(2, "0");
                const datePrefix = `${y}${m}${d}-${h}${min}`;


                const zipFilename = `${datePrefix}__${eventName}_AllList.zip`;

                const zipBlob = await zip.generateAsync({ type: "blob" });

                const url = URL.createObjectURL(zipBlob);
                const a = document.createElement("a");
                a.href = url;
                a.download = zipFilename;
                a.click();
                URL.revokeObjectURL(url);

                // This part is already correct and should stay
                displayStatus(`✅ Export finished!`); // Using the helper function is cleaner

                // NEW: Announce to the entire extension that the process is complete.
                chrome.runtime.sendMessage({ type: "EXPORT_PROCESS_COMPLETE" });
            });
        };
        (document.head || document.documentElement).appendChild(script);

    }



    if (msg.action === "GET_ENTRY_FEES") {
        const script = document.createElement("script");
        script.src = chrome.runtime.getURL("getEntryFees.js");
        script.onload = () => {
            script.remove();
            console.log("✅ getEntryFees.js injected and executed");
        };
        (document.head || document.documentElement).appendChild(script);
        sendResponse({ success: true });
        return true;
    }

    if (msg.action === "GET_DEVICES_LINKS") {
        const script = document.createElement("script");
        script.src = chrome.runtime.getURL("getDevicesLinks.js");
        script.onload = () => {
            script.remove();
            console.log("✅ getDevicesLinks.js injected and executed");
        };
        (document.head || document.documentElement).appendChild(script);
        sendResponse({ success: true });
        return true;
    }

    if (msg.action === "START_DEVICE_MONITORING") {
        startDeviceMonitoring();
        sendResponse({ success: true });
        return true;
    }

    if (msg.action === "STOP_DEVICE_MONITORING") {
        stopDeviceMonitoring();
        sendResponse({ success: true });
        return true;
    }


    return true;
});

