#!/bin/bash
# Client Elendil (Human)

auto eth0
iface eth0 inet static
    address 192.227.1.2
    netmask 255.255.255.0
    gateway 192.227.1.1
    dns-nameservers 192.227.0.35

# CLI Runtime
up ip addr flush dev eth0
up ip addr add 192.227.1.2/24 dev eth0
up ip link set eth0 up
up ip route add default via 192.227.1.1
up echo 'nameserver 192.227.0.35' > /etc/resolv.conf
up echo '[Elendil Ready]'