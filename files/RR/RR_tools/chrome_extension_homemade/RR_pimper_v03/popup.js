let exportDone = false;

document.addEventListener("DOMContentLoaded", () => {

    // EXPORT
    document.getElementById("export").onclick = () => {
        chrome.tabs.query({ active: true, currentWindow: true }, tabs => {
            chrome.tabs.sendMessage(
                tabs[0].id,
                { action: "EXPORT_ALL" },
                response => {
                    if (response?.success) {
                        exportDone = true;
                        console.log("✅ Export completed");
                        alert("Export finished. You can now delete all items.");
                    }
                }
            );
        });
    };

    // DELETE (guarded)
    document.getElementById("delete").onclick = () => {
        if (!exportDone) {
            alert("⚠️ Please export all items before deleting.");
            return;
        }

        if (!confirm("⚠️ This will DELETE ALL items. Are you sure?")) {
            return;
        }

        chrome.tabs.query({ active: true, currentWindow: true }, tabs => {
            chrome.tabs.sendMessage(
                tabs[0].id,
                { action: "DELETE_ALL" }
            );
        });
    };

});
