#!/bin/bash

dev=wlan0
file=node_macs

while read line
do
    mac=$(echo $line | cut -f2 -d' ')
    num=$(echo $line | cut -f3 -d' ')

    if [ "$mac" == "none" ]; then
        echo skip $num
        continue
    fi

    ip=10.0.0.1$num
    action=add

    if ip neigh | grep -q "$ip dev $dev"; then
        action=replace
    fi

    echo "$action neigh $ip => $mac"
    ip neighbor $action $ip lladdr $mac dev $dev nud permanent
done <<<"$(cat $file)"
