#!/bin/bash

debug_mode=false

while (( "$#" )); do
  case "$1" in
    -d|--debug)
      debug_mode=true
      shift
      ;;
    *)
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

if $debug_mode; then
  echo "Debug mode is on."
  output="/dev/stdout"
else
  output="/dev/null"
fi

if [ "$(id -u)" != "0" ]; then
    echo "This script requires root acces. Try: sudo discordo"
    exit 1
fi

if ! command -v dpkg &> $output; then
    echo "This OS is not debian based."
    exit 1
fi
echo "Downloading newest version of Discord..."
wget -O /tmp/discord.deb "https://discord.com/api/download?platform=linux&format=deb" &> /dev/null
if [ $? -ne 0 ]; then
    echo "Download error."
    exit 1
fi
echo "Installing latest version of Discord..."
dpkg -i /tmp/discord.deb &> $output
clear
echo "Done! You now have latest Discord version!"
rm -f /tmp/discord.deb &> $output
exit 0
