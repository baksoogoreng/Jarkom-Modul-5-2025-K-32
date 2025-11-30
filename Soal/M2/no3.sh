in Narya:
# 1. Izinkan Vilya (192.227.0.34) mengakses port 53 (UDP & TCP)
iptables -A INPUT -s 192.227.0.34 -p udp --dport 53 -j ACCEPT
iptables -A INPUT -s 192.227.0.34 -p tcp --dport 53 -j ACCEPT

# 2. Blokir semua akses lain ke port 53
iptables -A INPUT -p udp --dport 53 -j DROP
iptables -A INPUT -p tcp --dport 53 -j DROP

after testing:
# Hapus semua aturan di Narya (Flush)
iptables -F

testing:
from Vilya, coba:
# Cek koneksi ke port 53 UDP Narya
nc -z -v -u 192.227.0.35 53
should be: Connection to 192.227.0.35 53 port [udp/domain] succeeded!

from Elendil, coba:
apt-get update
is should be cant access to DNS (Narya).
