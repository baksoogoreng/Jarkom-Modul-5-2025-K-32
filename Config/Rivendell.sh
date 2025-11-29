#!/bin/bash
# Router Rivendell

# ETH0: Ke Osgiliath (A7)
auto eth0
iface eth0 inet static
    address 192.227.0.18
    netmask 255.255.255.252
    gateway 192.227.0.17

# ETH1: Ke Server Narya/Vilya (A8)
auto eth1
iface eth1 inet static
    address 192.227.0.33
    netmask 255.255.255.248

# --- CLI Runtime ---
up echo 1 > /proc/sys/net/ipv4/ip_forward

up ip addr flush dev eth0
up ip addr add 192.227.0.18/30 dev eth0
up ip link set eth0 up

up ip addr flush dev eth1
up ip addr add 192.227.0.33/29 dev eth1
up ip link set eth1 up

# Default Route ke Osgiliath
up ip route add default via 192.227.0.17

up echo '[Rivendell Ready]'