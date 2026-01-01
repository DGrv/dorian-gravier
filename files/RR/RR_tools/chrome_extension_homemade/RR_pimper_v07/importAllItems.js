(function () {
    console.log("🟢 importAllItems.js loaded");

    // --- State Variables ---
    if (!window.__importFilesQueue) {
        window.__importFilesQueue = [];
    }
    let isImporting = false;
    let importIndex = 0; // Use a properly scoped variable

    // --- Event Listener ---
    window.addEventListener("message", (event) => {
        if (event.source !== window || event.data?.type !== "IMPORT_FILE_DATA") {
            return;
        }

        console.log("📥 IMPORT_FILE_DATA received", event.data.files);
        window.__importFilesQueue.push(...event.data.files);

        if (!isImporting) {
            startImportProcess();
        }
    });

    // --- Core Functions ---
    function startImportProcess() {
        console.log("🚀 Starting import process...");
        isImporting = true;
        importIndex = 0; // Reset index for the new batch
        importNextFile();
    }

    function finishImportProcess() {
        console.log("✅ IMPORT ALL FINISHED");
        isImporting = false;
        window.__importFilesQueue = []; // Clear the queue
        window.postMessage({ type: "IMPORT_ALL_FINISHED" }, "*");
    }

    function importNextFile() {
        const files = window.__importFilesQueue;

        console.log(`📦 Queue status: ${importIndex + 1} / ${files.length}`);

        if (importIndex >= files.length) {
            finishImportProcess();
            return;
        }

        const file = files[importIndex];
        console.log(`📄 Importing: ${file.filename}`);

        let json;
        try {
            json = JSON.parse(file.content);
        } catch (e) {
            console.error("❌ Invalid JSON in file:", file.filename, e);
            // Skip to the next file
            importIndex++;
            importNextFile();
            return;
        }

        if (typeof RM !== "function") {
            console.error("❌ RM() function is not available. Aborting.");
            isImporting = false; // Stop the process
            return;
        }

        // Start the process of finding a unique name and saving
        findUniqueNameAndSave(json, ""); // Start with an empty suffix
    }

    function findUniqueNameAndSave(json, suffix) {
        const nameToCheck = json.ListName + suffix;
        console.log(`🔍 Checking for list name: "${nameToCheck}"`);

        RM().Lists.Get(nameToCheck)
            .then(() => {
                // List EXISTS → try the next numeric suffix
                console.log(`⚠️ List "${nameToCheck}" already exists.`);
                const nextSuffix = suffix === "" ? 1 : suffix + 1;
                findUniqueNameAndSave(json, nextSuffix);
            })
            .catch(err => {
                // Check if the error is a 'Not Found' error
                if (err?.responseStatus === 404) {
                    // List does NOT exist, which is great! Let's save it.
                    json.ListName = nameToCheck;
                    console.log(`💾 Saving new list as: "${json.ListName}"`);

                    RM().Lists.Save(json)
                        .then(() => {
                            console.log(`✅ List saved successfully: "${json.ListName}"`);
                            
                            // --- THIS IS THE FIX ---
                            // Instead of relying on a fragile 'ImportDone' hook,
                            // we now control the flow directly.
                            
                            // 1. Report progress
                            window.postMessage({
                                type: "IMPORT_PROGRESS",
                                current: importIndex + 1,
                                total: window.__importFilesQueue.length,
                                listName: json.ListName
                            }, "*");

                            // 2. Move to the next file
                            importIndex++;
                            importNextFile();
                        })
                        .catch(saveErr => {
                            console.error(`❌ Failed to save list "${json.ListName}":`, saveErr);
                            saveErr?.Show?.();
                            // Skip to the next file on save error
                            importIndex++;
                            importNextFile();
                        });

                } else {
                    // A different, unexpected error occurred during Get
                    console.error("❌ Unexpected error while checking for list:", err);
                    err?.Show?.();
                    // Skip to the next file on unexpected error
                    importIndex++;
                    importNextFile();
                }
            });
    }
})();
