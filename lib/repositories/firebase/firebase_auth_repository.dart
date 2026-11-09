import 'package:firebase_auth/firebase_auth.dart' as fb;

import '../../models/user.dart';
import '../../utils/auth_errors.dart';
import '../auth_repository.dart';

/// Implementasi AuthRepository memakai Firebase Authentication.
///
/// Minggu 9 — Latihan 2 & 3:
/// - createUserWithEmailAndPassword / signInWithEmailAndPassword / signOut
/// - authStateChanges() untuk menjaga sesi setelah refresh
/// - FirebaseAuthException diterjemahkan lewat pesanKesalahanAuth(e.code)
///
/// Password TIDAK pernah disimpan di aplikasi; Firebase yang mengelolanya.
class FirebaseAuthRepository implements AuthRepository {
  final fb.FirebaseAuth _auth;

  FirebaseAuthRepository({fb.FirebaseAuth? auth})
      : _auth = auth ?? fb.FirebaseAuth.instance;

  @override
  Stream<User?> get authStateChanges =>
      _auth.authStateChanges().map(_dariFirebaseUser);

  @override
  Future<User?> login(String email, String password) async {
    try {
      final kredensial = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return _dariFirebaseUser(kredensial.user);
    } on fb.FirebaseAuthException catch (e) {
      throw AuthFailure(pesanKesalahanAuth(e.code));
    }
  }

  @override
  Future<User?> register(String nama, String email, String password) async {
    try {
      final kredensial = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      // Nama disimpan sebagai displayName, bukan di tabel buatan sendiri.
      await kredensial.user?.updateDisplayName(nama.trim());
      return _dariFirebaseUser(kredensial.user, nama: nama.trim());
    } on fb.FirebaseAuthException catch (e) {
      throw AuthFailure(pesanKesalahanAuth(e.code));
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  User? get currentUser => _dariFirebaseUser(_auth.currentUser);

  User? _dariFirebaseUser(fb.User? firebaseUser, {String? nama}) {
    if (firebaseUser == null) return null;
    final email = firebaseUser.email ?? '';
    return User(
      id: firebaseUser.uid,
      nama: nama ??
          firebaseUser.displayName ??
          (email.contains('@') ? email.split('@').first : 'Pengguna'),
      email: email,
      password: '', // sengaja kosong: password dikelola Firebase
      peran: 'pegawai',
    );
  }
}
