#!/usr/bin/env bash
cd "$(dirname "$0")"
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs init
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs daemon &
sleep 20
while pgrep -x ld-linux-x86-64 > /dev/null
do
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs name get /ipns/k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4 > record.bin
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs name put k51qzi5uqu5dldod6robuflgitvj276br0xye3adipm3kc0bh17hfiv1e0hnp4 record.bin --force
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs name get /ipns/k51qzi5uqu5dhr0t6o7hfymktwipat1243r24wqzfrbhery1z4f85alzgq12pt > record.bin
./ld-linux-x86-64.so.2 --library-path . ../kubo/ipfs name put k51qzi5uqu5dhr0t6o7hfymktwipat1243r24wqzfrbhery1z4f85alzgq12pt record.bin --force
sleep 1d
done
