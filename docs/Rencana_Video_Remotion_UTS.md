# Rencana Pembuatan Video UTS — Remotion + TTS

**Project**: Toko Buku Novel — Annisa Asti Indriyani (2301550007)
**Target**: Video presentasi UTS MAWAD, durasi 8–10 menit
**Tools**: Remotion (React video) + edge-tts (free TTS, suara Bahasa Indonesia)

---

## 1. ALASAN PILIHAN TOOLS

### Remotion (Video Generation)
- **Kenapa**: Framework React untuk membuat video secara programatik — bisa layout slide, animasi, transisi, dan render MP4
- **Gratis**: Open source, tidak butuh license untuk render (hanya butuh license untuk team/commercial, tapi untuk siswa gratis)
- **Output**: MP4 1080p atau 720p
- **Butuh**: Node.js (sudah ada v22), Chrome (sudah ada)

### edge-tts (Text-to-Speech)
- **Kenapa**: Memakai engine Microsoft Edge TTS — gratis, tidak butuh API key, kualitas tinggi
- **Voice Indonesia**: `id-ID-GadisNeural` (wanita) atau `id-ID-ArdiNeural` (pria)
- **Output**: MP3 per segmen
- **Butuh**: Python (sudah ada v3.13), install via pip

### ffmpeg (Audio Processing)
- **Kenapa**: Remotion butuh ffmpeg untuk audio sync dan render final
- **Install**: via npm `@ffmpeg-installer/ffmpeg` (otomatis terinstall bersama Remotion)

---

## 2. STRUKTUR VIDEO (8–10 MENIT)

Video dibagi menjadi **7 scene**. Setiap scene punya narasi TTS + visual (slide/screenshot/animasi).

| Scene | Durasi | Konten | Visual |
|-------|--------|--------|--------|
| 1. Pembuka | 0:00–0:45 | Identitas, judul aplikasi | Slide: judul + nama + NIM |
| 2. Masalah | 0:45–2:30 | Problem statement, pain points | Slide: ilustrasi masalah + teks |
| 3. Target & Pengguna | 2:30–4:00 | Persona, user stories | Slide: persona table + 5 user stories |
| 4. Scope & Prioritas | 4:00–5:30 | MoSCoW, kebutuhan fungsional | Slide: tabel MoSCoW + sitemap |
| 5. Rancangan | 5:30–7:00 | Wireframe Figma, database, tech stack | Slide: screenshot Figma + schema DB |
| 6. Demo Prototype | 7:00–9:00 | Demo aplikasi Flutter | Screenshot aplikasi berjalan |
| 7. Penutup | 9:00–10:00 | Rencana lanjutan, kesimpulan | Slide: roadmap + closing |

**Total narasi**: ~1.500–1.800 kata (cukup untuk 8–10 menit TTS)

---

## 3. SKRIP NARASI (BAHASA INDONESIA)

Naskah lengkap disiapkan dalam file `src/script.ts` sebagai array segmen.
Setiap segmen = { text, sceneId, duration }.

Narasi akan menjawab 4 pertanyaan wajib UTS:
1. Masalah apa yang diselesaikan? → Scene 2
2. Siapa pengguna utama? → Scene 3
3. Mengapa fitur ini diprioritaskan? → Scene 4
4. Bagaimana data disimpan? → Scene 5

---

## 4. ARSITEKTUR PROJECT REMOTION

```
D:\dev\tokobukunovel\video-uts/
├── package.json
├── remotion.config.ts
├── src/
│   ├── Root.tsx              # Composition utama (7 scene)
│   ├── script.ts             # Narasi per scene (array)
│   ├── generate-tts.ts       # Script generate audio via edge-tts
│   ├── scenes/
│   │   ├── Scene01_Pembuka.tsx
│   │   ├── Scene02_Masalah.tsx
│   │   ├── Scene03_Target.tsx
│   │   ├── Scene04_Scope.tsx
│   │   ├── Scene05_Rancangan.tsx
│   │   ├── Scene06_Demo.tsx
│   │   └── Scene07_Penutup.tsx
│   ├── components/
│   │   ├── SlideLayout.tsx   # Template slide (bg, header, footer)
│   │   ├── AnimatedText.tsx  # Teks muncul per kata/kalimat
│   │   ├── ProgressBar.tsx   # Progress bar scene
│   │   └── Theme.ts          # Warna, font, ukuran
│   └── assets/
│       ├── screenshot-beranda.png
│       ├── figma-wireframe.png
│       └── audio/             # MP3 dari edge-tts
│           ├── scene01.mp3
│           ├── scene02.mp3
│           └── ...scene07.mp3
```

---

## 5. ALUR KERJA (WORKFLOW)

### Tahap 1: Setup Project Remotion (15 menit)
1. Buat project Remotion: `npx create-video@latest video-uts --template blank`
2. Install dependency: `npm i`
3. Konfigurasi `remotion.config.ts` — set width 1920, height 1080, fps 30
4. Salin screenshot beranda ke `src/assets/`

### Tahap 2: Generate Audio TTS (10 menit)
1. Install edge-tts: `python -m pip install edge-tts`
2. Jalankan `generate-tts.ts` → untuk setiap segmen narasi, panggil edge-tts
3. Hasil: 7 file MP3 di `src/assets/audio/`
4. Catat durasi setiap MP3 untuk sinkronisasi scene

### Tahap 3: Buat Scene Components (60 menit)
1. Buat `Theme.ts` — warna #2E7D32, font Poppins-like (Inter/Roboto fallback)
2. Buat `SlideLayout.tsx` — background gradient hijau, footer dengan nama + NIM
3. Buat `AnimatedText.tsx` — teks fade-in per kalimat, sinkron dengan audio
4. Buat 7 file scene, masing-masing menampilkan:
   - Scene 1: Judul besar + identitas (fade in)
   - Scene 2: Bullet points masalah (slide in dari kiri)
   - Scene 3: Tabel persona + user stories (staggered animation)
   - Scene 4: Tabel MoSCoW (highlight per baris)
   - Scene 5: Screenshot Figma + diagram database (scale + fade)
   - Scene 6: Screenshot aplikasi (slideshow dengan zoom)
   - Scene 7: Roadmap + closing (fade out)

### Tahap 4: Audio Sync (15 menit)
1. Set durasi setiap scene berdasarkan durasi MP3
2. Gunakan `<Audio src={staticFile('audio/scene01.mp3')} />` di setiap scene
3. Sinkronkan animasi teks dengan estimasi timing audio
4. Tambahkan transisi antar scene (fade/crossfade)

### Tahap 5: Render Video (10 menit)
1. Preview di Remotion Studio: `npm run dev`
2. Render final: `npx remotion render UTSVideo out/uts-tokobukunovel.mp4`
3. Verifikasi output MP4 — cek durasi, audio, visual

### Tahap 6: Upload (5 menit)
1. Upload ke YouTube (unlisted)
2. Salin link untuk submission UTS

---

## 6. DETAIL VISUAL PER SCENE

### Scene 1 — Pembuka (0:00–0:45)
```
[Background: gradient hijau gelap #1B5E20 → #2E7D32]
[Tengah layar]
  "Toko Buku Novel" (font 72px, bold, putih, fade-in)
  "Aplikasi Kasir & Katalog Toko Buku" (font 24px, regular, putih opacity 0.8)
[Bawah]
  "Annisa Asti Indriyani — 2301550007 — Kelas A1" (font 18px)
  "MAWAD — Semester Ganjil 2026/2027" (font 16px)
```

### Scene 2 — Masalah (0:45–2:30)
```
[Background: putih dengan accent hijau]
[Header] "Masalah yang Diselesaikan" (hijau #2E7D32, 36px)
[Konten — bullet points slide-in dari kiri]
  ❌ Pencatatan transaksi masih manual dengan buku catatan
  ❌ Stok buku sulit dipantau, sering tidak terbarui
  ❌ Laporan penjualan membutuhkan waktu lama
  ❌ Data mudah hilang dan rentan kesalahan
[Highlight box]
  "Pegawai toko kesulitan melayani pembeli dengan cepat"
```

### Scene 3 — Target & Pengguna (2:30–4:00)
```
[Background: putih]
[Header] "Target Pengguna & User Stories"
[Left panel: Persona]
  👤 Pegawai Toko Buku
  - Melayani pembeli di counter
  - Butuh: catat transaksi cepat, cek stok
[Right panel: User Stories]
  Story 1: Kelola data buku (CRUD)
  Story 2: Cari buku berdasarkan judul/penulis
  Story 3: Catat transaksi + kurangi stok
  Story 4: Lihat laporan penjualan
  Story 5: Pantau stok buku
```

### Scene 4 — Scope & Prioritas (4:00–5:30)
```
[Header] "Scope: Prioritas MoSCoW"
[Tabel animasi — baris muncul satu per satu]
  Must:   Kelola buku, Transaksi, Stok, Responsif
  Should: Laporan, Login
  Could:  Pre-order, Wishlist
[Sitemap diagram]
  Login → Beranda → [Buku, Transaksi, Laporan]
  9 halaman total, Bottom Nav 4 tab
```

### Scene 5 — Rancangan (5:30–7:00)
```
[Header] "Rancangan: Wireframe & Database"
[Left: Screenshot Figma wireframe]
  7 frame mobile, 2 frame web
  Nilai: 98/100 (tertinggi sekelas)
[Right: Schema Firestore]
  books { judul, penulis, harga, stok }
  transactions { items[], total, tanggal }
  users { nama, email, peran }
  categories { nama, color }
[Bottom: Tech Stack]
  Flutter | Provider | Firebase | GitHub
```

### Scene 6 — Demo Prototype (7:00–9:00)
```
[Header] "Demo Prototype"
[Slideshow screenshot aplikasi dengan zoom effect]
  1. Login page → input email/password
  2. Beranda dashboard → ringkasan
  3. Daftar Buku → pencarian
  4. Detail Buku → info lengkap
  5. Form Tambah Buku → validasi
  6. Transaksi → keranjang + checkout
  7. Laporan → filter tanggal
[Caption per screenshot menjelaskan fitur]
```

### Scene 7 — Penutup (9:00–10:00)
```
[Background: gradient hijau]
[Header] "Rencana Lanjutan & Penutup"
[Roadmap timeline]
  Minggu 9:  Migrasi Firestore
  Minggu 10: Firebase Auth
  Minggu 11: Fitur Should (Lupa Sandi, Profil)
  Minggu 12: Optimasi responsif web
  Minggu 15: Deploy Firebase Hosting
[Closing text]
  "Terima kasih — Annisa Asti Indriyani"
  "GitHub: github.com/annisaasti/tokobukunovel"
```

---

## 7. TECHNICAL SPECIFICATIONS

| Parameter | Nilai |
|-----------|-------|
| Resolusi | 1920×1080 (Full HD) |
| FPS | 30 |
| Format output | MP4 (H.264 + AAC) |
| Voice TTS | id-ID-GadisNeural (wanita, natural) |
| Kecepatan TTS | +0% (default) |
| Font | Inter / Roboto (fallback Poppins) |
| Warna primer | #2E7D32 (hijau) |
| Warna sekunder | #1B5E20 (hijau gelap) |
| Background | #FFFFFF (putih) / #FAFAFA |
| Text dark | #212121 |
| Text light | #FFFFFF |

---

## 8. PRASYARAT & INSTALASI

### Yang sudah tersedia di mesin:
- ✅ Node.js v22.22.2
- ✅ npm v10.9.7
- ✅ Python 3.13.14
- ✅ pip 26.1.2
- ✅ Chrome (untuk Remotion render headless)

### Yang perlu di-install:
1. **edge-tts** (Python package): `python -m pip install edge-tts`
2. **Remotion project**: `npx create-video@latest`
3. **Screenshot aplikasi**: Ambil screenshot Flutter web di Chrome (7 halaman)

### Screenshot yang perlu diambil dari Flutter web:
1. Halaman Login
2. Halaman Beranda (sudah ada: `docs/screenshot-beranda.png`)
3. Halaman Daftar Buku
4. Halaman Detail Buku
5. Halaman Form Tambah Buku
6. Halaman Transaksi
7. Halaman Laporan

---

## 9. RISIKO & MITIGASI

| Risiko | Mitigasi |
|--------|----------|
| edge-tts tidak bisa install | Gunakan StreamElements TTS API (gratis, tidak butuh key) |
| Remotion render lambat | Render di 720p dulu untuk test, baru 1080p untuk final |
| Audio TTS terdengar robotik | Pilih voice Neural (bukan Standard), atur rate +0% |
| Screenshot aplikasi tidak available | Jalankan `flutter run -d chrome`, ambil screenshot manual |
| Durasi video >10 menit | Potong narasi, fokus pada poin penting |
| Chrome headless crash | Pastikan tidak ada Chrome instance lain running |

---

## 10. ESTIMASI WAKTU

| Tahap | Estimasi |
|-------|----------|
| Setup project Remotion | 15 menit |
| Install edge-tts + generate audio | 10 menit |
| Buat 7 scene components | 60 menit |
| Audio sync + transisi | 15 menit |
| Preview + revisi | 10 menit |
| Render final MP4 | 10 menit |
| **Total** | **~120 menit (2 jam)** |

---

## 11. OUTPUT YANG DIHASILKAN

1. **Video MP4** (`out/uts-tokobukunovel.mp4`) — 1080p, 8–10 menit
2. **Project Remotion** (`video-uts/`) — bisa di-edit untuk revisi
3. **Audio TTS** (`src/assets/audio/`) — 7 file MP3 Bahasa Indonesia
4. **Screenshot aplikasi** (`src/assets/`) — 7 screenshot Flutter web

---

## STATUS: RENCANA SELESAI — SIAP DIIMPLEMENTASI

> Ketika Annisa siap, ketik "lanjut implementasi" dan saya akan mulai:
> 1. Buat project Remotion
> 2. Install edge-tts
> 3. Generate audio
> 4. Buat semua scene
> 5. Render video MP4
