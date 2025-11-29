#!/bin/bash
# Router Wilderland

# ETH0: Ke Moria (A10)
auto eth0
iface eth0 inet static
    address 192.227.0.26
    netmask 255.255.255.252
    gateway 192.227.0.25

# ETH1: Ke Khamul (A11)
auto eth1
iface eth1 inet static
    address 192.227.0.41
    netmask 255.255.255.248

# ETH2: Ke Durin (A12)
auto eth2
iface eth2 inet static
    address 192.227.0.65
    netmask 255.255.255.192

# --- CLI Runtime ---
up echo 1 > /proc/sys/net/ipv4/ip_forward

up ip addr flush dev eth0
up ip addr add 192.227.0.26/30 dev eth0
up ip link set eth0 up

up ip addr flush dev eth1
up ip addr add 192.227.0.41/29 dev eth1
up ip link set eth1 up

up ip addr flush dev eth2
up ip addr add 192.227.0.65/26 dev eth2
up ip link set eth2 up

# Default Route ke Moria
up ip route add default via 192.227.0.25

up echo '[Wilderland Ready]'