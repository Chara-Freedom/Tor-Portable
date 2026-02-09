#!/usr/bin/env bash
cd "$(dirname "$0")"
lsof -t ./tor/ld-linux-x86-64.so.2 | xargs -r kill
systemctl --user disable tor.service --now
rm ~/.config/systemd/user/tor.service
echo "Welcome to the mode control panel."
echo
read -n 1 -p "Do you want to set the mode to random-exit (0, default), set the mode to exit-1 (1), set the mode to exit-2 (2), set the mode to custom (3), or remove middle nodes (4, applies to any other mode)? " INP
echo
while [[ -n $INP ]]; do
case $INP in
0)
cp ./change-mode/random-exit/torrc.txt torrc.txt
read -n 1 -p "The mode was changed to random-exit. " INP
echo;;
1)
cp ./change-mode/exit-1/torrc.txt torrc.txt
read -n 1 -p "The mode was changed to exit-1. " INP
echo;;
2)
cp ./change-mode/exit-2/torrc.txt torrc.txt
read -n 1 -p "The mode was changed to exit-2. " INP
echo;;
3)
cp ./change-mode/custom/torrc.txt torrc.txt
touch ./change-mode/custom/trace
read -n 1 -p "The mode was changed to custom. " INP
echo;;
4)
if grep -q "#MiddleNodes" torrc.txt; then
read -n 1 -p "Middle nodes are already not in use. " INP
echo
fi
if ! grep -q "#MiddleNodes" torrc.txt; then
sed -i 's/MiddleNodes/#MiddleNodes/' torrc.txt
read -n 1 -p "Middle nodes were removed. " INP
echo
fi;;
*)
exec "$0"
exit;;
esac
done
