// out.innerTextlet exportDone = false;

/**
 * Sends a message to the content script to display a status message on the page.
 * @param {string} text The text to display in the notification panel.
 */
function showPageStatus(text) {
    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
        const activeTab = tabs[0];
        if (activeTab) {
            chrome.tabs.sendMessage(activeTab.id, {
                type: "SHOW_STATUS", // A single, generic message type
                message: text
            });
        }
    });
}


/**
 * Sends a message to the content script to click the "Lists" section header.
 */
function clickSectionHeader() {
    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
        if (tabs[0]) {
            chrome.tabs.sendMessage(tabs[0].id, {
                action: "CLICK_SECTION_HEADER"
            });
        }
    });
}



document.addEventListener("DOMContentLoaded", () => {
    const exportBtn = document.getElementById("export");
    const deleteBtn = document.getElementById("delete");

    const importBtn = document.getElementById("import");
    // Disable the import button initially
    importBtn.disabled = true;

    const fileInput = document.getElementById("importFiles");
    const fileChosenText = document.getElementById("file-chosen-text");

    fileInput.addEventListener('change', function () {
        const files = this.files;
        if (files.length > 1) {
            fileChosenText.textContent = `${files.length} files selected`;
        } else if (files.length === 1) {
            fileChosenText.textContent = files[0].name;
        } else {
            fileChosenText.textContent = 'No files chosen';
        }

        // Enable the button only if files are selected
        importBtn.disabled = (files.length === 0);
    });

    importBtn.onclick = () => {
        console.log("▶ IMPORT_ALL clicked");
        const filesInput = document.getElementById("importFiles");
        if (!filesInput.files.length) {
            showPageStatus("❌ No files selected!");
            console.warn("No files selected for import");
            return;
        }

        importBtn.disabled = true;
        showPageStatus(`⏳ Importing ${filesInput.files.length} files...`);

        // Call the click function inside the timeout
        clickSectionHeader();

        const fileList = Array.from(filesInput.files);
        const filesData = [];
        let filesRead = 0;

        chrome.tabs.query({ active: true, currentWindow: true }, tabs => {
            fileList.forEach(file => {
                const reader = new FileReader();

                reader.onload = e => {
                    filesData.push({
                        filename: file.name,
                        content: e.target.result
                    });
                    filesRead++;
                    if (filesRead === fileList.length) {
                        // All files are read, send them in a single message
                        chrome.tabs.sendMessage(
                            tabs[0].id,
                            { action: "IMPORT_FILES_BATCH", files: filesData },
                            response => {
                                console.log('IMPORT_FILES_BATCH response:', response);
                            }
                        );
                    }
                };

                reader.onerror = err => {
                    console.error(`❌ Error reading file ${file.name}:`, err);
                    showPageStatus(`❌ Error reading file ${file.name}`);
                };

                reader.readAsText(file);
            });
        });
    };

    exportBtn.onclick = () => {
        clickSectionHeader();

        setTimeout(() => {
            // Disable button and show loading
            exportBtn.disabled = true;
            showPageStatus("⏳ Export starting, wait !");

            chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
                chrome.tabs.sendMessage(tabs[0].id, { action: "EXPORT_ALL" });
            });
        }, 2000); // Delay of 5 seconds before disabling the button
    };

    deleteBtn.onclick = () => {
        // Call the click function first
        clickSectionHeader();
        showPageStatus("\u23F3  I need your permission to delete all files ...");

        setTimeout(() => {
            showWarningConfirmation(
                "Have you exported all items before deleting?",
                () => showModal2()
            );
        }, 2000);
    };






    // Helper function to show warning confirmation with custom message
    function showWarningConfirmation(customMessage, onConfirm) {
        const modal = document.getElementById("confirmWarningConfirmation");
        const messageElement = modal.querySelector('p');

        // Update the message
        messageElement.textContent = customMessage;

        modal.style.display = "flex";

        document.getElementById("confirmModal1Yes").onclick = () => {
            modal.style.display = "none";
            if (onConfirm) onConfirm(); // Execute callback
        };

        document.getElementById("confirmModal1No").onclick = () => {
            modal.style.display = "none";
            // User cancelled, do nothing
        };
    }


    // Helper function to show Modal 2 (with text input)
    function showModal2() {
        const modal2 = document.getElementById("confirmModal2");
        const input = document.getElementById("deleteConfirmInput");
        modal2.style.display = "flex";
        input.value = ""; // Clear previous input
        input.focus(); // Auto-focus the input

        document.getElementById("confirmModal2Yes").onclick = () => {
            if (input.value.toLowerCase() === "delete") {
                modal2.style.display = "none";

                // User confirmed, proceed with deletion
                deleteBtn.disabled = true;
                showPageStatus("⏳ Delete all started...");

                chrome.tabs.query({ active: true, currentWindow: true }, tabs => {
                    chrome.tabs.sendMessage(tabs[0].id, { action: "DELETE_ALL" }, response => {
                        console.log("Delete_ALL message sent", response);
                    });
                });
            } else {
                // Shake the input or show error
                input.style.borderColor = "#c41011";
                input.placeholder = "You must type 'delete'";
                setTimeout(() => {
                    input.style.borderColor = "#ddd";
                }, 1000);
            }
        };

        document.getElementById("confirmModal2No").onclick = () => {
            modal2.style.display = "none";
            // User cancelled, do nothing
        };

        // Allow Enter key to submit
        input.onkeypress = (e) => {
            if (e.key === "Enter") {
                document.getElementById("confirmModal2Yes").click();
            }
        };
    }


    const getEntryFeesBtn = document.getElementById("getentryfees");

    getEntryFeesBtn.onclick = () => {
        showWarningConfirmation(
            "Get Entry Fees can take a long time. Continue?",
            () => {
                getEntryFeesBtn.disabled = true;
                showPageStatus("⏳ Starting entry fees analysis...");

                chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
                    chrome.tabs.sendMessage(tabs[0].id, { action: "GET_ENTRY_FEES" }, (response) => {
                        console.log('GET_ENTRY_FEES response:', response);
                    });
                });
            }
        );
    };

    const getDevicesLinksCheckbox = document.getElementById("getdeviceslinks");



    // Restore checkbox state when popup opens
    chrome.runtime.sendMessage({ action: "GET_MONITORING_STATE" }, (response) => {
        if (response && response.active) {
            getDevicesLinksCheckbox.checked = true;
        }
    });

    getDevicesLinksCheckbox.onchange = (e) => {
        const isChecked = e.target.checked;

        chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
            const tabId = tabs[0].id;

            if (isChecked) {
                chrome.runtime.sendMessage({ action: "START_MONITORING", tabId: tabId });
                chrome.tabs.sendMessage(tabId, { action: "START_DEVICE_MONITORING" });
                showPageStatus("✅ Device monitoring active");
            } else {
                chrome.runtime.sendMessage({ action: "STOP_MONITORING", tabId: tabId });
                chrome.tabs.sendMessage(tabId, { action: "STOP_DEVICE_MONITORING" });
                showPageStatus("✅ Device monitoring stopped");
            }
        });
    };



    // Listen for completion message to re-enable button
    chrome.runtime.onMessage.addListener((msg, sender, sendResponse) => {
        if (msg.type === "DEVICES_LINKS_COMPLETE") {
            if (getDevicesLinksBtn) {
                getDevicesLinksBtn.disabled = false;
            }
        }
        if (msg.type === "EXPORT_PROCESS_COMPLETE") {
            if (exportBtn) {
                exportBtn.disabled = false;
            }
        }

        // NEW: Re-enable entry fees button when complete
        if (msg.type === "ENTRY_FEES_COMPLETE") {
            if (getEntryFeesBtn) {
                getEntryFeesBtn.disabled = false;
            }
        }
    });







});
