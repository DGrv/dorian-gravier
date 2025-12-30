chrome.commands.onCommand.addListener((command) => {
  chrome.tabs.query({active: true, currentWindow: true}, (tabs) => {
    const tabId = tabs[0]?.id;
    if (!tabId) return;

    console.log("Command received:", command); // debug

    if (command === "trigger-click") {
      chrome.tabs.sendMessage(tabId, { action: "clickDiv" });
    }



  });
});
