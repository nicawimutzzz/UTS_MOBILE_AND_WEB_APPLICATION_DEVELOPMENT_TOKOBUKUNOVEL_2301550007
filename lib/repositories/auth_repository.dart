import '../../models/user.dart';

/// Kontrak autentikasi. Dua implementasi:
/// - LocalAuthRepository  : data di memori (dipakai widget test)
/// - FirebaseAuthRepository: Firebase Authentication (dipakai aplikasi)
///
/// `authStateChanges` ditambahkan pada Minggu 9 agar halaman dapat mengikuti
/// status login dan sesi tetap bertahan setelah browser di-refresh.
abstract class AuthRepository {
  Future<User?> login(String email, String password);
  Future<User?> register(String nama, String email, String password);
  Future<void> logout();
  User? get currentUser;
  Stream<User?> get authStateChanges;
}
