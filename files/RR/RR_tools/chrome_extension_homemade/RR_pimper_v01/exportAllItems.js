function exportItemByName(fullname) {
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
exportAllItems();
