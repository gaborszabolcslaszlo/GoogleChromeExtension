let playPauseButton = document.getElementById('play-pause-button').addEventListener('click', function () {
    console.log("start button clicked.")
    chrome.runtime.sendMessage({ type: 'start_ffmpeg' });
});

