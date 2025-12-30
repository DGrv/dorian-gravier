document.addEventListener("DOMContentLoaded", () => {

    // Export all (optional)
    document.getElementById("export").onclick = () => {
        chrome.tabs.query({ active: true, currentWindow: true }, tabs => {
            chrome.tabs.sendMessage(tabs[0].id, { action: "EXPORT_ALL" }, response => {
                console.log("Export all response:", response);
            });
        });
    };

});
