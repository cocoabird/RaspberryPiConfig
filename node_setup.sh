#!/bin/bash

node=$1
eth_iface=eth0
wifi_iface=wlan0
eth_addr=10.0.2.$node/24
wifi_addr=10.0.3.$node/24

./node_ether.sh $node

if [ -d /sys/class/net/$wifi_iface ]; then
    ./node_wifi.sh $node
fi
