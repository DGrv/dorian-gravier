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


// Listen for messages from popup
chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
    if (msg.action === "clickDiv") clickDiv();


    if (msg.action === "EXPORT_ALL") {
        const script = document.createElement('script');
        script.src = chrome.runtime.getURL('exportAllItems.js');
        script.onload = () => {
            script.remove();
            console.log("Script injected");

            window.addEventListener("message", function handler(event) {
                if (event.source !== window) return;
                if (event.data.type === "EXPORT_ALL_ZIP") {
                    window.removeEventListener("message", handler);

                    const zip = new JSZip();
                    event.data.data.forEach(item => {
                        const filename = (item.fullname || "item").replace(/[\/\\:*?"<>|]/g, "_") + ".txt";
                        zip.file(filename, item.content);
                    });

                    zip.generateAsync({ type: "blob" }).then(content => {
                        const url = URL.createObjectURL(content);

                        // 1️⃣ Get text from #eventname
                        let eventName = document.querySelector("#eventname")?.innerText || "exported_items";

                        // 2️⃣ Sanitize: remove invalid filename chars, keep spaces or replace by _
                        eventName = eventName.replace(/[\/\\:*?"<>|]/g, "").replace(/\s+/g, "_");

                        // 3️⃣ Add short YYYYMMDD timestamp at the start
                        const now = new Date();
                        const y = now.getFullYear();
                        const m = String(now.getMonth() + 1).padStart(2, "0");
                        const d = String(now.getDate()).padStart(2, "0");
                        const datePrefix = `${y}${m}${d}`;

                        const zipFilename = `${datePrefix}__${eventName}.zip`;

                        const a = document.createElement("a");
                        a.href = url;
                        a.download = zipFilename;
                        a.click();
                        URL.revokeObjectURL(url);
                    });
                }
            });




        };
        (document.head || document.documentElement).appendChild(script);
    }

    return true;
});
