(function () {
    console.log("🟢 importAllItems.js loaded");

    if (!window.__importFilesQueue) {
        window.__importFilesQueue = [];
    }


    let importing = false;

    window.addEventListener("message", (event) => {
        if (event.source !== window) return;
        if (event.data?.type !== "IMPORT_FILE_DATA") return;

        console.log("📥 IMPORT_FILE_DATA received", event.data.files);

        window.__importFilesQueue.push(...event.data.files);

        if (!importing) {
            importing = true;
            index = 0; // reset only once
            importNext();
        }
    });


    function importNext() {
        const files = window.__importFilesQueue

        console.log("📦 Queue length:", files.length, "index:", index);

        if (index >= files.length) {
            console.log("✅ IMPORT ALL FINISHED");
            importing = false;
            window.postMessage({ type: "IMPORT_ALL_FINISHED" }, "*");
            return;
        }

        console.log('files:' + files)
        const file = files[index];
        console.log('file:' + file)
        console.log("📄 Importing:", file.filename);

        let json;
        try {
            json = JSON.parse(file.content);
        } catch (e) {
            console.error("❌ Invalid JSON", file.filename);
            index++;
            return importNext();
        }

        if (typeof RM !== "function") {
            console.error("❌ RM() not available");
            return;
        }

        // 🔑 Hook ImportDone (CRITICAL)
        const originalImportDone = window.ImportDone;
        window.ImportDone = function (listName) {
            console.log("🎉 ImportDone:", listName);

            window.postMessage({
                type: "IMPORT_PROGRESS",
                current: index + 1,
                total: files.length,
                listName
            }, "*");

            window.ImportDone = originalImportDone;
            index++;
            importNext();
        };

        // ⛳ EXACT same logic as website
        function findNameLists(z) {
            const nameToCheck = json.ListName + z;
            console.log("🔍 Checking list:", nameToCheck);

            RM().Lists.Get(nameToCheck)
                .then(() => {
                    // List EXISTS → try next suffix
                    console.log("⚠️ List exists:", nameToCheck);
                    findNameLists(z ? z + 1 : 1);
                })
                .catch(err => {
                    // ✅ THIS is the important part
                    if (err?.responseStatus === 404) {
                        // List does NOT exist → create it
                        json.ListName = nameToCheck;
                        console.log("💾 Creating list:", json.ListName);

                        RM().Lists.Save(json)
                            .then(() => {
                                console.log("✅ List saved:", json.ListName);
                                // ImportDone will be called internally by RaceResult
                            })
                            .catch(saveErr => {
                                console.error("❌ Save failed:", saveErr);
                                saveErr?.Show?.();
                            });

                    } else {
                        // ❌ real error
                        console.error("❌ Unexpected error:", err);
                        err?.Show?.();
                    }
                });
        }

        findNameLists("");
    }
})();
