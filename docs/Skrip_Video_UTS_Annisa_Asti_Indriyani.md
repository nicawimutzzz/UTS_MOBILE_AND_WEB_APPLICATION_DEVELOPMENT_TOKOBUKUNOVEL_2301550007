# Skrip Video Presentasi UTS — Toko Buku Novel

**Durasi target: 8–10 menit | Format: Presentasi + Demo Prototype**

---

## PANDUAN PEMBUATAN VIDEO

### Alat yang Disarankan
- **OBS Studio** (gratis) atau **Loom** untuk rekam layar + webcam
- **Google Slides / Canva** untuk slide presentasi
- **Chrome** dengan aplikasi Flutter web running (`flutter run -d chrome`)

### Tips Rekaman
- Buka aplikasi Flutter di Chrome **sebelum mulai rekam**, pastikan sudah login dan beranda tampil
- Siapkan slide presentasi untuk bagian pembuka–rancangan
- Transisi ke demo: alt-tab dari slide ke Chrome
- Bicara dengan tempo normal, jangan terburu-buru
- Jika terjadi kesalahan saat demo, lanjutkan saja — bisa di-edit atau diulang bagian tersebut

---

## SKRIPT PRESENTASI (DENGAN TIMING)

### BAGIAN 1: PEMBUKA (0:00 – 0:45)

> **[SLIDE 1: Judul + Identitas]**

"Selamat pagi/siang. Perkenalkan, nama saya Annisa Asti Indriyani, NIM 23.01.55.0007, dari Kelas A1. Pada presentasi Ujian Tengah Semester mata kuliah Mobile and Web Application Development ini, saya akan memperkenalkan prototype aplikasi yang saya bangun, yaitu **Toko Buku Novel** — aplikasi kasir dan katalog untuk toko buku novel."

---

### BAGIAN 2: MASALAH & PENGGUNA (0:45 – 2:00)

> **[SLIDE 2: Problem Statement + Persona]**

"Masalah yang saya identifikasi adalah: pemilik dan pegawai toko buku novel mengalami kesulitan dalam mencatat transaksi penjualan, memperbarui stok, dan membuat laporan ketika toko melayani pembeli secara langsung. Pencatatan yang masih dilakukan menggunakan buku manual membutuhkan waktu lama, rentan kesalahan, dan data mudah hilang.

Pengguna utama aplikasi ini adalah **pegawai toko buku** yang menggunakan aplikasi saat melayani pembeli di counter, serta **pemilik toko** yang ingin melihat laporan dan mengelola katalog. Pegawai membutuhkan aplikasi yang dapat mencatat transaksi dengan cepat dan memeriksa stok. Pemilik membutuhkan laporan penjualan untuk evaluasi usaha."

---

### BAGIAN 3: KEBUTUHAN & PRIORITAS FITUR (2:00 – 3:30)

> **[SLIDE 3: Tabel MoSCoW + User Stories]**

"Berdasarkan masalah tersebut, saya menentukan kebutuhan fungsional dengan metode MoSCoW:

- **Must**: Kelola data buku (CRUD), catat transaksi penjualan, perbarui stok otomatis, dan tampilan responsif mobile dan web.
- **Should**: Laporan penjualan dengan filter tanggal, dan login email-password.
- **Could/Won't now**: Pre-order dan wishlist.

Saya membuat 5 user story yang menjadi dasar pengembangan. Story pertama: sebagai pemilik, saya ingin mengelola data buku agar katalog tersimpan digital. Story kedua: sebagai pegawai, mencari buku dengan cepat. Story ketiga: mencatat transaksi sehingga stok terbarui otomatis. Story keempat: melihat laporan penjualan. Story kelima: melihat jumlah stok untuk mencegah kehabisan.

Semua fitur Must telah diimplementasikan di prototype ini."

---

### BAGIAN 4: RANCANGAN (3:30 – 5:30)

> **[SLIDE 4: User Flow Diagram]**

"User flow utama aplikasi adalah:

Login → Beranda → Daftar Buku → Detail Buku → Tambah ke Keranjang → Transaksi Penjualan → Simpan → Konfirmasi → Selesai.

Jumlah langkah dari login ke selesai transaksi adalah sekitar 6 langkah utama.

> **[SLIDE 5: Sitemap / Daftar Halaman]**

Aplikasi memiliki 9 halaman: Login, Beranda, Daftar Buku, Detail Buku, Transaksi, Konfirmasi, Form Buku, Laporan, dan Register. Navigasi utama menggunakan Bottom Navigation Bar dengan 4 tab: Beranda, Buku, Transaksi, dan Laporan.

> **[SLIDE 6: Wireframe Figma]**

Wireframe saya buat di Figma dengan 7 frame mobile, 2 keadaan alternatif (galat dan kosong), serta 2 frame web. Saya menerapkan style guide mini: warna primer hijau #2E7D32, tipografi Poppins, tombol minimum 48px tinggi, dan radius 8px. Penilaian Figma dari dosen mendapat skor 98 dari 100.

> **[SLIDE 7: Rancangan Database Firestore]**

Rancangan database Firestore menggunakan 4 collection: `books` untuk data buku, `transactions` untuk transaksi dengan array items, `users` untuk data pengguna, dan `categories` untuk kategori buku. Saat ini data masih di memori (local-first), tetapi arsitektur Repository Pattern sudah memungkinkan migrasi ke Firestore tanpa mengubah UI.

> **[SLIDE 8: Tech Stack]**

Tech stack: Flutter dan Dart untuk aplikasi mobile dan web, Provider untuk state management, Firebase untuk autentikasi dan database (direncanakan), GitHub untuk version control, dan Figma untuk desain."

---

### BAGIAN 5: DEMO PROTOTYPE (5:30 – 8:00)

> **[BERALIH KE CHROME — APLIKASI FLUTTER RUNNING]**

"Berikut demo prototype aplikasi Toko Buku Novel.

> **[Demo 1: Login]**

Saya mulai dari halaman Login. Saya masukkan email annisa@toko.com dan kata sandi 123456, lalu klik Masuk.

> **[Demo 2: Beranda]**

Setelah login, tampil halaman Beranda yang menampilkan ringkasan: jumlah buku, jumlah transaksi, dan total pendapatan. Ada pintasan cepat ke halaman utama.

> **[Demo 3: Daftar Buku + Pencarian]**

Saya buka tab Buku. Daftar buku menampilkan judul, penulis, harga, dan stok. Saya coba fitur pencarian — ketik 'Laskar' — buku ditemukan. Jika pencarian tidak ada hasil, tampil keadaan kosong dengan pesan yang jelas.

> **[Demo 4: Detail Buku]**

Klik salah satu buku untuk melihat detail: sampul, judul, penulis, kategori, harga, stok, dan deskripsi sinopsis.

> **[Demo 5: Form Tambah Buku + Validasi]**

Saya klik tombol Tambah Buku. Form muncul dengan kolom: judul, penulis, kategori (dropdown), harga (angka), stok (angka), dan deskripsi. Saya coba submit dengan kolom kosong — muncul pesan kesalahan di bawah masing-masing kolom. Setelah diisi dengan benar, buku baru langsung tampil di daftar.

> **[Demo 6: Transaksi Penjualan]**

Saya buka tab Transaksi. Pilih buku dari daftar, atur jumlah, buku masuk ke keranjang. Sistem menampilkan total. Jika jumlah melebihi stok, muncul pesan 'Stok tidak mencukupi'. Setelah klik Simpan, stok berkurang otomatis dan muncul SnackBar 'Transaksi berhasil'.

> **[Demo 7: Konfirmasi]**

Halaman konfirmasi menampilkan rincian transaksi: tanggal, item, total, dan status.

> **[Demo 8: Laporan]**

Buka tab Laporan. Pilih rentang tanggal, tampil rekap transaksi dengan total pendapatan dan jumlah transaksi."
