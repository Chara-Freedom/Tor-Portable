#!/usr/bin/env bash
cd "$(dirname "$0")"
UPD=(VERSION*)
curl "https://k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4.ipns.dweb.link/$UPD" -f -s -o /dev/null
if [[ $? = 22 && ! -f "./AUTO.no" ]]; then
read -n 1 -p "The local version does not match the latest version. It means that update is available, but in edge cases marks accessibility issues. Press any key if you want to update or 0 to skip " INP
echo
 if [ $INP != 0 ]; then
 ./updater.sh
 fi
 if [ $INP = 0 ]; then
 touch "./AUTO.no"
 fi
fi
cd tor
./ipns-republisher.sh &
./ld-linux-x86-64.so.2 --library-path . ./tor -f ../torrc.txt
