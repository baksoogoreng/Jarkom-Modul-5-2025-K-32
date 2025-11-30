in Elendil:
apt-get update
apt-get install nmap -y

in Palantir:
# 1. Reset aturan lama agar bersih
iptables -F
iptables -X

# 2. Buat Chain Khusus untuk menghukum Scanner
# Chain ini tugasnya: Catat Log -> Masukkan IP ke Blacklist -> Drop Paket
iptables -N KILL_SCANNER
iptables -A KILL_SCANNER -j LOG --log-prefix "PORT_SCAN_DETECTED " --log-level 4
iptables -A KILL_SCANNER -m recent --set --name BLACKLIST --rsource
iptables -A KILL_SCANNER -j DROP

# 3. RULE UTAMA (INPUT CHAIN)

# A. Cek Blacklist (Satpam Pintu Depan)
# Kalau IP penyerang sudah ada di daftar 'BLACKLIST' (kena ban dalam 60 detik terakhir), tolak SEMUANYA.
iptables -A INPUT -m recent --update --seconds 60 --name BLACKLIST --rsource -j DROP

# B. Deteksi Port Scan (CCTV Penghitung)
# Setiap ada paket TCP SYN (awal koneksi) masuk...
iptables -A INPUT -p tcp --syn -m recent --set --name POTENTIAL_SCAN --rsource

# ...Cek apakah IP ini sudah mengirim lebih dari 15 paket dalam 20 detik terakhir?
# Jika YA, lempar ke chain KILL_SCANNER
iptables -A INPUT -p tcp --syn -m recent --update --seconds 20 --hitcount 15 --name POTENTIAL_SCAN --rsource -j KILL_SCANNER

# (Optional) Pastikan Nginx tetap nyala untuk traffic normal
service nginx restart

testing:
in Elendil:
first: ping 192.227.0.6 -c 3 , has to be reply

now do the REAL test:
nmap -p 1-100 192.227.0.6

after that, try:
# Coba Ping (Harus Gagal)
ping 192.227.0.6 -c 3

# Coba Curl (Harus Gagal)
curl 192.227.0.6 --connect-timeout 5

go to Palantir:
# Lihat 10 baris terakhir log sistem
dmesg | tail or dmesg | grep "PORT_SCAN"

(if theres no log, meh its fine. its alr :D)