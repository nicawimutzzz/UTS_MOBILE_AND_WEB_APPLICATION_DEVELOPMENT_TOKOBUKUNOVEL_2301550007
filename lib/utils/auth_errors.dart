/// Menerjemahkan kode `FirebaseAuthException.code` menjadi pesan yang
/// dipahami pengguna (Modul Minggu 9, bab 6 / slide 19).
///
/// Catatan: `invalid-credential`, `wrong-password`, dan `user-not-found`
/// sengaja diberi pesan yang SAMA agar orang lain tidak bisa menebak
/// alamat email mana yang sudah terdaftar (email enumeration protection).
String pesanKesalahanAuth(String kode) {
  switch (kode) {
    case 'invalid-credential':
    case 'wrong-password':
    case 'user-not-found':
      return 'Email atau password salah';
    case 'invalid-email':
      return 'Format email belum benar';
    case 'email-already-in-use':
      return 'Email sudah terdaftar. Silakan masuk.';
    case 'weak-password':
      return 'Password terlalu lemah, minimal 6 karakter';
    case 'too-many-requests':
      return 'Terlalu banyak percobaan. Coba lagi nanti.';
    case 'network-request-failed':
      return 'Tidak dapat terhubung. Periksa koneksi internet.';
    case 'operation-not-allowed':
      return 'Login email/password belum diaktifkan';
    default:
      return 'Gagal memproses. Silakan coba lagi.';
  }
}

/// Kegagalan autentikasi yang sudah diterjemahkan.
/// Repositori melempar ini supaya UI tidak perlu mengenal Firebase secara langsung.
class AuthFailure implements Exception {
  final String pesan;
  const AuthFailure(this.pesan);

  @override
  String toString() => pesan;
}
