function exportItemByNameold(fullname) {
    const items = [...document.querySelectorAll(".Item")];
    const item = items.find(i => i.fullname === fullname);
    if (!item) return;

    // open gear menu
    item.querySelector("div").click();

    // click export
    [...document.querySelectorAll(".divOperations tr")]
        .find(tr => tr.innerText.includes("Export"))
        ?.click();
}

function exportAllItems() {
    const items = [...document.querySelectorAll(".Item")]
        .map(el => el.fullname)
        .filter(Boolean);

    let i = 0;
    function next() {
        if (i >= items.length) return;
        exportItemByName(items[i++]);
        setTimeout(next, 500);
    }
    next();
}

// immediately run
// exportAllItems();


function exportItemByName(fullname) {
    const items = [...document.querySelectorAll(".Item")];
    const item = items.find(i => i.fullname === fullname);
    if (!item) return null;

    // Optional: still open gear menu if needed
    // item.querySelector("div").click();

    // Do NOT click export — we will capture content in JS
    return {
        fullname: item.fullname,
        content: item.innerText // or any data you want in ZIP
    };
}

function exportAllItemsForZip() {
    const items = [...document.querySelectorAll(".Item")]
        .map(el => el.fullname)
        .filter(Boolean);

    const exportedData = [];
    let i = 0;

    function next() {
        if (i >= items.length) {
            // send exported data to content script
            window.postMessage({ type: "EXPORT_ALL_ZIP", data: exportedData }, "*");
            return;
        }

        const data = exportItemByName(items[i++]);
        if (data) exportedData.push(data);
        setTimeout(next, 100); // shorter delay, no real click
    }

    next();
}

// Run immediately
exportAllItemsForZip();
