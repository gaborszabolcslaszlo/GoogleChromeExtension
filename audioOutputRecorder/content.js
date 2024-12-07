let currentVideoTitle = 'output'; // Alapértelmezett fájlnév, ha nincs cím.

document.addEventListener('play', function (event) {

    try {
        if (event.target.tagName === 'VIDEO') {
            // Videó címének kinyerése (amennyiben elérhető).
            console.log("Start recording.")
            const video = event.target;
            currentVideoTitle = event.currentTarget.title || 'output'; // Videó neve (vagy az oldal címe).

            // Indítja a felvételt a videó címével.
            chrome.runtime.sendMessage({ type: 'start_ffmpeg', title: currentVideoTitle });
        }
    } catch (error) {
        console.error('Error in background script:', error);
    }
}, true);

document.addEventListener('pause', function (event) {
    try {
        if (event.target.tagName === 'VIDEO') {
            // Megállítja a felvételt.
            chrome.runtime.sendMessage({ type: 'pause_ffmpeg' });
        }
    } catch (error) {
        console.error('Error in background script:', error);
    }
}, true);

document.addEventListener('ended', function (event) {
    try {
        if (event.target.tagName === 'VIDEO') {
            // Videó vége, megállítja a felvételt.
            chrome.runtime.sendMessage({ type: 'stop_ffmpeg' });
        }
    } catch (error) {
        console.error('Error in background script:', error);
    }
}, true);
