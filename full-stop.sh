#!/usr/bin/env bash
cd "$(dirname "$0")"
lsof -t ./tor/ld-linux-x86-64.so.2 | xargs -r kill
systemctl --user disable tor.service --now
rm ~/.config/systemd/user/tor.service
read -p ""
