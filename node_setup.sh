#!/bin/bash

eth_iface=eth0
node=$(./node_selector.sh $eth_iface)
wifi_iface=wlan0
eth_addr=10.0.1.1$node/24
wifi_addr=10.0.0.1$node/24

bash node_ether.sh $node

#cat /dev/null > /etc/hostname
#echo "rasp"$node > /etc/hostname
#echo "rasp"$node #Is there for debugging

if [ -d /sys/class/net/$wifi_iface ]; then
    ./node_wifi.sh $node
fi

