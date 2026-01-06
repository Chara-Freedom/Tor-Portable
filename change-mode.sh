#!/usr/bin/env bash
cd "$(dirname "$0")"
lsof -t ./tor/ld-linux-x86-64.so.2 | xargs kill
systemctl --user disable tor.service --now
rm ~/.config/systemd/user/tor.service
read -n 1 -p "Welcome to the mode control panel. Do you want to set the mode to pro (1), set the mode to default (2), or remove middle nodes (3)?" INP
if [[ $INP = 1 ]]; then
cp ./change-mode/pro/torrc.txt torrc.txt
read -p "The mode was changed to pro."
fi
if [[ $INP = 2 ]]; then
cp ./change-mode/default/torrc.txt torrc.txt
read -p "The mode was changed to default."
fi
if [[ $INP = 3 ]]; then
sed -i 's/MiddleNodes/#MiddleNodes/' torrc.txt
read -p "Middle nodes were removed."
fi
