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

**Akun login (Minggu 9 — Firebase Authentication):**
Sejak Minggu 9, login memakai **Firebase Auth Email/Password**, bukan lagi akun demo lokal. Sebelum menjalankan aplikasi:
1. Aktifkan **Email/Password** di Firebase Console → *Build → Authentication → Sign-in method* untuk project `toko-buku-novel` (paket Spark, tanpa billing account).
2. Tekan **Daftar** di aplikasi untuk membuat akun simulasi, misalnya `annisa@toko.com` / `toko123456`. **Jangan memakai password asli.**
3. Akun yang berhasil dibuat akan muncul di **Authentication > Users** (salah satu luaran wajib Minggu 9).

> Akun demo lama (`annisa@toko.com` / `123456`, `pegawai@toko.com` / `123456`) hanya berlaku pada `LocalAuthRepository`, yang kini dipakai oleh widget test.

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

**Catatan arsitektur**: local-first dengan Repository Pattern. **Autentikasi sudah memakai Firebase Authentication** sejak Minggu 9 (`FirebaseAuthRepository`, `authStateChanges()` + `_AuthGate`), sehingga sesi login bertahan setelah refresh. Katalog buku, transaksi, dan laporan masih disimpan di memori (`LocalBookRepository` / `LocalTransactionRepository`); pemindahan ke Cloud Firestore direncanakan pada Minggu 10 dan cukup mengganti implementasi repository tanpa mengubah UI.

## Dokumen UTS

| Dokumen | Lokasi |
|---------|--------|
| Proposal UTS (DOCX) | `docs/Proposal_UTS_Annisa_Asti_Indriyani.docx` |
| Proposal UTS (Markdown) | `docs/Proposal_UTS_Annisa_Asti_Indriyani.md` |
| Rencana Video Remotion | `docs/Rencana_Video_Remotion_UTS.md` |
| Skrip Video Presentasi | `docs/Skrip_Video_UTS_Annisa_Asti_Indriyani.md` |
| Panduan Minggu 9 — Firebase Login | `docs/Panduan_Minggu9_Firebase_Login.md` |
| Lembar Kerja Minggu 9 (siap kumpul) | `docs/Lembar_Kerja_Minggu9_Annisa_Asti_Indriyani.docx` |

## Minggu 9 — Firebase Login

| Butir | Keterangan |
|---|---|
| Project Firebase | `toko-buku-novel` (paket Spark, tanpa billing account) |
| Penyedia login | Email/Password |
| Inisialisasi | `await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)` di `lib/main.dart` |
| Status login | `_AuthGate` + `StreamBuilder` + `authStateChanges()` di `lib/app.dart` |
| Pesan kesalahan | `lib/utils/auth_errors.dart` — 8 kode `FirebaseAuthException` diterjemahkan ke bahasa pengguna |
| Target uji | Chrome (`flutter run -d chrome`) |
| Verifikasi | `flutter pub get` ✅ · `flutter analyze` **0 error** ✅ · `flutter build web` ✅ |

Panduan langkah demi langkah, tabel uji 10 kasus, dan jawaban refleksi tersedia di `docs/Panduan_Minggu9_Firebase_Login.md` dan lembar kerja DOCX. Kolom **Hasil nyata** serta screenshot **Authentication > Users** diisi saat praktikum setelah akun simulasi dibuat.

> Catatan lingkungan: `flutter test` pada mesin ini gagal dengan `WebSocketException: Invalid WebSocket upgrade request` (masalah `flutter_tester`, bukan kode). Pembuktian kompilasi dilakukan melalui `flutter analyze` dan `flutter build web`.

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
| 7 | `347d975` | 4 Nov 2026 | README: tambah section Screenshot dan Riwayat Commit |
| 8 | `9b3f13d` | 9 Nov 2026 | README: lengkapi tabel Riwayat Commit dengan commit ke-7 |
| 9 | `d2349ab` | 9 Nov 2026 | Minggu 9 (Latihan 1): Hubungkan project ke Firebase |
| 10 | `5ffd89c` | 9 Nov 2026 | Minggu 9 (Latihan 2–4): login Firebase, auth gate, pesan kesalahan, panduan + lembar kerja |

Riwayat commit bertahap dari minggu 5 (26 Okt) hingga Minggu 9 (9 Nov), mencakup inisialisasi project, penambahan dokumentasi, perbaikan test, submission UTS, penyempurnaan README, dan integrasi Firebase Authentication. Riwayat lengkap dapat dilihat dengan `git log --oneline`.
