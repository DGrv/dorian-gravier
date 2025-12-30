document.addEventListener("DOMContentLoaded", () => {
    document.getElementById("export").onclick = () => {
        chrome.tabs.query({ active: true, currentWindow: true }, tabs => {
            chrome.tabs.sendMessage(tabs[0].id, { action: "EXPORT_ALL" }, response => {
                console.log("Response from content script:", response);
            });
        });
    };
});
