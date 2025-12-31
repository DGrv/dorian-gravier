let exportDone = false;

document.addEventListener("DOMContentLoaded", () => {
    const exportBtn = document.getElementById("export");
    const deleteBtn = document.getElementById("delete");

    const importBtn = document.getElementById("import");
    const fileInput = document.getElementById("importFiles");
    const out = document.getElementById("out");

    importBtn.onclick = () => {
        console.log("▶ IMPORT_ALL clicked");
        const filesInput = document.getElementById("importFiles");
        if (!filesInput.files.length) {
            out.innerText = "❌ No files selected!";
            console.warn("No files selected for import");
            return;
        }

        importBtn.disabled = true;
        out.innerText = `⏳ Importing ${filesInput.files.length} files...`;

        const fileList = Array.from(filesInput.files);

        chrome.tabs.query({ active: true, currentWindow: true }, tabs => {
            fileList.forEach((file, idx) => {
                try {
                    const reader = new FileReader();

                    reader.onload = (e) => {
                        console.log(`📄 File read successfully: ${file.name}`);
                        const content = e.target.result;
                        // send content to content.js
                        chrome.tabs.sendMessage(
                            tabs[0].id,
                            { action: "IMPORT_FILE", filename: file.name, content },
                            response => {
                                console.log(`IMPORT_FILE response for ${file.name}:`, response);
                            }
                        );
                    };

                    reader.onerror = (err) => {
                        console.error(`❌ Error reading file ${file.name}:`, err);
                        out.innerText = `❌ Error reading file ${file.name}`;
                    };

                    reader.readAsText(file);
                } catch (e) {
                    console.error(`❌ Synchronous error while reading file ${file.name}:`, e);
                    out.innerText = `❌ Error reading file ${file.name}`;
                }

            });
        });
    };






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

        if (msg.type === "IMPORT_PROGRESS") {
            out.innerText = `⏳ Importing list ${msg.current} of ${msg.total}: ${msg.listName}`;
        }
        if (msg.type === "IMPORT_ALL_FINISHED") {
            out.innerText = "✅ Import finished!";
        }


    });



});
