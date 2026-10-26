# Toko Buku Novel — Flutter App

Aplikasi Toko Buku Novel untuk mata kuliah Mobile and Web Application Development.

## Status: Fase 1 (Local-first, tanpa Firebase)

### Akun Demo
- **Pemilik**: annisa@toko.com / 123456
- **Pegawai**: pegawai@toko.com / 123456

### Cara Menjalankan
```bash
flutter pub get
flutter run
```

### Struktur
```
lib/
├── main.dart              # Entry point + dependency injection
├── app.dart               # MaterialApp + auth gate
├── models/                # Book, Transaction, User, Category
├── repositories/           # Interface + implementasi
│   ├── local/             # LocalRepository (sekarang)
│   └── firebase/          # FirebaseRepository (nanti)
├── providers/             # State management (ChangeNotifier)
├── pages/                 # UI halaman
├── widgets/               # Komponen reusable
├── theme/                 # Colors, text styles, button styles
└── utils/                 # Format, validators
```

### Migrasi Firebase
1. Uncomment dependencies Firebase di pubspec.yaml
2. Isi `repositories/firebase/` dengan implementasi
3. Ganti injection di main.dart: Local*Repository → Firebase*Repository
4. UI, Provider, dan Model tidak berubah
