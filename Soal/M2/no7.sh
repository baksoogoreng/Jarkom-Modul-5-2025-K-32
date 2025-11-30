in Elendil/or any Client node:
apt-get update
apt-get install apache2-utils -y

in IronHills:
# Kalau mau digabung dengan rules sebelumnya, letakkan aturan ini PALING ATAS.
# Pasang aturan limit koneksi di baris paling atas (INPUT 1)
# Jika koneksi TCP ke port 80 lebih dari 3, langsung REJECT.
iptables -I INPUT 1 -p tcp --syn --dport 80 -m connlimit --connlimit-above 3 -j REJECT

testing:
in Elendil/or any Client node:
# Lakukan tes dengan Apache Benchmark
# Kirim 50 request, dengan 10 koneksi berbarengan (Concurrency = 10)
ab -n 100 -c 10 http://192.227.0.30/

# Cara Baca Output: Cari baris "Failed requests".
#  Jika angkanya > 0 (misal 50-90), berarti BERHASIL (Firewall menolak kelebihan koneksi).
#  Jika 0, berarti gagal (semua lolos).