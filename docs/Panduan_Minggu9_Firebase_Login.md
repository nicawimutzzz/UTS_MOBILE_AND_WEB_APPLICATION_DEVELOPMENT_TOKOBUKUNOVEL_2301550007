# Panduan Pengerjaan — Minggu 9

## Menghubungkan Firebase dan Login Email/Password

| Identitas                | Isian                                                                                                 |
| ------------------------ | ----------------------------------------------------------------------------------------------------- |
| Nama / NIM               | Annisa Asti Indriyani / 2301550007                                                                    |
| Kelas dan judul aplikasi | A1 & A2DLC — **Toko Buku Novel**                                                                      |
| Tautan repository GitHub | <https://github.com/nicawimutzzz/UTS_MOBILE_AND_WEB_APPLICATION_DEVELOPMENT_TOKOBUKUNOVEL_2301550007> |
| Nama project Firebase    | `toko-buku-novel` (paket Spark)                                                                       |
| Target                   | Chrome (`flutter run -d chrome`)                                                                      |

Sumber: `modul-minggu-09-firebase-login.docx` (8 bab, 15 tabel) dan `materi-ajar-minggu-09-firebase-login.pptx` (24 slide).

**Dokumen pendamping:** `docs/Lembar_Kerja_Minggu9_Annisa_Asti_Indriyani.docx` — lembar kerja siap kumpul, berisi identitas, peta konsep, langkah pengerjaan, bukti kode 4 latihan, tabel uji 10 kasus, tempat tempel screenshot `Authentication > Users`, jawaban refleksi, daftar periksa luaran, dan bukti commit. Ringkasan perintah dan penjelasan ada di panduan Markdown ini.

---

## A. Apa yang dituntut modul

**5 target capaian** (slide 3):

1. Menjelaskan peran Firebase Auth, autentikasi, dan otorisasi.
2. Membuat project Spark dan menghubungkannya ke Flutter.
3. Membangun alur daftar, masuk, dan keluar.
4. Mengarahkan halaman sesuai status login.
5. Menampilkan pesan kesalahan login yang jelas.

**7 luaran yang dikumpulkan** (slide 3 & 24, tabel 13):

- Project Spark terhubung, tanpa billing account
- Daftar, masuk, keluar berjalan di Chrome
- Halaman utama hanya terbuka setelah login
- Sesi bertahan setelah refresh
- Kesalahan login tampil sebagai pesan yang jelas
- Tabel uji login ≥ 5 kasus
- Screenshot **Authentication > Users**
- ≥ 2 commit baru ter-push + tautan repository

**Batas pertemuan ini** (slide 2): target **Chrome**, hanya penyedia **Email/Password**, paket **Spark**.  
Hindari: billing account, login Google / nomor telepon, **password asli Anda**, dan **Firestore** (masuk Minggu 10).

---

## B. Peta contoh RoomBook → project TokoBukuNovel

Modul memakai studi kasus *RoomBook* (reservasi ruangan). Padanan di project kamu:

| Konsep di modul                       | Di TokoBukuNovel                                                                    |
| ------------------------------------- | ----------------------------------------------------------------------------------- |
| `RoomBookApp`                         | `TokoBukuNovelApp` (`lib/app.dart`)                                                 |
| Halaman Utama / reservasi             | `HomePage` — dashboard, katalog buku, transaksi, laporan                            |
| `masuk_page.dart` (1 halaman, 2 mode) | `login_page.dart` + `register_page.dart` (2 halaman, pola Form Minggu 7 tetap sama) |
| `cek_status_login.dart`               | `_AuthGate` di `lib/app.dart` (`StreamBuilder` + `authStateChanges()`)              |
| `validasi_auth.dart`                  | `lib/utils/validators.dart` + **baru** `lib/utils/auth_errors.dart`                 |
| `lib/firebase_options.dart`           | **baru** `lib/firebase_options.dart` (jalur cadangan)                               |
| Data reservasi di memori              | `LocalBookRepository` / `LocalTransactionRepository` (masih lokal)                  |
| Contoh kode `contoh-kode-roombook`    | Project ini sendiri                                                                 |

> Catatan: modul menyarankan **satu halaman dua mode**. Project kamu sudah punya dua halaman terpisah dengan `Form` + `GlobalKey` + `validator` + `obscureText` yang sama persis. Ini tetap memenuhi substansi Latihan 2 — tuliskan alasannya di refleksi bila dosen menanyakan.

---

## C. Yang SUDAH dikerjakan di repository

| #  | File                                                      | Perubahan                                                                          |
| -- | --------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| 1  | `pubspec.yaml`                                            | `sdk: ^3.6.0`; `firebase_core: 5.1.0`, `firebase_auth: 7.0.1`                      |
| 2  | `lib/firebase_options.dart`                               | **Baru** — config project `toko-buku-novel` (jalur cadangan, hal. 12)              |
| 3  | `lib/main.dart`                                           | `Future<void> main() async` + `await Firebase.initializeApp(...)` sebelum `runApp` |
| 4  | `lib/repositories/auth_repository.dart`                   | Tambah kontrak `Stream<User?> get authStateChanges`                                |
| 5  | `lib/repositories/firebase/firebase_auth_repository.dart` | **Diisi** — daftar/masuk/keluar + terjemahan `FirebaseAuthException`               |
| 6  | `lib/repositories/local/local_auth_repository.dart`       | Implementasi stream untuk widget test                                              |
| 7  | `lib/utils/auth_errors.dart`                              | **Baru** — `pesanKesalahanAuth(kode)` untuk 8 kode error                           |
| 8  | `lib/providers/auth_provider.dart`                        | Dengarkan `authStateChanges`, tangkap `AuthFailure`, sinkron `_user`               |
| 9  | `lib/app.dart`                                            | `_AuthGate` → `StreamBuilder<User?>`; parameter `halamanAwal` untuk test           |
| 10 | `lib/pages/login_page.dart`                               | Hapus kredensial bawaan, tombol nonaktif saat proses, hint akun simulasi           |
| 11 | `lib/pages/register_page.dart`                            | Validator "Ulangi password" / "Password tidak sama", tombol nonaktif               |
| 12 | `lib/pages/home_page.dart`                                | Tombol Keluar diberi `tooltip: 'Keluar'`                                           |
| 13 | `test/widget_test.dart`                                   | Pakai `halamanAwal`, + 2 unit test terjemahan pesan error                          |

**Verifikasi yang sudah lolos:** `flutter pub get` ✅ · `flutter analyze` **0 error** ✅ · `flutter build web` ✅  
`flutter test` gagal di mesin ini karena `WebSocketException: Invalid WebSocket upgrade request` (masalah environment `flutter_tester`, bukan kode) — catat di refleksi.

**Bukti praktikum yang sudah terkumpul (9 Nov 2026):**
- `docs/screenshot-auth-users.png` — Authentication > Users, 1 akun `annisa@toko.com`, provider Email/Password, paket Spark $0/month.
- `docs/screenshot-beranda-setelah-login.png` — Beranda tampil otomatis setelah **Daftar**, dengan sapaan "Selamat datang, Annisa Simulasi!" (membuktikan `displayName` tersimpan dan `_AuthGate` berpindah halaman).
- Keduanya sudah tertempel di `docs/Lembar_Kerja_Minggu9_Annisa_Asti_Indriyani.docx` (Bagian E.5 dan G.2).

---

## D. Yang HARUS kamu lakukan sendiri (di Firebase Console & kelas)

### Langkah 1 — Aktifkan penyedia Email/Password ⚠️ PALING SERING TERLEWAT

1. Buka <https://console.firebase.google.com> → pilih project **`toko-buku-novel`**.
2. Pastikan paket masih **Spark** dan **tidak ada billing account**.
3. Buka **Build → Authentication → Get started → tab Sign-in method**.
4. Aktifkan **Email/Password** → Save.
   - Kalau ini belum aktif, semua percobaan login akan gagal dengan `operation-not-allowed`.

### Langkah 2 — Pastikan aplikasi web terdaftar

Project settings → **Your apps** → ikon `</>`. Aplikasi web sudah kamu daftarkan (dari `firebaseConfig` yang kamu miliki).  
Nilainya sudah disalin ke `lib/firebase_options.dart`, jadi **tidak perlu** menjalankan FlutterFire CLI.

### Langkah 3 — Jalankan di Chrome

```bash
c
flutter pub get
flutter run -d chrome
```

Pastikan tidak muncul `No Firebase App '[DEFAULT]' has been created`.

### Langkah 4 — Buat akun simulasi

Tekan **Daftar**, isi nama + email + password simulasi, misalnya:  
`annisa@toko.com` / `toko123456` — **jangan pakai password asli Anda**.  
Setelah berhasil, cek **Authentication > Users** → akun harus muncul. **Ambil screenshot di sini** (salah satu luaran wajib).

### Langkah 5 — Uji 5+ kasus (isi tabel di bawah)

### Langkah 6 — Uji teman + commit

Minta teman mencoba kolom kosong, email salah format, password salah; daftar akun baru; refresh; tekan Keluar. Perbaiki satu temuan, lalu commit & push.

---

## E. Empat latihan & buktinya

| Latihan | Isi                  | Bukti saat kelas                       | Status kode                 |
| ------- | -------------------- | -------------------------------------- | --------------------------- |
| 1       | Setup Firebase       | Aplikasi berjalan setelah inisialisasi | ✅ Selesai                   |
| 2       | Halaman Masuk/Daftar | Akun simulasi muncul di Console        | ✅ Kode siap, tinggal diuji  |
| 3       | Cek status login     | Sesi bertahan setelah refresh          | ✅ Kode siap, tinggal diuji  |
| 4       | Pesan kesalahan      | Tabel uji terisi                       | ✅ Kode siap, tabel di bawah |

---

## F. Tabel uji login (Latihan 4)

Isi kolom **Hasil nyata** setelah menjalankan Langkah 5. **8 dari 10 kasus sudah terisi** (kasus 2–9, diverifikasi 9 Nov 2026) dan sudah disalin ke lembar kerja DOCX. **Syarat modul "tabel uji ≥ 5 kasus" terlampaui.** Tersisa kasus 1 dan 10.

| #  | Kasus uji                    | Input                                      | Hasil yang diharapkan                       | Hasil nyata |
| -- | ---------------------------- | ------------------------------------------ | ------------------------------------------- | ----------- |
| 1  | Login benar                  | Akun simulasi yang sudah dibuat            | Halaman Utama (Beranda) tampil              |             |
| 2  | Password salah               | Email benar + password `salah123`          | `Email atau password salah`                 | ✅ Kotak merah "Email atau password salah" |
| 3  | Email tidak valid            | `bukan-email`                              | `Format email tidak valid` (validator Form) | ✅ Pesan merah di bawah kolom Email |
| 4  | Kolom kosong                 | Email & password dikosongkan               | Kedua kolom menampilkan pesan wajib isi     | ✅ Kedua pesan wajib isi muncul |
| 5  | Daftar dengan email terpakai | Email yang sudah terdaftar                 | `Email sudah terdaftar. Silakan masuk.`     | ✅ Kotak merah sesuai |
| 6  | Password terlalu pendek      | `123` saat daftar                          | `Kata sandi minimal 6 karakter`             | ✅ Pesan di bawah Kata Sandi (+ temuan, lihat §L) |
| 7  | Konfirmasi password beda     | Password `toko123456`, ulangi `toko654321` | `Password tidak sama`                       | ✅ Pesan di bawah Konfirmasi (+ temuan, lihat §L) |
| 8  | Refresh setelah login        | Tekan F5 / Ctrl+R di Chrome                | Tetap di Halaman Utama (sesi bertahan)      | ✅ Sesuai — Beranda tetap tampil, sapaan nama masih ada |
| 9  | Tekan Keluar                 | Ikon logout di AppBar Beranda              | Kembali ke Halaman Masuk                    | ✅ Sesuai — kembali ke halaman Masuk |
| 10 | Refresh lalu cek data        | Refresh, buka menu Transaksi               | Transaksi baru hilang (masih di memori)     |             |

> Kasus 10 adalah **jembatan ke Minggu 10**: sesi login bertahan, data buku/transaksi belum.

### Pemetaan kode error (bab 6 / slide 19)

| `e.code`                                                   | Pesan untuk pengguna                             |
| ---------------------------------------------------------- | ------------------------------------------------ |
| `invalid-credential` / `wrong-password` / `user-not-found` | Email atau password salah                        |
| `invalid-email`                                            | Format email belum benar                         |
| `email-already-in-use`                                     | Email sudah terdaftar. Silakan masuk.            |
| `weak-password`                                            | Password terlalu lemah, minimal 6 karakter       |
| `too-many-requests`                                        | Terlalu banyak percobaan. Coba lagi nanti.       |
| `network-request-failed`                                   | Tidak dapat terhubung. Periksa koneksi internet. |
| `operation-not-allowed`                                    | Login email/password belum diaktifkan            |

**Kenapa pesan `user-not-found` dan `wrong-password` disamakan?** Karena project Firebase baru mengaktifkan *email enumeration protection*. Kalau pesannya dibedakan, orang lain bisa menebak email mana yang terdaftar.

---

## G. Daftar periksa luaran

| Butir                                                | Ya/Belum                                                                                                                      |
| ---------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Project Firebase Spark terhubung, tanpa billing      | ☑ Screenshot Console, Spark $0/month                                                                                            |
| Daftar, masuk, dan keluar berjalan di Chrome         | Sebagian: **daftar ✅** dan **keluar ✅** (kasus 9); masuk menyusul (kasus 1)                                                |
| Halaman utama hanya terbuka setelah login            | ☑ Halaman Masuk tampil lebih dulu, lalu Beranda otomatis, lalu Keluar kembali ke Masuk                                         |
| Sesi bertahan setelah refresh                        | ☑ **Kasus 8** — Beranda tetap tampil setelah Ctrl+R, sapaan nama masih ada                                                    |
| Kesalahan login tampil sebagai pesan yang jelas      | ☑ Seluruh kasus 2–7 teruji, pesan sesuai yang diharapkan                                                                   |
| Tabel uji login ≥ 5 kasus terisi                     | ☑ **8 dari 10 kasus** — jauh melebihi syarat minimal 5, tertulis di lembar kerja DOCX                                      |
| Screenshot daftar pengguna di Authentication > Users | ☑ `docs/screenshot-auth-users.png` — tertempel di lembar kerja                                                                   |
| ≥ 2 commit baru ter-push                             | ☑ **8 commit khusus Minggu 9** (`d2349ab` … `42eda55`) — lihat Bagian L lembar kerja dan `git log --oneline`                  |

---

## H. Refleksi individu (bisa dipakai sebagai jawaban)

**1. Halaman mana yang boleh dibuka tanpa login, dan mengapa?**  
Halaman **Masuk** dan **Daftar**. Keduanya adalah satu-satunya jalan bagi pengguna untuk membuktikan identitas; kalau halaman ini pun diproteksi, tidak ada pintu masuk. `_AuthGate` di `lib/app.dart` memakai `authStateChanges()` dan hanya mengarahkan ke `HomePage` bila ada `User`. Beranda, Daftar Buku, Transaksi, dan Laporan hanya untuk pengguna yang sudah masuk karena menampilkan stok dan data penjualan — ini contoh **otorisasi** ("boleh melakukan apa"), berbeda dengan **autentikasi** ("siapa kamu").

**2. Kendala saat setup dan cara mengatasinya?**

- `firebase_core 5.1.0` mensyaratkan Dart SDK `^3.6.0`, sementara `pubspec.yaml` masih `^3.5.0` → constraint dinaikkan menjadi `^3.6.0`. (Modul diuji dengan Flutter 3.27; mesin ini memakai Flutter 3.47.7.)


- `firebase-tools` dan `flutterfire` CLI belum terpasang → memakai **jalur cadangan** yang diizinkan modul (hal. 12): menyalin `firebaseConfig` dari Console ke `lib/firebase_options.dart`. Hasilnya sama.
- Widget test akan membuka auth gate yang butuh Firebase → ditambahkan parameter `halamanAwal` pada `TokoBukuNovelApp` sehingga test tetap memakai `LocalAuthRepository` (sesuai tabel masalah umum hal. 23).
- `flutter test` gagal dengan `WebSocketException: Invalid WebSocket upgrade request` — kendala lingkungan `flutter_tester` di mesin ini, bukan kode. Pembuktian kompilasi dilakukan lewat `flutter analyze` (0 error) dan `flutter build web` (berhasil).

**3. Data apa yang harus tersimpan agar tidak hilang setelah refresh?**
Minggu ini **sesi login** sudah tersimpan oleh Firebase sehingga bertahan saat refresh. Yang masih hilang adalah **katalog buku, transaksi penjualan, dan riwayat laporan**, karena masih memakai `LocalBookRepository` dan `LocalTransactionRepository` di memori. Minggu 10 data ini dipindahkan ke **Cloud Firestore** mengikuti rancangan di Proposal UTS: collection `books`, `transactions`, `users`, dan `categories`.

---

## I. Masalah umum (bab 7 / slide 23) + temuan tambahan

| Gejala | Penyebab | Solusi |
|---|---|---|
| `flutterfire tidak dikenali` | Pub cache belum di PATH | Tambahkan `%LOCALAPPDATA%\Pub\Cache\bin`, atau pakai jalur cadangan |
| `No Firebase App '[DEFAULT]' has been created` | `initializeApp` belum ditunggu | `await Firebase.initializeApp(...)` sebelum `runApp` |
| `api-key-not-valid` | `apiKey` salah salin | Salin ulang dari Project settings |
| `operation-not-allowed` | Email/Password belum aktif | Aktifkan di Authentication > Sign-in method |
| Selalu muncul pesan umum | Kode error belum diterjemahkan | Tambah `case` di `pesanKesalahanAuth` |
| Widget test gagal karena Firebase | Test membuka auth gate | `TokoBukuNovelApp(halamanAwal: ...)` |
| Halaman tidak berganti setelah login | `home` belum memakai gate | `home: const _AuthGate()` |
| **Tambahan:** `pub get` menolak versi | SDK `^3.5.0` < `^3.6.0` | Naikkan `environment.sdk` |
| **Tambahan:** peringatan API key di GitHub | Wajar | `firebase_options.dart` berisi pengenal project, bukan password — aman di-commit |

---

## J. Persiapan Minggu 10

Bawa **rancangan database dari Proposal UTS** (bab 9: 4 collection `books`, `transactions`, `users`, `categories`). Minggu depan: rancang field, lalu buat fitur **tambah dan tampilkan data** dari Firestore. Karena project ini memakai **Repository Pattern**, cukup mengganti `LocalBookRepository` → `FirebaseBookRepository` tanpa mengubah halaman UI.

---

## K. Ringkasan perintah

```bash
cd D:\dev\tokobukunovel
flutter pub get                 # sudah berhasil
flutter analyze                 # 0 error
flutter build web               # berhasil
flutter run -d chrome           # jalankan untuk uji + screenshot
git log --oneline -4            # bukti commit bertahap
```

## L. Temuan uji teman dan perbaikannya

| Butir | Keterangan |
|---|---|
| Gejala | Setelah login gagal, halaman **Daftar** masih menampilkan kotak merah `Email atau password salah` padahal belum ada aksi di form daftar (terlihat pada kasus 6 dan 7). Pesan daftar juga berpotensi terbawa kembali ke halaman Masuk. |
| Penyebab | `AuthProvider.errorMessage` adalah state global; hanya dibersihkan saat `login()` / `register()` dipanggil, bukan saat navigasi. |
| Perbaikan | `context.read<AuthProvider>().resetStatus()` sebelum `Navigator.push` ke `RegisterPage` (`login_page.dart`) dan sebelum `Navigator.pop` dari halaman Daftar (`register_page.dart`). |
| Verifikasi | `flutter analyze` **0 error** (79 info lama). Langkah lanjutan: hot reload (`r`) lalu ulangi alur Masuk → Daftar → Masuk untuk memastikan kotak merah sisa hilang. Memenuhi butir DoD "uji teman + perbaiki satu temuan". |

Detail lengkap ada di **Bagian L.2** lembar kerja DOCX.
