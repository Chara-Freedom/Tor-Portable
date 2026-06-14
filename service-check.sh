#!/usr/bin/env bash
systemctl --user status tor.service -l --no-pager -n10000
read -n 1 -p ""
