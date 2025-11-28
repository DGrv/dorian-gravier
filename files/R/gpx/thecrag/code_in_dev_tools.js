// Grab all network requests in the current session
performance.getEntriesByType("resource")
  .filter(r => r.name.includes("heir")) // change this to match your filter
  .forEach((r, i) => {
      fetch(r.name)
        .then(resp => resp.text())
        .then(text => {
            // Save each file (will prompt download)
            const blob = new Blob([text], {type: "text/plain"});
            const a = document.createElement("a");
            a.href = URL.createObjectURL(blob);
            a.download = `resp_${i}.json`; // change extension if needed
            a.click();
        });
  });