in IronHills:
# Set waktu ke hari Rabu (Wednesday)
go to windows settings, change thes day to 29/11/2023.

# Verifikasi
date

# 1. Izinkan Akses HTTP (Port 80) HANYA pada Sabtu & Minggu UNTUK Subnet tertentu
# Subnet Durin (A12)
iptables -A INPUT -p tcp --dport 80 -s 192.227.0.64/26 -m time --weekdays Sat,Sun -j ACCEPT

# Subnet Khamul (A11)
iptables -A INPUT -p tcp --dport 80 -s 192.227.0.40/29 -m time --weekdays Sat,Sun -j ACCEPT

# Subnet Elendil & Isildur (A5)
iptables -A INPUT -p tcp --dport 80 -s 192.227.1.0/24 -m time --weekdays Sat,Sun -j ACCEPT

# 2. Blokir sisa akses ke Port 80 (Yang bukan weekend atau bukan IP di atas)
iptables -A INPUT -p tcp --dport 80 -j DROP

# IT SHOULD BE IN THIS ORDER

testing:
from elendil:
# Coba akses web server
curl 192.227.0.30 --connect-timeout 5

then, change ur date again to now (weekday):
go to windows settings, change the day to 29/11/2025.

iptables -F
put the iptables again. In Order.

service nginx restart

test again from elendil.