function deleteItemByName(fullname) {
    const items = [...document.querySelectorAll(".Item")];
    const item = items.find(i => i.fullname === fullname);
    if (!item) return false;

    // open gear menu
    item.querySelector("div").click();

    // click Delete
    const deleteRow = [...document.querySelectorAll(".divOperations tr")]
        .find(tr => tr.innerText.trim() === "Delete");

    if (!deleteRow) return false;

    deleteRow.click();
    return true;
}


function deleteAllItems() {
    const names = [...document.querySelectorAll(".Item")]
        .map(el => el.fullname)
        .filter(Boolean);

    let i = 0;

    function next() {
        if (i >= names.length) {
            console.log("✅ All items deleted");
            return;
        }

        const ok = deleteItemByName(names[i++]);

        // give UI time to update
        setTimeout(next, 500);
    }

    next();
}


deleteAllItems();