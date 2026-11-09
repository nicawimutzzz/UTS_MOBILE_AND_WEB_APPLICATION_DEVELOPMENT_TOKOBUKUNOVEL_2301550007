import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

/// Konfigurasi project Firebase "toko-buku-novel".
///
/// Dibuat dengan JALUR CADANGAN (Modul Minggu 9, hal. 12): nilai disalin dari
/// Project settings > Your apps > firebaseConfig, karena FlutterFire CLI belum
/// terpasang. Hasilnya identik dengan `flutterfire configure --platforms=web`.
///
/// CATATAN KEAMANAN: file ini berisi PENGENAL project, bukan password.
/// Aman untuk di-commit ke repository (Modul Minggu 9, hal. 13).
/// Jangan pernah menaruh password akun atau service account key di sini.
class DefaultFirebaseOptions {
  const DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform => web;

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBoBjC0HTpmTnp5SRlnXPIeoT_AJ_IK4TI',
    authDomain: 'toko-buku-novel.firebaseapp.com',
    projectId: 'toko-buku-novel',
    storageBucket: 'toko-buku-novel.firebasestorage.app',
    messagingSenderId: '148523253396',
    appId: '1:148523253396:web:0ec1995d0ed3fd1ba4be81',
    measurementId: 'G-CSW550ZXT3',
  );
}
