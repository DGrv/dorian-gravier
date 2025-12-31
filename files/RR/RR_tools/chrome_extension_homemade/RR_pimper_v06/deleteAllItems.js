(function () {

    // 1️⃣ Find the SectionHeader div containing "Lists"
    const sectionHeader = [...document.querySelectorAll(".SectionHeader")]
        .find(div => div.innerText.trim() === "Lists");
    if (!sectionHeader) {
        console.warn("SectionHeader 'Lists' not found");
    } else {
        // 2️⃣ Get all .Item elements inside the same container
        const container = sectionHeader.nextElementSibling; // usually the list follows the header
        const items = [...container.querySelectorAll(".Item")];
        
        const totalItems = items.length;
        let currentIndex = 0;
        let finished = false;

        // Override window.confirm so deletion is auto-confirmed
        const oldConfirm = window.confirm;
        window.confirm = () => true;
        function deleteNextItem() {
            if (currentIndex >= totalItems) {
                if (!finished) {
                    finished = true;
                    setTimeout(() => {
                        window.postMessage({ type: "DELETE_ALL_FINISHED" }, "*");
                        window.confirm = oldConfirm;
                    }, 200);
                }
                return;
            }

            const item = items[currentIndex];
            if (!item) {
                currentIndex++;
                setTimeout(deleteNextItem, 400);
                return;
            }

            // ✅ Open gear menu first
            const menuDiv = item.querySelector("div");
            if (menuDiv) menuDiv.click();

            // Then find the Delete row
            const deleteRow = [...document.querySelectorAll(".divOperations tr")]
                .find(tr => tr.innerText.includes("Delete"));

            if (deleteRow) {
                deleteRow.click();
            } else {
                console.warn("DELETE_ALL: Delete row not found for item", item.fullname || item.innerText);
            }

            window.postMessage({
                type: "DELETE_PROGRESS",
                current: currentIndex + 1,
                total: totalItems
            }, "*");

            currentIndex++;
            setTimeout(deleteNextItem, 600);
        }
    }


    deleteNextItem();

})();
