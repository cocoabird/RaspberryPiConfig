#!/bin/bash

iface=$1
key=$(cat /sys/class/net/$iface/address)
file=node_macs
default=250

cat $file | while read line
do
    mac=$(echo $line | cut -f1 -d' ')
    num=$(echo $line | cut -f2 -d' ')
    if [ "$mac" = "$key" ]; then
        echo $num
        exit 0
    fi
done

echo $default
