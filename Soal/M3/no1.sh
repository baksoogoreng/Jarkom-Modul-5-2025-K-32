in Wilderland:
# 1. Blokir paket YANG KELUAR DARI Khamul (Source = Subnet Khamul)
# Gunakan -I FORWARD 1 agar aturan ini ditaruh paling atas (Prioritas Tertinggi)
iptables -I FORWARD 1 -s 192.227.0.40/29 -j DROP

# 2. Blokir paket YANG MENUJU KE Khamul (Destination = Subnet Khamul)
iptables -I FORWARD 1 -d 192.227.0.40/29 -j DROP

testing:
from khamul, coba:
# 1. Ping ke Internet (Gagal)
ping 8.8.8.8 -c 3
# 2. Ping ke Tetangga (Durin - 192.227.0.66) (Gagal)
ping 192.227.0.66 -c 3
# 3. Akses Web Server (Gagal)
curl 192.227.0.30 --connect-timeout 5

from outside (Vilya / Elendil), coba:
# Ping ke IP Khamul (192.227.0.42)
ping 192.227.0.42 -c 3

in Durin:
# still safe.
# Durin ping ke Google
ping 8.8.8.8 -c 3