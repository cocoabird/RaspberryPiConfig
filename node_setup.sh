#!/bin/bash

eth_iface=eth0
node=$(./node_selector.sh $eth_iface)
wifi_iface=wlan0
eth_addr=10.0.1.1$node/24
wifi_addr=10.0.0.1$node/24

echo setup ethernet
bash node_ether.sh $node

echo "rasp$node" > /etc/hostname
hostname rasp$node
#sed -E "s/(127\.0\.0\.1\s+localhost)( rasp$node)?/\1 rasp$node/g" /etc/hosts

if [ -d /sys/class/net/$wifi_iface ]; then
    echo setup wifi
    ./node_wifi.sh $node
fi

./node_neigh.sh
