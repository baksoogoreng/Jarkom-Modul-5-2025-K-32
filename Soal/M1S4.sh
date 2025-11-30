In Narya:
# 1. Install Bind9
apt-get update
apt-get install bind9 -y

# 2. Masukkan Konfigurasi Forwarder (Agar Narya tanya ke Google kalau dia gak tau)
nano /etc/bind/named.conf.options
options {
        directory "/var/cache/bind";
        forwarders {
                8.8.8.8;
        };
        allow-query { any; };
        dnssec-validation auto;
        auth-nxdomain no;
        listen-on-v6 { any; };
};

# 3. Restart Service DNS
service bind9 restart / /usr/sbin/named -u bind

in Vilya:
apt-get update
apt-get install isc-dhcp-server -y

nano /etc/dhcp/dhcpd.conf
# Konfigurasi Global
default-lease-time 600;
max-lease-time 7200;
option domain-name-servers 192.227.0.35; # IP Narya

# Subnet A8 (Jaringan Vilya sendiri) - Wajib ada meski kosong
subnet 192.227.0.32 netmask 255.255.255.248 {
}

# Subnet A1 (Gilgalad & Cirdan) - Prefix /25
subnet 192.227.0.128 netmask 255.255.255.128 {
    range 192.227.0.132 192.227.0.254;
    option routers 192.227.0.129;
    option broadcast-address 192.227.0.255;
}

# Subnet A5 (Elendil & Isildur) - Prefix /24
subnet 192.227.1.0 netmask 255.255.255.0 {
    range 192.227.1.10 192.227.1.254;
    option routers 192.227.1.1;
    option broadcast-address 192.227.1.255;
}

# Subnet A11 (Khamul) - Prefix /29
subnet 192.227.0.40 netmask 255.255.255.248 {
    range 192.227.0.43 192.227.0.46;
    option routers 192.227.0.41;
    option broadcast-address 192.227.0.47;
}

# Subnet A12 (Durin) - Prefix /26
subnet 192.227.0.64 netmask 255.255.255.192 {
    range 192.227.0.67 192.227.0.126;
    option routers 192.227.0.65;
    option broadcast-address 192.227.0.127;
}

sed -i 's/INTERFACESv4=""/INTERFACESv4="eth0"/' /etc/default/isc-dhcp-server

service isc-dhcp-server restart

in Palantir and IronHills:
apt-get update
apt-get install nginx -y

in Palantir:
echo "Welcome to Palantir" > /var/www/html/index.html
service nginx restart

in IronHills:
echo "Welcome to IronHills" > /var/www/html/index.html
service nginx restart

in Relay Nodes (Minastir, AnduinBanks, Rivendell, Wilderland):
echo "nameserver 192.227.0.35" > /etc/resolv.conf

apt-get update
apt-get install isc-dhcp-relay -y

nano /etc/default/isc-dhcp-relay
in Minastir and Wilderland:
SERVERS="192.227.0.34"
INTERFACES="eth0 eth1 eth2"
OPTIONS=""

in AnduinBanks and Rivendell:
SERVERS="192.227.0.34"
INTERFACES="eth0 eth1"
OPTIONS=""

echo 1 > /proc/sys/net/ipv4/ip_forward
service isc-dhcp-relay restart

test