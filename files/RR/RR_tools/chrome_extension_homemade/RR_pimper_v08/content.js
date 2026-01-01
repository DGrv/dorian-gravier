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


/**
 * Finds the notification element with the ID 'out' on the page.
 * If the element doesn't exist, it creates and styles it, then appends it to the page.
 * @returns {HTMLElement} The 'out' element.
 */
function getOrCreateOutElement() {
    let out = document.getElementById("out");

    // If the 'out' element is NOT found on the web page...
    if (!out) {
        // ...then we create it from scratch.
        out = document.createElement('div');
        out.id = 'out'; // We give it the ID "out"
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

        // And we add it to the web page's body.
        document.body.appendChild(out);
    }

    // Make sure it's visible before returning
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

                // This part is already correct and should stay
                displayStatus(`✅ Export finished!`); // Using the helper function is cleaner

                // NEW: Announce to the entire extension that the process is complete.
                chrome.runtime.sendMessage({ type: "EXPORT_PROCESS_COMPLETE" });
            });
        };
        (document.head || document.documentElement).appendChild(script);

    }



    return true;
});
