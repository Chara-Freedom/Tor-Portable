#!/usr/bin/env bash
cd "$(dirname "$0")"
lsof -t ./tor/ld-linux-x86-64.so.2 | xargs -r kill
systemctl --user disable tor.service --now
rm ~/.config/systemd/user/tor.service
echo "Welcome to the mode control panel."
echo
echo "Do you want to set the mode to random-exit (0, default), set the mode to exit-1 (1), set the mode to exit-2 (2), set the mode to custom (3), or remove middle nodes (4, applies to any other mode)?"
read -n 1 -p "" INP
if [[ $INP = 0 ]]; then
echo
cp ./change-mode/random-exit/torrc.txt torrc.txt
read -p "The mode was changed to random-exit."
fi
if [[ $INP = 1 ]]; then
echo
cp ./change-mode/exit-1/torrc.txt torrc.txt
read -p "The mode was changed to exit-1."
fi
if [[ $INP = 2 ]]; then
echo
cp ./change-mode/exit-2/torrc.txt torrc.txt
read -p "The mode was changed to exit-2."
fi
if [[ $INP = 3 ]]; then
echo
cp ./change-mode/custom/torrc.txt torrc.txt
touch ./change-mode/custom/trace
read -p "The mode was changed to custom."
fi
if [[ $INP = 4 ]]; then
echo
 if grep -q "#MiddleNodes" torrc.txt; then
 read -p "Middle nodes are already not in use."
 exit
 fi
sed -i 's/MiddleNodes/#MiddleNodes/' torrc.txt
read -p "Middle nodes were removed."
fi
