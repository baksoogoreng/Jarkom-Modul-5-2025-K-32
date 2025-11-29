#!/bin/bash
# Client Cirdan (Elf)

auto eth0
iface eth0 inet static
    address 192.227.0.131
    netmask 255.255.255.128
    gateway 192.227.0.129
    dns-nameservers 192.227.0.35

# CLI Runtime
up ip addr flush dev eth0
up ip addr add 192.227.0.131/25 dev eth0
up ip link set eth0 up
up ip route add default via 192.227.0.129
up echo 'nameserver 192.227.0.35' > /etc/resolv.conf
up echo '[Cirdan Ready]'