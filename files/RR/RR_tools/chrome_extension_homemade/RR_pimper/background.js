chrome.commands.onCommand.addListener((command) => {
  chrome.tabs.query({active: true, currentWindow: true}, (tabs) => {
    const tabId = tabs[0]?.id;
    if (!tabId) return;

    console.log("Command received:", command); // debug

    if (command === "trigger-click") {
      chrome.tabs.sendMessage(tabId, { action: "clickDiv" });
    }



  });
});


// Keep track of monitoring state per tab
const monitoringTabs = new Map();

chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
    if (msg.action === "START_MONITORING") {
        const tabId = msg.tabId;
        monitoringTabs.set(tabId, true);
        chrome.storage.local.set({ deviceMonitoringActive: true });
        sendResponse({ success: true });
    }

    if (msg.action === "STOP_MONITORING") {
        const tabId = msg.tabId;
        monitoringTabs.delete(tabId);
        chrome.storage.local.set({ deviceMonitoringActive: false });
        sendResponse({ success: true });
    }

    if (msg.action === "GET_MONITORING_STATE") {
        chrome.storage.local.get(['deviceMonitoringActive'], (result) => {
            sendResponse({ active: result.deviceMonitoringActive || false });
        });
        return true;
    }
});

// Clean up when tab is closed
chrome.tabs.onRemoved.addListener((tabId) => {
    monitoringTabs.delete(tabId);
});
