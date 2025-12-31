console.log("✅ content.js loaded");

function clickDiv() {
    const div = document.querySelector("#divDockRight");
    if (div) {
        div.click();
        console.log("✅ divDockRight clicked!");
    } else {
        console.log("❌ divDockRight not found.");
    }
}



// Relay progress messages to popup
window.addEventListener("message", (event) => {
    if (event.source !== window) return;

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
});


// Listen for messages from popup
chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
    if (msg.action === "clickDiv") clickDiv();

    if (msg.action === "DELETE_ALL") {
        const script = document.createElement("script");
        script.src = chrome.runtime.getURL("deleteAllItems.js"); // runs in page
        script.onload = () => script.remove();
        (document.head || document.documentElement).appendChild(script);
        sendResponse({ success: true });
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
                        .replace(/[\/\\:*?"<>|]/g, "_");
                    zip.file(safeName, blob);
                });

                // 1️⃣ Get event name
                let eventName =
                    document.querySelector("#eventname")?.innerText ||
                    "AllList_exported";

                // 2️⃣ Sanitize
                eventName = eventName
                    .replace(/[\/\\:*?"<>|]/g, "")
                    .replace(/\s+/g, "_");

                // 3️⃣ YYYYMMDD prefix
                const now = new Date();
                const y = now.getFullYear();
                const m = String(now.getMonth() + 1).padStart(2, "0");
                const d = String(now.getDate()).padStart(2, "0");
                const datePrefix = `${y}${m}${d}`;

                const zipFilename = `${datePrefix}__${eventName}_AllList.zip`;

                const zipBlob = await zip.generateAsync({ type: "blob" });

                const url = URL.createObjectURL(zipBlob);
                const a = document.createElement("a");
                a.href = url;
                a.download = zipFilename;
                a.click();
                URL.revokeObjectURL(url);
            });



        };
        (document.head || document.documentElement).appendChild(script);
    }

    return true;
});
