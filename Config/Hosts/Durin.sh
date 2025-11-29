#!/bin/bash
# Client Durin (Dwarf)

auto eth0
iface eth0 inet static
    address 192.227.0.66
    netmask 255.255.255.192
    gateway 192.227.0.65
    dns-nameservers 192.227.0.35

# CLI Runtime
up ip addr flush dev eth0
up ip addr add 192.227.0.66/26 dev eth0
up ip link set eth0 up
up ip route add default via 192.227.0.65
up echo 'nameserver 192.227.0.35' > /etc/resolv.conf
up echo '[Durin Ready]'