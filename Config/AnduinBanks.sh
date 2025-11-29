#!/bin/bash
# Router AnduinBanks

# ETH0: Ke Pelargir (A2)
auto eth0
iface eth0 inet static
    address 192.227.0.2
    netmask 255.255.255.252
    gateway 192.227.0.1

# ETH1: Ke Client Gilgalad/Cirdan (A1)
auto eth1
iface eth1 inet static
    address 192.227.0.129
    netmask 255.255.255.128

# --- CLI Runtime ---
up echo 1 > /proc/sys/net/ipv4/ip_forward

up ip addr flush dev eth0
up ip addr add 192.227.0.2/30 dev eth0
up ip link set eth0 up

up ip addr flush dev eth1
up ip addr add 192.227.0.129/25 dev eth1
up ip link set eth1 up

# Default Route ke Pelargir
up ip route add default via 192.227.0.1

up echo '[AnduinBanks Ready]'