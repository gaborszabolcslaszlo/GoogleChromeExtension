 
chrome.runtime.onInstalled.addListener(() => {
  chrome.contextMenus.create({
    id: "searchOnNCore",
    title: "Keresés az NCore-on",
    contexts: ["selection"] // Csak akkor jelenik meg, ha szöveget jelölnek ki
  });
});

chrome.contextMenus.onClicked.addListener((info, tab) => {
  if (info.menuItemId === "searchOnNCore") {
    let query = info.selectionText; // A kijelölt szöveg a keresési kifejezés
    let ncoreUrl = `https://ncore.pro/torrents.php?mire=${encodeURIComponent(query)}`; // NCore keresési URL
    chrome.windows.create({ url: ncoreUrl, type: "popup" }); // Új ablak nyitása
  }
});
