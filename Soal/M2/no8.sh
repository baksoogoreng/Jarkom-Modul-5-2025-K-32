in Wilderland:
# ATURAN 1: SIHIR PENGALIHAN (DNAT)
# "Kalau ada paket dari Vilya (SRC) mau ke Khamul (DST), BELOKKAN ke IronHills."
# IP Vilya: 192.227.0.34
# IP Khamul (Target Asli): 192.227.0.42
# IP IronHills (Target Palsu): 192.227.0.30
iptables -t nat -A PREROUTING -s 192.227.0.34 -d 192.227.0.42 -j DNAT --to-destination 192.227.0.30

# ATURAN 2: PASANG TOPENG (SNAT) - SOLUSI TIMEOUT
# "Kalau ada paket dari Vilya yang menuju IronHills (hasil belokan tadi),
# GANTI nama pengirimnya jadi Saya (Wilderland)."
# IP Wilderland (arah Moria): 192.227.0.26
iptables -t nat -A POSTROUTING -s 192.227.0.34 -d 192.227.0.30 -j SNAT --to-source 192.227.0.26

# ATURAN 3: IZINKAN BALIKAN JAWABAN DARI IRONHILLS KE VILYA
# "Kalau ada paket balasan dari IronHills ke Saya (Wilderland),
# IZINKAN paket itu untuk diteruskan ke Vilya." Karena rules sebelumnya.
iptables -I INPUT 1 -p tcp --dport 80 -s 192.227.0.26 -j ACCEPT

# Untuk bersih-bersih tabel NAT dulu (kalo ada rules bertabrakan)
iptables -t nat -F

testing:
from Vilya, coba:
# Logika Testing:
#  - Khamul (Target Asli): Adalah Client biasa. Biasanya tidak menjalankan Web Server (Port 80 tertutup).
#  - IronHills (Target Pembelokan): Adalah Web Server. Port 80 terbuka.
# Jadi, jika Vilya mencoba connect ke Khamul di port 80 dan BERHASIL, itu bukti kuat bahwa dia sebenarnya nyasar ke IronHills.

# Vilya mencoba menyapa Khamul di port 80
nc -v -z 192.227.0.42 80