function clickDiv() {
  const div = document.querySelector("#divDockRight");
  if (div) {
    div.click();
    console.log("✅ divDockRight clicked!");
  } else {
    console.log("❌ divDockRight not found.");
  }
}

chrome.runtime.onMessage.addListener((msg) => {
  if (msg.action === "clickDiv") clickDiv();
});
