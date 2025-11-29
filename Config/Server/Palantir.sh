#!/bin/bash
# Server Palantir

auto eth0
iface eth0 inet static
    address 192.227.0.6
    netmask 255.255.255.252
    gateway 192.227.0.5
    dns-nameservers 192.227.0.35

# CLI Runtime
up ip addr flush dev eth0
up ip addr add 192.227.0.6/30 dev eth0
up ip link set eth0 up
up ip route add default via 192.227.0.5
up echo 'nameserver 192.227.0.35' > /etc/resolv.conf
up echo '[Palantir Ready]'