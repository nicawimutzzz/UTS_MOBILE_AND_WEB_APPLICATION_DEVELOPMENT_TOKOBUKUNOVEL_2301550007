# Toko Buku Novel

Aplikasi toko buku novel dengan fitur manajemen katalog, transaksi penjualan, dan laporan. Proyek individu MK Mobile and Web Application Development.

## Identitas

- **Nama**: Annisa Asti Indriyani
- **NIM**: 2301550007
- **Kelas**: A1 & A2DLC
- **Semester**: Ganjil 2026/2027

## Tautan

- **Repository GitHub**: [UTS_MOBILE_AND_WEB_APPLICATION_DEVELOPMENT_TOKOBUKUNOVEL_2301550007](https://github.com/nicawimutzzz/UTS_MOBILE_AND_WEB_APPLICATION_DEVELOPMENT_TOKOBUKUNOVEL_2301550007)
- **Desain Figma (Wireframe Minggu 4)**: [TokoBukuNovel – Wireframe](https://www.figma.com/design/MyIaaWgf0s38K0u3TrqRdP/-2301550007--%E2%80%93--TokoBukuNovel--%E2%80%93--Wireframe)
- **Proposal UTS**: [docs/Proposal_UTS_Annisa_Asti_Indriyani.docx](docs/Proposal_UTS_Annisa_Asti_Indriyani.docx)

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

## Screenshot

![Screenshot Beranda Aplikasi](docs/screenshot-beranda.png)

*Halaman beranda aplikasi TokoBukuNovel menampilkan dashboard ringkasan penjualan, katalog buku, dan navigasi bottom bar.*

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

## Dokumen UTS

| Dokumen | Lokasi |
|---------|--------|
| Proposal UTS (DOCX) | `docs/Proposal_UTS_Annisa_Asti_Indriyani.docx` |
| Proposal UTS (Markdown) | `docs/Proposal_UTS_Annisa_Asti_Indriyani.md` |
| Rencana Video Remotion | `docs/Rencana_Video_Remotion_UTS.md` |
| Skrip Video Presentasi | `docs/Skrip_Video_UTS_Annisa_Asti_Indriyani.md` |

## Video Presentasi UTS

Video dibuat menggunakan Remotion (React video framework) + edge-tts (TTS gratis Bahasa Indonesia).

```bash
cd video-uts
npm install
npm run dev      # preview di Remotion Studio
npm run render   # render ke out/uts-tokobukunovel.mp4
```

**Voice**: id-ID-GadisNeural (Microsoft Edge TTS)
**Durasi**: ~6.5 menit | **Resolusi**: 720p | **7 scene**

## Riwayat Commit

| # | Commit | Tanggal | Pesan |
|---|--------|---------|-------|
| 1 | `b28f148` | 26 Okt 2026 | Inisialisasi project Flutter TokoBukuNovel |
| 2 | `9cbadf4` | 26 Okt 2026 | Tambah README dan screenshot |
| 3 | `fd04d4a` | 2 Nov 2026 | Perbaiki widget test: ganti test bawaan template dengan test halaman login |
| 4 | `dd25263` | 2 Nov 2026 | Initial commit (merge remote) |
| 5 | `b5b15a7` | 2 Nov 2026 | UTS: Tambah proposal, video Remotion + TTS, dan perbarui README |
| 6 | `31ed940` | 2 Nov 2026 | Merge remote README, keep local version |

Riwayat commit bertahap dari minggu 5 (26 Okt) hingga minggu UTS (2 Nov), mencakup inisialisasi project, penambahan dokumentasi, perbaikan test, dan submission UTS.
