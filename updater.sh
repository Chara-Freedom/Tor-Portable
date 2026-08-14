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
curl "https://k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4.ipns.dweb.link/test.txt" -f -s -o /dev/null
if [[ $? = 22 ]]; then
read -n 1 -p "I need ipfs connectivity to update. Please check your Internet connection. "
exit
fi
UPD=(VERSION*)
if [ ! -f $UPD ]; then
mkdir AntiTor
cd AntiTor
fi
lsof -t "./tor/ld-linux-x86-64.so.2" >/dev/null 2>&1 | xargs -r kill
systemctl --user disable tor.service --now
rm ~/.config/systemd/user/tor.service >/dev/null 2>&1
cp "./torrc.txt" "./data/torrc.txt" >/dev/null 2>&1
if [[ -f "./AUTO.no" ]]; then
cp "./AUTO.no" "./data/AUTO.no"
fi
cp -r "./data" ~/data >/dev/null 2>&1
if grep -q "The mode is custom" "./torrc.txt" >/dev/null 2>&1; then
cp "./torrc.txt" "./change-mode/custom/torrc.txt"
mkdir ~/change-mode
cp -r "./change-mode/custom" ~/change-mode/custom
fi
if ! grep -q "The mode is custom" "./torrc.txt" >/dev/null 2>&1; then
 if [[ -f "./change-mode/custom/trace" ]]; then
 cp "./change-mode/custom/torrc.txt" ~/torrc.txt
 cp "./change-mode/custom/trace" ~/trace
 fi
fi
rm -rf *
curl "https://k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4.ipns.dweb.link/AntiTor_linux_current.zip" -O
unzip "./AntiTor_linux_current.zip"
rm "./AntiTor_linux_current.zip"
cp -r ~/data "./" >/dev/null 2>&1
rm -r ~/data >/dev/null 2>&1
if [[ -f "./data/AUTO.no" ]]; then
cp "./data/AUTO.no" "./AUTO.no"
rm "./data/AUTO.no"
fi
if grep -q "The mode is exit-1" "./data/torrc.txt" >/dev/null 2>&1; then
cp "./change-mode/exit-1/torrc.txt" "./torrc.txt"
fi
if grep -q "The mode is exit-2" "./data/torrc.txt" >/dev/null 2>&1; then
cp "./change-mode/exit-2/torrc.txt" "./torrc.txt"
fi
if grep -q "#MiddleNodes" "./data/torrc.txt" >/dev/null 2>&1; then
sed -i 's/MiddleNodes/#MiddleNodes/' "./torrc.txt"
fi
rm "./data/torrc.txt" >/dev/null 2>&1
if grep -q "The mode is custom" ~/change-mode/custom/torrc.txt >/dev/null 2>&1; then
cp -r ~/change-mode/custom "./change-mode"
rm -r ~/change-mode
cp "./change-mode/custom/torrc.txt" "./torrc.txt"
fi
if [[ -f ~/torrc.txt ]]; then
cp ~/torrc.txt "./change-mode/custom/torrc.txt"
rm ~/torrc.txt
cp ~/trace "./change-mode/custom/trace"
rm ~/trace
fi
