#!/bin/bash
# Router Minastir

# ETH0: Ke Osgiliath (A6)
auto eth0
iface eth0 inet static
    address 192.227.0.14
    netmask 255.255.255.252
    gateway 192.227.0.13

# ETH1: Ke Pelargir (A4)
auto eth1
iface eth1 inet static
    address 192.227.0.9
    netmask 255.255.255.252

# ETH2: Ke Client Elendil/Isildur (A5)
auto eth2
iface eth2 inet static
    address 192.227.1.1
    netmask 255.255.255.0

# --- CLI Runtime ---
up echo 1 > /proc/sys/net/ipv4/ip_forward

up ip addr flush dev eth0
up ip addr add 192.227.0.14/30 dev eth0
up ip link set eth0 up

up ip addr flush dev eth1
up ip addr add 192.227.0.9/30 dev eth1
up ip link set eth1 up

up ip addr flush dev eth2
up ip addr add 192.227.1.1/24 dev eth2
up ip link set eth2 up

# Default Route ke Osgiliath
up ip route add default via 192.227.0.13

# Route ke Bawah (Arah Pelargir)
# Via 192.227.0.10 (IP Pelargir di A4)
up ip route add 192.227.0.128/25 via 192.227.0.10 # A1
up ip route add 192.227.0.0/30 via 192.227.0.10   # A2
up ip route add 192.227.0.4/30 via 192.227.0.10   # A3

up echo '[Minastir Ready]'