console.log("✅ content.js loaded");


// Listen for messages from popup
chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
    if (msg.action === "EXPORT_ALL") {
        const script = document.createElement('script');
        script.src = chrome.runtime.getURL('exportAllItems.js'); // now allowed by CSP
        script.onload = () => script.remove();
        (document.head || document.documentElement).appendChild(script);
        sendResponse({ success: true });
    }
    return true;
});
