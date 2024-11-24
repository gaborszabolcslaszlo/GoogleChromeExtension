# nCore Chrome Extension

This is a **nCore** browser extension that allows you to quickly access the **nCore** site and perform various tasks directly from your browser.

The extension supports the following features:
- **Open a new window** to load the nCore website.
- **Automatic search** on the nCore site with a specified query.
- **Translation using ChatGPT**, where you can choose the target language from a dropdown.

## Features

- **Quick access to nCore** by opening the website in a new tab.
- **Search on nCore** with the entered search query.
- **Translation** using ChatGPT, with the option to select the target language.

## Installation

1. **Download the extension:**
   - Clone or download the extension folder with the following commands:

     ```bash
     git clone https://github.com/username/ncore-chrome-extension.git
     ```

2. **Install the extension in Chrome:**
   - Open the Chrome browser and navigate to `chrome://extensions/`.
   - Enable **Developer mode**.
   - Click on **Load unpacked**, and select the downloaded or cloned folder.

3. **Using the extension:**
   - After the extension is installed, an **icon** will appear in your browser toolbar.
   - Click the icon to open the extension popup.
   - In the popup, you can enter a query to search nCore, or select a language for translation with ChatGPT.

## Usage

1. **Start a search on nCore:**
   - In the popup, enter your search query and click the "Search" button.
   - This will open a new tab on the nCore website with the search results.

## Development

If you'd like to make changes to the extension, follow these steps:

1. Download the project from GitHub or clone the repository.
2. Open the project in your preferred code editor.
3. Modify the files as needed:
   - **manifest.json**: Extension settings.
   - **background.js**: Background logic.
   - **popup.html** and **popup.js**: Popup interface and interactions.
   - **content.js**: Interactions with the nCore website.

4. After making modifications, you can refresh the extension in `chrome://extensions/` to see the changes.

## License

This extension is licensed under the [MIT License](https://opensource.org/licenses/MIT).
