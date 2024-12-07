#!/bin/bash

# A JSON fájl elérési útja (ahol a fájl jelenleg van)
JSON_FILE_PATH="com.my_ffmpeg_app.json"

# Ellenőrizzük, hogy létezik-e a fájl
if [ ! -f "$JSON_FILE_PATH" ]; then
  echo "Hiba: A JSON fájl nem található: $JSON_FILE_PATH"
  exit 1
fi

# Célmappa felhasználószintű telepítéshez
CHROME_USER_DIR="$HOME/.config/google-chrome/NativeMessagingHosts"
CHROMIUM_USER_DIR="$HOME/.config/chromium/NativeMessagingHosts"

# Célmappa rendszerszintű telepítéshez
CHROME_SYSTEM_DIR="/etc/opt/chrome/native-messaging-hosts"
CHROMIUM_SYSTEM_DIR="/etc/chromium/native-messaging-hosts"

# Kérdezzük meg a felhasználót, hogy felhasználói vagy rendszerszintű telepítést szeretne
echo "Hova szeretnéd másolni a JSON fájlt?"
echo "1) Felhasználói telepítés (csak a jelenlegi felhasználónak)"
echo "2) Rendszerszintű telepítés (minden felhasználó számára, rendszergazdai jogok szükségesek)"
read -p "Válassz opciót (1 vagy 2): " INSTALL_TYPE

if [ "$INSTALL_TYPE" == "1" ]; then
  # Felhasználói telepítés
  if [ -d "$CHROME_USER_DIR" ]; then
    TARGET_DIR="$CHROME_USER_DIR"
  elif [ -d "$CHROMIUM_USER_DIR" ]; then
    TARGET_DIR="$CHROMIUM_USER_DIR"
  else
    echo "Hiba: A felhasználói Chrome vagy Chromium mappa nem található."
    exit 1
  fi

  # A célkönyvtár létrehozása, ha nem létezik
  mkdir -p "$TARGET_DIR"
  cp "$JSON_FILE_PATH" "$TARGET_DIR/"

  echo "A JSON fájl sikeresen bemásolva ide: $TARGET_DIR"

elif [ "$INSTALL_TYPE" == "2" ]; then
  # Rendszerszintű telepítés (sudo szükséges)
  if [ -d "$CHROME_SYSTEM_DIR" ]; then
    TARGET_DIR="$CHROME_SYSTEM_DIR"
  elif [ -d "$CHROMIUM_SYSTEM_DIR" ]; then
    TARGET_DIR="$CHROMIUM_SYSTEM_DIR"
  else
    echo "Hiba: A rendszerszintű Chrome vagy Chromium mappa nem található."
    exit 1
  fi

  # A célkönyvtár létrehozása rendszergazdaként, ha nem létezik
  sudo mkdir -p "$TARGET_DIR"
  sudo cp "$JSON_FILE_PATH" "$TARGET_DIR/"

  echo "A JSON fájl sikeresen bemásolva ide: $TARGET_DIR"
else
  echo "Hiba: Érvénytelen választás."
  exit 1
fi
