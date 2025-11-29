#!/bin/bash
# Server IronHills

auto eth0
iface eth0 inet static
    address 192.227.0.30
    netmask 255.255.255.252
    gateway 192.227.0.29
    dns-nameservers 192.227.0.35

# CLI Runtime
up ip addr flush dev eth0
up ip addr add 192.227.0.30/30 dev eth0
up ip link set eth0 up
up ip route add default via 192.227.0.29
up echo 'nameserver 192.227.0.35' > /etc/resolv.conf
up echo '[IronHills Ready]'