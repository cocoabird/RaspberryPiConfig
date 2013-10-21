#!/bin/bash

iface=eth0
mac=$(cat /sys/class/net/$iface/address)

case "$mac" in
    "b8:27:eb:7b:c3:91")
        node=01
        ;;
    "b8:27:eb:54:9c:64")
        node=02
        ;;
    *)
        node=250
esac

echo $node
