# Toko Buku Novel

Aplikasi toko buku novel dengan fitur manajemen katalog, transaksi penjualan, dan laporan. Proyek individu MK Mobile and Web Application Development.

![Screenshot Beranda](docs/screenshot-beranda.png)

## Identitas

- **Nama**: Annisa Asti Indriyani
- **NIM**: 2301550007
- **Kelas**: A1 & A2DLC
- **Semester**: Ganjil 2026/2027

## Tautan

- **Desain Figma (Wireframe Minggu 4)**: [TokoBukuNovel – Wireframe](https://www.figma.com/design/MyIaaWgf0s38K0u3TrqRdP/-2301550007--%E2%80%93--TokoBukuNovel--%E2%80%93--Wireframe)

## Deskripsi Singkat

Toko Buku Novel adalah aplikasi kasir dan katalog untuk toko buku. Pengguna dapat login, melihat ringkasan penjualan di beranda, mengelola data buku (tambah/edit, cari, filter kategori), melakukan transaksi penjualan dengan keranjang dan validasi stok, serta melihat laporan penjualan per periode.

**Fitur utama (Fase 1):**
- Login & Register
- Beranda dengan dashboard ringkasan
- Manajemen buku (CRUD + pencarian + filter kategori)
- Transaksi penjualan dengan keranjang
- Laporan penjualan dengan filter tanggal

**Akun demo:**
| Peran | Email | Kata Sandi |
|---|---|---|
| Pemilik | annisa@toko.com | 123456 |
| Pegawai | pegawai@toko.com | 123456 |

## Cara Menjalankan

```bash
cd tokobukunovel
flutter pub get
flutter run -d chrome   # atau: flutter run (untuk device lain)
```

## Struktur Project

```
lib/
├── main.dart              # Entry point + dependency injection
├── app.dart               # MaterialApp + auth gate
├── models/                # Book, Transaction, User, Category
├── repositories/          # Interface + implementasi (local/, firebase/)
├── providers/             # State management (ChangeNotifier)
├── pages/                 # Halaman aplikasi
├── widgets/               # Komponen reusable
├── theme/                 # Warna, tipografi, gaya tombol
└── utils/                 # Format Rupiah, validators
```

**Catatan arsitektur**: local-first dengan Repository Pattern. Data saat ini disimpan di memori (mock data); koneksi Firebase akan ditambahkan pada fase berikutnya tanpa mengubah UI.
