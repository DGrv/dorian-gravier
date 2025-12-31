(function () {

    const exportedFiles = [];
    let zipSent = false; // 🔒 guard

    const originalAnchorClick = HTMLAnchorElement.prototype.click;
    HTMLAnchorElement.prototype.click = function () {
        if (this.download && this.href?.startsWith("blob:")) {
            return;
        }
        return originalAnchorClick.call(this);
    };

    const originalCreateObjectURL = URL.createObjectURL;
    URL.createObjectURL = function (blob) {
        const url = originalCreateObjectURL.call(this, blob);

        setTimeout(() => {
            const a = document.querySelector(`a[href="${url}"][download]`);
            if (a) {
                exportedFiles.push({
                    filename: a.download,
                    blob
                });
            }
        }, 0);

        return url;
    };

    function exportItemByName(fullname) {
        const items = [...document.querySelectorAll(".Item")];
        const item = items.find(i => i.fullname === fullname);
        if (!item) return;

        item.querySelector("div").click();

        [...document.querySelectorAll(".divOperations tr")]
            .find(tr => tr.innerText.includes("Export"))
            ?.click();
    }

    function exportAllItemsForZip() {
        const names = [...document.querySelectorAll(".Item")]
            .map(el => el.fullname)
            .filter(Boolean);

        let i = 0;

        function next() {
            if (i >= names.length) {
                if (zipSent) return; // 🔒 stop duplicates
                zipSent = true;

                setTimeout(() => {
                    window.postMessage({
                        type: "EXPORT_ALL_ZIP",
                        files: exportedFiles
                    }, "*");
                }, 1000);

                return;
            }

            exportItemByName(names[i++]);
            setTimeout(next, 600);
        }

        next();
    }

    exportAllItemsForZip();

})();
