#!/bin/bash

LOG_FILE = "/tmp/ffmpeg_script.log"

#echo "Script started" >> /tmp/ffmpeg_script.log
#echo "Parameters : $@" >> /tmp/ffmpeg_script.log
# Paraméterek
OUTPUT_FILE="output.mp3"

ACTION=""
TITLE=""

# Funkciók

# Elindítja az FFmpeg-et
start_recording() {
  if [ -f "$PID_FILE" ]; then
    resume_recording
  else
    echo "Starting..." >> /tmp/ffmpeg_script.log
    #ffmpeg -f pulse -i default -ac 2 -ar 44100 $OUTPUT_FILE &  # A felvétel a háttérben fut
    ffmpeg -y -f pulse -i alsa_output.usb-GN_Netcom_A_S_Jabra_EVOLVE_20_SE_MS_A002DE4818620A-00.analog-stereo.monitor -ac 2 -ar 48000 "/home/laca/Music/${TITLE}.flac" &
    echo $! > $PID_FILE  # Elmenti a PID-t a folyamat azonosítójával
    echo "Start recording, PID: $(cat $PID_FILE)"
  fi 
}

# Leállítja az FFmpeg-et
stop_recording() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat $PID_FILE)
        echo "Stoping (PID: $PID)..." >> /tmp/ffmpeg_script.log
        kill -SIGTERM $PID  # Megöli a folyamatot
        rm -f $PID_FILE  # Törli a PID fájlt
        echo "Stop recording."
    else
        echo "ffmpg pid is missing!"
    fi
}

# Szünetelteti az FFmpeg-et
pause_recording() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat $PID_FILE)
        echo "Pausing (PID: $PID)..." >> /tmp/ffmpeg_script.log
        kill -SIGSTOP $PID  # Szünetelteti a folyamatot
        echo "Pause recording"
    else
        echo "ffmpg pid is missing!"
    fi
}

# Folytatja a szüneteltetett felvételt
resume_recording() {
    if [ -f "$PID_FILE" ]; then
        PID=$(cat $PID_FILE)
        echo "Resumeing (PID: $PID)..." >> /tmp/ffmpeg_script.log
        kill -SIGCONT $PID  # Folytatja a folyamatot
        echo "Felvétel folytatva."
    else
        echo "ffmpg pid is missing!"
    fi
}


while true; do
  echo "loop" 
  read -r message

  
  # Naplózza a kapott üzenetet
  #echo "Received message: $message" >> /tmp/ffmpeg_script.log

  ACTION=$(echo "$message" | grep -oP '"action":\s*"\K[^"]+')
  TITLE=$(echo "$message" | grep -oP '"title":\s*"\K[^"]+')

  echo "Command: $ACTION, Filename: $TITLE" >> /tmp/ffmpeg_script.log


  # A script választható argumentumokat vár: start, stop, pause, resume
case $ACTION in
    start)
        start_recording
        ;;
    stop)
        stop_recording
        ;;
    pause)
        pause_recording
        ;;
    resume)
        resume_recording
        ;;
    *)
        echo "Használat: $0 {start|stop|pause|resume}"
        exit 1
        ;;
esac

done
