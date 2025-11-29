#!/bin/bash
# Server Vilya

auto eth0
iface eth0 inet static
    address 192.227.0.34
    netmask 255.255.255.248
    gateway 192.227.0.33
    dns-nameservers 192.227.0.35

# CLI Runtime
up ip addr flush dev eth0
up ip addr add 192.227.0.34/29 dev eth0
up ip link set eth0 up
up ip route add default via 192.227.0.33
up echo 'nameserver 192.227.0.35' > /etc/resolv.conf
up echo '[Vilya Ready]'