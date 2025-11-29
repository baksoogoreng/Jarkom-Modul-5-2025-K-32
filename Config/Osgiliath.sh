#!/bin/bash
# Router Osgiliath - Pusat

# --- CONFIG PERMANEN (/etc/network/interfaces) ---
# ETH0: Ke Internet (Valinor)
auto eth0
iface eth0 inet static
    address 192.168.122.100
    netmask 255.255.255.0
    gateway 192.168.122.1

# ETH1: Ke Minastir (A6)
auto eth1
iface eth1 inet static
    address 192.227.0.13
    netmask 255.255.255.252

# ETH2: Ke Rivendell (A7)
auto eth2
iface eth2 inet static
    address 192.227.0.17
    netmask 255.255.255.252

# ETH3: Ke Moria (A9)
auto eth3
iface eth3 inet static
    address 192.227.0.21
    netmask 255.255.255.252

# --- CLI INTERFACE (Runtime) ---
up echo 1 > /proc/sys/net/ipv4/ip_forward

# Up ETH0 (Internet)
up ip addr flush dev eth0
up ip addr add 192.168.122.100/24 dev eth0
up ip link set eth0 up

# Up ETH1 (Ke Minastir)
up ip addr flush dev eth1
up ip addr add 192.227.0.13/30 dev eth1
up ip link set eth1 up

# Up ETH2 (Ke Rivendell)
up ip addr flush dev eth2
up ip addr add 192.227.0.17/30 dev eth2
up ip link set eth2 up

# Up ETH3 (Ke Moria)
up ip addr flush dev eth3
up ip addr add 192.227.0.21/30 dev eth3
up ip link set eth3 up

# --- ROUTING ---

# 1. Route ke Area MINASTIR (A1, A2, A3, A4, A5)
# Via 192.227.0.14 (IP Minastir di A6)
up ip route add 192.227.1.0/24 via 192.227.0.14   # A5 (Elendil)
up ip route add 192.227.0.128/25 via 192.227.0.14 # A1 (Gilgalad)
up ip route add 192.227.0.0/30 via 192.227.0.14   # A2 (Link Pelargir-Anduin)
up ip route add 192.227.0.4/30 via 192.227.0.14   # A3 (Link Pelargir-Palantir)
up ip route add 192.227.0.8/30 via 192.227.0.14   # A4 (Link Minastir-Pelargir)
# 2. Route ke Area RIVENDELL (A8)
# Via 192.227.0.18 (IP Rivendell di A7)
up ip route add 192.227.0.32/29 via 192.227.0.18  # A8 (Server Narya/Vilya)

# 3. Route ke Area MORIA (A10, A11, A12, A13)
# Via 192.227.0.22 (IP Moria di A9)
up ip route add 192.227.0.24/30 via 192.227.0.22  # A10 (Link Moria-Wilderland)
up ip route add 192.227.0.40/29 via 192.227.0.22  # A11 (Khamul)
up ip route add 192.227.0.64/26 via 192.227.0.22  # A12 (Durin)
up ip route add 192.227.0.28/30 via 192.227.0.22  # A13 (IronHills)

# 4. Default Route ke Internet (Valinor)
up ip route add default via 192.168.122.1

# --- MISI 2: SECURITY (NAT SNAT - NO MASQUERADE) ---
# Mengubah source IP paket keluar menjadi IP Osgiliath (192.168.122.100)
up iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 192.168.122.100

up echo '[Osgiliath Ready]'