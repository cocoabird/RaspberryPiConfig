#!/bin/bash

node=$1
dev=wlan0
ssid=rlnc-rasp
bssid=4C:12:DC:B6:AF:B7
freq=2462
addr=10.0.3.$node/24

ip link set dev $dev down
iw dev $dev set type ibss
ip link set dev $dev up
iw dev $dev ibss join $ssid $freq $bssid
ip addr add dev $dev $addr
