#!/bin/bash
# Server Narya

auto eth0
iface eth0 inet static
    address 192.227.0.35
    netmask 255.255.255.248
    gateway 192.227.0.33
    dns-nameservers 192.168.122.1

# CLI Runtime
up ip addr flush dev eth0
up ip addr add 192.227.0.35/29 dev eth0
up ip link set eth0 up
up ip route add default via 192.227.0.33
up echo 'nameserver 192.168.122.1' > /etc/resolv.conf
up echo '[Narya Ready]'