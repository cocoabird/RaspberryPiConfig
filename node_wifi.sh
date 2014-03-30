#!/bin/bash

node=$1
dev=wlan0
ssid=rlnc-default
bssid=4C:12:DC:B6:B0:C8
freq=2462
addr=10.0.0.1$node/24
beacon=300
rates=11

dev=wlan0
file=node_macs

while read line
do
    num=$(echo $line | cut -f3 -d' ')

    if [ "$num" -ne "$node" ]; then
        continue
    fi

    ssid=$(echo $line | cut -f4 -d' ')
    freq=$(echo $line | cut -f5 -d' ')
    bssid=$(echo $ssid $freq | md5sum)
    bssid=$(echo ${bssid:0:12} | sed 's/\([a-f0-9][a-f0-9]\)/\1:/g')
    bssid=${bssid:0:-1}
    echo "match $num == $node"
    break
done <<<"$(cat $file)"

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
echo "ssid:  $ssid"
echo "freq:  $freq"
echo "bssid: $bssid"

ip link set dev $dev down || echo link down
iw dev $dev set power_save off || echo power_save off
iw dev $dev set type ibss || echo type ibss
iw dev $dev set bitrates legacy-2.4 $rates || echo set rates
ip link set dev $dev up || echo link up
#iw dev $dev ibss join $ssid $freq $bssid beacon-interval $beacon basic-rates $rates
iw dev $dev ibss join $ssid $freq

echo config ip
ip addr add dev $dev $addr

if ip addr show dev $dev | grep -q DOWN; then
    echo set iface up
    sleep 5
    ip link set dev $dev up
fi

echo done
