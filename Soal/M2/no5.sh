in Palantir:
# 1. Bersihkan aturan lama
iptables -F

# 2. Aturan untuk FAKSI ELF (Gilgalad & Cirdan - Subnet A1: 192.227.0.128/25)
# Hanya boleh jam 07:00 - 15:00
iptables -A INPUT -p tcp --dport 80 -s 192.227.0.128/25 -m time --timestart 07:00 --timestop 15:00 -j ACCEPT

# 3. Aturan untuk FAKSI MANUSIA (Elendil & Isildur - Subnet A5: 192.227.1.0/24)
# Hanya boleh jam 17:00 - 23:00
iptables -A INPUT -p tcp --dport 80 -s 192.227.1.0/24 -m time --timestart 17:00 --timestop 23:00 -j ACCEPT

# 4. Blokir sisanya (Semua akses port 80 yang tidak sesuai kriteria di atas)
iptables -A INPUT -p tcp --dport 80 -j DROP

# 5. Pastikan Nginx jalan
service nginx restart

testing:
from gilgalad (elf):
# Cek jam dulu (optional, buat memastikan)
date

# Akses Palantir | Hanya boleh jam 07:00 - 15:00
curl 192.227.0.6 or curl 192.227.0.6 --connect-timeout 5

from elendil (manusia):
# Cek jam dulu (optional, buat memastikan)
date

# Akses Palantir | Hanya boleh jam 17:00 - 23:00
curl 192.227.0.6 or curl 192.227.0.6 --connect-timeout 5