let recordingTitle = 'output'; // Alapértelmezett fájlnév.

chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
    if (message.type === "start_ffmpeg") {
        console.log("Started:");
        recordingTitle = message.title.replace(/\s+/g, '_').toLowerCase(); // Fájlnév előkészítése.
        //chrome.runtime.connectNative('com.my_ffmpeg_app')
        //  .postMessage({ action: 'start', title: recordingTitle });


        chrome.runtime.connectNative('com.my_ffmpeg_app').postMessage({ action: 'start', title: recordingTitle });

        console.log("FFmpeg started:");
    } else if (message.type === "stop_ffmpeg") {
        chrome.runtime.connectNative('com.my_ffmpeg_app').postMessage({ action: 'stop', title: recordingTitle });
        console.log("FFmpeg stopped:");
    } else if (message.type === "pause_ffmpeg") {
        chrome.runtime.connectNative('com.my_ffmpeg_app').postMessage({ action: 'pause', title: recordingTitle });
        console.log("FFmpeg pause:");
    }
});

