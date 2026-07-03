#!/usr/bin/env bash
cd "$(dirname "$0")"
if ! command -v curl >/dev/null 2>&1 || ! command -v unzip >/dev/null 2>&1 || ! command -v lsof >/dev/null 2>&1; then
 if ! command -v curl >/dev/null 2>&1; then
 echo "Error: curl is not installed."
 echo
 fi
 if ! command -v unzip >/dev/null 2>&1; then
 echo "Error: unzip is not installed."
 echo
 fi
 if ! command -v lsof >/dev/null 2>&1; then
 echo "Error: lsof is not installed."
 echo
 fi
read -n 1 -p ""
exit
fi
lsof -t "./tor/ld-linux-x86-64.so.2" | xargs -r kill
systemctl --user disable tor.service --now
rm ~/.config/systemd/user/tor.service
read -p ""