#!/bin/bash
# Router Pelargir

# ETH0: Ke Minastir (A4)
auto eth0
iface eth0 inet static
    address 192.227.0.10
    netmask 255.255.255.252
    gateway 192.227.0.9

# ETH1: Ke AnduinBanks (A2)
auto eth1
iface eth1 inet static
    address 192.227.0.1
    netmask 255.255.255.252

# ETH2: Ke Palantir (A3)
auto eth2
iface eth2 inet static
    address 192.227.0.5
    netmask 255.255.255.252

# --- CLI Runtime ---
up echo 1 > /proc/sys/net/ipv4/ip_forward

up ip addr flush dev eth0
up ip addr add 192.227.0.10/30 dev eth0
up ip link set eth0 up

up ip addr flush dev eth1
up ip addr add 192.227.0.1/30 dev eth1
up ip link set eth1 up

up ip addr flush dev eth2
up ip addr add 192.227.0.5/30 dev eth2
up ip link set eth2 up

# Default Route ke Minastir
up ip route add default via 192.227.0.9

# Route ke Bawah (A1 - Gilgalad) via AnduinBanks
up ip route add 192.227.0.128/25 via 192.227.0.2

up echo '[Pelargir Ready]'