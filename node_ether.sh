#!/bin/bash

node=$1
eth_iface=eth0
eth_addr=10.0.1.1$node/24

ip addr add dev $eth_iface $eth_addr
