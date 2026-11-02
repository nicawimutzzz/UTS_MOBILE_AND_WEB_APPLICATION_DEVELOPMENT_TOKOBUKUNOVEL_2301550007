# Proposal UTS — Toko Buku Novel

**Mobile and Web Application Development (MAWAD)**
Kelas A1 — Semester Ganjil 2026/2027

---

## Identitas

| Field | Isian |
|-------|-------|
| Nama | Annisa Asti Indriyani |
| NIM | 23.01.55.0007 |
| Kelas | A1 / A2DLC |
| Judul Aplikasi | Toko Buku Novel |
| Mata Kuliah | Mobile and Web Application Development |
| Dosen Pengampu | Jeffri Alfa Razaq & Dwi Budi Santoso |
| Tautan Repository GitHub | https://github.com/annisaasti/tokobukunovel _(akan di-push)_ |
| Tautan Figma | https://www.figma.com/design/MyIaaWgf0s38K0u3TrqRdP/-2301550007--TokoBukuNovel--Wireframe |
| Tautan Video | _(akan diisi setelah rekaman)_ |

---

## 1. Problem Statement

Pemilik dan pegawai toko buku novel mengalami kesulitan dalam mencatat transaksi penjualan, memperbarui stok, dan membuat laporan ketika toko melayani pembeli secara langsung. Pencatatan yang masih dilakukan menggunakan buku manual membutuhkan waktu lama, rentan kesalahan, dan data mudah hilang. Laporan penjualan juga sulit dibuat dengan cepat karena harus menyalin data dari catatan manual.

**Pola problem statement:**
> Pemilik dan pegawai toko buku novel mengalami kesulitan pencatatan transaksi, stok, dan laporan penjualan ketika toko melayani pembeli secara langsung. Masalah ini menyebabkan data penjualan mudah salah, stok tidak terbarui, dan laporan membutuhkan waktu lama untuk dibuat. Aplikasi yang saya usulkan membantu pemilik dan pegawai toko buku dengan menyediakan aplikasi penjualan toko buku novel yang dapat mencatat transaksi, mengelola katalog buku, memperbarui stok otomatis, dan menghasilkan laporan penjualan secara cepat dan akurat.

---

## 2. Persona Pengguna Utama

| Elemen | Jawaban |
|--------|---------|
| Peran & konteks penggunaan | Pegawai toko buku yang menggunakan aplikasi saat melayani pembeli di counter toko melalui ponsel atau komputer |
| Tujuan utama | Mencatat transaksi penjualan dengan cepat, memeriksa ketersediaan stok, dan memperbarui data buku |
| Kesulitan/cara sekarang | Pencatatan masih menggunakan buku manual, pencarian buku sulit, stok sering tidak terbarui |
| Kebutuhan utama | Mencatat transaksi, memperbarui stok, mencari buku berdasarkan judul/penulis, melihat laporan penjualan |
| Dasar informasi | Data simulasi berdasarkan Worksheet Minggu 1, observasi proses pencatatan manual di toko buku |
| Pertanyaan validasi | Bagaimana proses pencatatan transaksi dilakukan saat ini dan berapa lama waktu yang dihabiskan? |

---

## 3. User Story dan Kriteria Penerimaan

### Story 1
**Sebagai pemilik**, saya ingin **mengelola data buku (tambah, lihat, edit, hapus)** agar **katalog buku tersimpan secara digital dan mudah diperbarui**.
- Kriteria: Data wajib (judul, penulis, kategori, harga, stok) tidak boleh kosong; buku baru langsung tampil di daftar setelah ditambah.

### Story 2
**Sebagai pegawai**, saya ingin **mencari buku berdasarkan judul atau penulis** agar **buku dapat ditemukan dengan cepat saat pembeli bertanya**.
- Kriteria: Buku yang dicari dapat ditemukan; jika tidak ada, tampilkan pesan "Buku tidak ditemukan".

### Story 3
**Sebagai pegawai**, saya ingin **mencatat transaksi penjualan** agar **transaksi tercatat dan stok terbarui otomatis**.
- Kriteria: Transaksi dengan data wajib lengkap dapat disimpan; stok berkurang sesuai jumlah yang terjual; stok tidak bisa negatif.

### Story 4
**Sebagai pemilik**, saya ingin **melihat laporan penjualan** agar **saya dapat mengevaluasi pendapatan dan jumlah buku terjual**.
- Kriteria: Laporan menampilkan data transaksi dalam rentang tanggal yang dipilih; total pendapatan dan jumlah transaksi ditampilkan.

### Story 5
**Sebagai pemilik**, saya ingin **melihat jumlah stok setiap buku** agar **dapat memperbarui stok sebelum habis**.
- Kriteria: Daftar buku menampilkan jumlah stok; buku dengan stok menipis diberi penanda warna.

---

## 4. Kebutuhan Fungsional dan Prioritas

| Kode | Kebutuhan | F/NF | MoSCoW | Alasan |
|------|-----------|------|--------|--------|
| K1 | Kelola data buku (tambah, lihat, edit, hapus) | F | Must | Dasar katalog — tanpa ini alur inti gagal |
| K2 | Catat transaksi penjualan dan kurangi stok | F | Must | Alur bisnis inti toko buku |
| K3 | Perbarui dan tampilkan stok buku | F | Must | Stok harus mengikuti transaksi secara real-time |
| K4 | Laporan/rekap penjualan dengan filter tanggal | F | Should | Penting untuk evaluasi usaha, MVP tetap berguna tanpa ini |
| K5 | Tampilan responsif pada mobile dan web | NF | Must | Aplikasi ditargetkan untuk ponsel dan browser |
| K6 | Login email/password | F | Should | Membatasi akses pegawai/pemilik |
| K7 | Pre-order dan wishlist | F | Could/Won't now | Belum mendesak untuk MVP |

---

## 5. User Flow (Alur Inti)

**Alur utama (Login → Selesai):**

```
Login → Beranda → Daftar Buku → Detail Buku → Tambah ke Keranjang → Transaksi Penjualan → Simpan Transaksi → Konfirmasi → Selesai
```

**Keputusan/pengecekan sistem:**
- Apakah email & kata sandi valid? → Tidak: tampilkan pesan kesalahan
- Apakah stok buku mencukupi untuk jumlah yang diminta? → Tidak: tampilkan "Stok tidak mencukupi"

**Alur alternatif:**
- Jika stok tidak cukup → sistem menampilkan pesan, transaksi ditolak
- Jika data wajib kosong → tombol Simpan nonaktif, kolom menampilkan pesan kesalahan
- Jika pencarian tidak menemukan buku → tampilkan keadaan kosong

**Jumlah langkah Login → tujuan:** ±6 langkah utama.

---

## 6. Sitemap / Daftar Halaman

| Kode | Nama Halaman | Tujuan / Isi Utama | Prioritas | Muncul di Flow Ke- |
|------|-------------|-------------------|-----------|-------------------|
| H1 | Login | Autentikasi pegawai/pemilik | Must | 1 |
| H2 | Beranda | Ringkasan dashboard + pintasan | Must | 2 |
| H3 | Daftar Buku | Katalog novel, pencarian, filter | Must | 3 |
| H4 | Detail Buku | Sampul, judul, penulis, harga, stok | Must | 4 |
| H5 | Transaksi Penjualan | Keranjang + checkout | Must | 5 |
| H6 | Konfirmasi Transaksi | Rincian transaksi berhasil | Must | 6 |
| H7 | Form Tambah/Edit Buku | Input data buku dengan validasi | Must | Turunan (push) |
| H8 | Laporan Penjualan | Rekap transaksi + filter tanggal | Should | Tidak masuk flow inti |
| H9 | Register | Registrasi pegawai baru | Should | Turunan (push) |

---

## 7. Wireframe / Figma

**Tautan file Figma:**
https://www.figma.com/design/MyIaaWgf0s38K0u3TrqRdP/-2301550007--TokoBukuNovel--Wireframe

**Frame yang dibuat:**
- 7 frame mobile (Login, Beranda, Daftar Buku, Detail Buku, Transaksi, Konfirmasi, Form Buku) + 2 keadaan alternatif (galat, kosong)
- Style guide mini: warna primer #2E7D32, tipografi Poppins, tombol min 48px
- 2 frame web dengan sidebar
- Prototipe klik: Login → Beranda → Daftar Buku → Detail Buku → Transaksi → Konfirmasi

**Nilai penilaian Figma dari dosen: 98/100** (tertinggi sekelas)

---

## 8. Tech Stack

| Komponen | Fungsi dalam Project |
|----------|---------------------|
| Flutter + Dart | Membangun aplikasi mobile dan web dari satu codebase |
| Provider | State management (ChangeNotifier pattern) |
| Firebase Authentication | Login email/password (direncanakan) |
| Cloud Firestore | Menyimpan data buku, transaksi, pengguna |
| Firebase Hosting | Menayangkan versi web |
| GitHub | Menyimpan kode dan riwayat perubahan |
| Figma | Rancangan UI/wireframe |

**Status saat ini:** Local-first (data di memori). Arsitektur Repository Pattern memungkinkan migrasi ke Firebase tanpa mengubah UI/Provider/Model.

---

## 9. Rancangan Database Firestore

### Collection: `books`
```
books/{bookId}
├── judul: String           — judul novel
├── penulis: String         — nama penulis
├── kategori: String        — kategori (Fiksi, Non-Fiksi, dll.)
├── harga: Number           — harga dalam Rupiah
├── stok: Number            — jumlah stok tersedia
├── sampul: String          — URL gambar sampul (opsional)
├── deskripsi: String       — deskripsi sinopsis
├── createdAt: Timestamp    — waktu ditambahkan
└── updatedAt: Timestamp    — waktu terakhir diperbarui
```

### Collection: `transactions`
```
transactions/{transactionId}
├── items: Array            — daftar item transaksi
│   ├── bookId: String      — ID buku
│   ├── judul: String       — judul buku (denormalized)
│   ├── qty: Number         — jumlah dibeli
│   └── harga: Number       — harga satuan
├── total: Number           — total transaksi
├── tanggal: Timestamp      — tanggal transaksi
├── status: String          — "selesai"
├── userId: String          — ID pegawai yang mencatat
└── createdAt: Timestamp    — waktu dibuat
```

### Collection: `users`
```
users/{userId}
├── nama: String            — nama lengkap
├── email: String           — email login
├── peran: String           — "pemilik" atau "pegawai"
└── createdAt: Timestamp    — waktu registrasi
```

### Collection: `categories`
```
categories/{categoryId}
├── nama: String            — nama kategori
└── color: String           — kode warna hex untuk UI
```

### Alur data Firestore:
1. **Baca buku**: `books` collection → stream real-time ke Daftar Buku
2. **Catat transaksi**: tambah doc ke `transactions` + batch update stok di `books` (kurangi stok)
3. **Laporan**: query `transactions` dengan filter `tanggal >= start AND tanggal <= end`
4. **Login**: Firebase Auth → cek `users` collection untuk peran (pemilik/pegawai)

---

## 10. Jawaban Pertanyaan Penguji

### 1. Masalah apa yang diselesaikan aplikasi Anda?
Pencatatan transaksi, pengelolaan stok, dan pembuatan laporan penjualan di toko buku novel yang masih dilakukan secara manual dengan buku catatan. Proses ini lambat, rentan kesalahan, dan data mudah hilang.

### 2. Siapa pengguna utamanya?
Pegawai dan pemilik toko buku novel. Pegawai menggunakan aplikasi untuk mencatat transaksi dan memeriksa stok saat melayani pembeli. Pemilik menggunakannya untuk mengelola katalog dan melihat laporan penjualan.

### 3. Mengapa fitur ini yang diprioritaskan?
Fitur Must (kelola buku, catat transaksi, perbarui stok) diprioritaskan karena merupakan alur bisnis inti toko buku. Tanpa ketiga fitur ini, aplikasi tidak dapat menyelesaikan masalah utama (pencatatan transaksi yang akurat dan cepat). Laporan (Should) dan pre-order (Could) dapat menyusul setelah alur inti berjalan stabil.

### 4. Bagaimana data akan disimpan?
Saat ini data disimpan di memori aplikasi (local-first) menggunakan Repository Pattern. Rancangan database Firestore sudah disiapkan dengan 4 collection: `books`, `transactions`, `users`, `categories`. Setelah UTS, data akan dimigrasi ke Firestore — cukup mengganti implementasi Repository dari `LocalBookRepository` ke `FirebaseBookRepository` tanpa mengubah UI/Provider/Model.

---

## 11. Status Implementasi Prototype

| Komponen | Status | Bukti |
|----------|--------|-------|
| flutter run berhasil di Chrome | ✅ | Build web sukses, aplikasi terbuka di Chrome |
| Minimal 3 halaman terhubung | ✅ | 9 halaman: Login, Beranda, Daftar Buku, Detail, Transaksi, Konfirmasi, Form Buku, Register, Laporan |
| NavigationBar + push/pop | ✅ | BottomNavigationBar 4 tab + Navigator.push untuk halaman turunan |
| Form ≥3 kolom, ≥2 jenis input | ✅ | Form Buku: judul (teks), penulis (teks), kategori (dropdown), harga (angka), stok (angka), deskripsi (multiline) |
| Validasi dengan pesan kesalahan | ✅ | validators.dart: validateRequired, validateEmail, validatePositiveInt |
| Pesan status (SnackBar) | ✅ | SnackBar untuk login gagal, stok tidak cukup, transaksi berhasil |
| Data tampil di halaman daftar | ✅ | Buku yang ditambah via form langsung tampil di Daftar Buku |
| Keadaan kosong ditangani | ✅ | EmptyState widget untuk list kosong & pencarian tidak ditemukan |
| Warna primer style guide | ✅ | #2E7D32 diterapkan via ColorScheme.fromSeed |
| Repository GitHub ≥2 commit | ✅ | 4 commit: init, README+screenshot, test fix, kode lengkap |
| README lengkap + screenshot | ✅ | docs/screenshot-beranda.png |

---

## 12. Rencana Pengembangan Lanjutan (Pertemuan 9–15)

1. **Pertemuan 9**: Migrasi data ke Firebase Firestore (ganti LocalRepository → FirebaseRepository)
2. **Pertemuan 10**: Firebase Authentication untuk login yang sebenarnya
3. **Pertemuan 11**: Tambah fitur Should (Lupa Sandi, Profil)
4. **Pertemuan 12**: Optimasi responsif web (sidebar untuk layar lebar)
5. **Pertemuan 13**: Fitur Could (Pre-order & Wishlist)
6. **Pertemuan 14**: Pengujian menyeluruh + perbaikan bug
7. **Pertemuan 15**: Persiapan UAS — deploy ke Firebase Hosting

---

## 13. Kendala dan Pelajaran

**Kendala yang dialami:**
- Flutter SDK perlu instalasi manual dan konfigurasi PATH di Windows
- Build web pertama memakan waktu cukup lama (±2 menit)
- Test runner Flutter (flutter_tester) bermasalah dengan koneksi WebSocket di environment tertentu
- Ikon di page Web Figma belum tertata rapi (catatan dosen penilaian Minggu 4)

**Pelajaran yang diperoleh:**
- Pentingnya memisahkan kode ke file per halaman sejak awal (struktur lib/pages/)
- Repository Pattern memudahkan testing dan future migration ke database
- Wireframe yang runtut dari user flow mempercepat implementasi kode
- Validasi form harus diturunkan dari kriteria penerimaan, bukan ditambah saat coding
