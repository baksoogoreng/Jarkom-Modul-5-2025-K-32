# --- MISI 2 NO 2: BLOKIR PING KE VILYA ---

# Penjelasan:
# -A INPUT : Menambahkan aturan ke chain INPUT (paket yang masuk ke Vilya)
# -p icmp  : Protokol ICMP
# --icmp-type echo-request : Khusus tipe permintaan ping (ping request)
# -j DROP  : Buang paketnya (jangan dibalas)

iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

testing:
# Dari Elendil coba ping Vilya
ping 192.227.0.34 -c 3

# Dari Vilya coba ping Elendil
ping 192.227.1.2 -c 3