#!/bin/bash

node=$1
dev=wlan0
ssid=rlnc-rasp
bssid=4C:12:DC:B6:AF:B7
freq=2462
addr=10.0.0.1$node/24

echo test module
if lsmod | grep -q ath9k_htc; then
    echo rmmod ath9k_htc
    rmmod ath9k_htc
    sleep 2
fi

echo modprobe ath9k_htc
modprobe ath9k_htc
sleep 5

echo config wifi
ip link set dev $dev down
iw dev $dev set power_save off
iw dev $dev set type ibss
ip link set dev $dev up
iw dev $dev ibss join $ssid $freq $bssid

echo config ip
ip addr add dev $dev $addr

if ip addr show dev $dev | grep -q DOWN; then
    echo set iface up
    sleep 5
    ip link set dev $dev up
fi

echo done
