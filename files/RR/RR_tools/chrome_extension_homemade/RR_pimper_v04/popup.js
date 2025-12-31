let exportDone = false;

document.addEventListener("DOMContentLoaded", () => {
    const exportBtn = document.getElementById("export");

    exportBtn.onclick = () => {
        // Disable button and show loading
        exportBtn.disabled = true;
        document.getElementById("out").innerText = "Export starting, wait !";


        chrome.tabs.query({ active: true, currentWindow: true }, tabs => {
            chrome.tabs.sendMessage(
                tabs[0].id,
                { action: "EXPORT_ALL" },
                response => {
                    if (response?.success) {
                        exportDone = true;
                        console.log("✅ Export completed");
                        document.getElementById("out").innerText = "✅ Export finished !";
                    } else {
                        document.getElementById("out").innerText = "❌ Export error !";
                    }
                    // Restore button and hide loading
                    exportBtn.disabled = false;
                }
            );
        });
    };




    const deleteBtn = document.getElementById("delete");
    const out = document.getElementById("out");

    deleteBtn.onclick = () => {
        if (!confirm("Have you exported all items before deleting?")) return;
        if (!confirm("This will DELETE ALL items. Are you sure?")) return;

        deleteBtn.disabled = true;
        out.innerText = "⏳ Delete all started...";

        chrome.tabs.query({ active: true, currentWindow: true }, tabs => {
            chrome.tabs.sendMessage(tabs[0].id, { action: "DELETE_ALL" }, response => {
                console.log("Delete_ALL message sent", response);
            });
        });
    };

    // Receive progress messages
    chrome.runtime.onMessage.addListener((msg) => {
        if (msg.action === "DELETE_PROGRESS") {
            out.innerText = `⏳ Deleting item ${msg.current} of ${msg.total}...`;
        }
        if (msg.action === "DELETE_ALL_FINISHED") {
            out.innerText = "✅ Delete finished!";
            deleteBtn.disabled = false;
        }
    });



});
