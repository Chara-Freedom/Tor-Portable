#!/usr/bin/env bash
cd "$(dirname "$0")"
curl "https://ipfs.filebase.io/ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4/test.txt" -f -s -o /dev/null
if [ $? -eq 22 ]; then
read -p "I need ipfs connectivity to update. Please check your Internet connection. "
exit
fi
if [[ $(ls -d */ | wc -l) -gt 7 || $(find . -maxdepth 1 -type f | wc -l) -gt 9 ]]; then
read -n 1 -p "There are too many files to update. You don't want to run the updater in a folder with your personal files. Press any key if you want to exit or 0 if you want to update anyway. " INP
echo
 if [ $INP != 0 ]; then
 exit
 fi
fi
lsof -t ./tor/ld-linux-x86-64.so.2 | xargs -r kill
systemctl --user disable tor.service --now
rm ~/.config/systemd/user/tor.service
cp ./torrc.txt ./data/torrc.txt
cp -r ./data ~/data
if grep -q "The mode is custom" ./torrc.txt; then
cp ./torrc.txt ./change-mode/custom/torrc.txt
mkdir ~/change-mode
cp -r ./change-mode/custom ~/change-mode/custom
fi
if ! grep -q "The mode is custom" ./torrc.txt; then
 if [ -f ./change-mode/custom/trace ]; then
 cp ./change-mode/custom/torrc.txt ~/torrc.txt
 cp ./change-mode/custom/trace ~/trace
 fi
fi
rm -r *
curl "https://k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4.ipns.dweb.link/AntiTor_linux_current.zip" -O
unzip ./AntiTor_linux_current.zip
rm ./AntiTor_linux_current.zip
cp -r ~/data ./
rm -r ~/data
if grep -q "The mode is exit-1" ./data/torrc.txt; then
cp ./change-mode/exit-1/torrc.txt torrc.txt
fi
if grep -q "The mode is exit-2" ./data/torrc.txt; then
cp ./change-mode/exit-2/torrc.txt torrc.txt
fi
if grep -q "#MiddleNodes" ./data/torrc.txt; then
sed -i 's/MiddleNodes/#MiddleNodes/' torrc.txt
fi
rm ./data/torrc.txt
if grep -q "The mode is custom" ~/change-mode/custom/torrc.txt; then
cp -r ~/change-mode/custom ./change-mode
rm -r ~/change-mode
cp ./change-mode/custom/torrc.txt torrc.txt
fi
if [ -f ~/torrc.txt ]; then
cp ~/torrc.txt ./change-mode/custom/torrc.txt
rm ~/torrc.txt
cp ~/trace ./change-mode/custom/trace
rm ~/trace
fi
