#!/bin/bash
# Router Moria

# ETH0: Ke Osgiliath (A9)
auto eth0
iface eth0 inet static
    address 192.227.0.22
    netmask 255.255.255.252
    gateway 192.227.0.21

# ETH1: Ke Wilderland (A10)
auto eth1
iface eth1 inet static
    address 192.227.0.25
    netmask 255.255.255.252

# ETH2: Ke IronHills (A13)
auto eth2
iface eth2 inet static
    address 192.227.0.29
    netmask 255.255.255.252

# --- CLI Runtime ---
up echo 1 > /proc/sys/net/ipv4/ip_forward

up ip addr flush dev eth0
up ip addr add 192.227.0.22/30 dev eth0
up ip link set eth0 up

up ip addr flush dev eth1
up ip addr add 192.227.0.25/30 dev eth1
up ip link set eth1 up

up ip addr flush dev eth2
up ip addr add 192.227.0.29/30 dev eth2
up ip link set eth2 up

# Default Route ke Osgiliath
up ip route add default via 192.227.0.21

# Route ke Bawah (Wilderland Clients)
# Via 192.227.0.26 (IP Wilderland di A10)
up ip route add 192.227.0.40/29 via 192.227.0.26 # A11 (Khamul)
up ip route add 192.227.0.64/26 via 192.227.0.26 # A12 (Durin)

up echo '[Moria Ready]'