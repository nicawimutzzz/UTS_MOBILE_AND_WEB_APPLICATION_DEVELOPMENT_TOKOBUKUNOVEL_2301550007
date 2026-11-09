import 'dart:async';

import '../../models/user.dart';
import '../auth_repository.dart';
import 'mock_data.dart';

/// Implementasi lokal AuthRepository — data di memori.
/// Dipertahankan untuk widget test (tanpa Firebase) dan sebagai fallback.
class LocalAuthRepository implements AuthRepository {
  final List<User> _users = List.from(mockUsers);
  final StreamController<User?> _perubahan = StreamController<User?>.broadcast();
  User? _currentUser;

  @override
  Future<User?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final user = _users.where(
      (u) => u.email == email && u.password == password,
    ).firstOrNull;

    if (user != null) {
      _currentUser = user;
      _perubahan.add(user);
      return user;
    }
    return null;
  }

  @override
  Future<User?> register(String nama, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // Cek email sudah dipakai
    final exists = _users.any((u) => u.email == email);
    if (exists) return null;

    final id = 'U${(_users.length + 1).toString().padLeft(3, '0')}';
    final user = User(
      id: id,
      nama: nama,
      email: email,
      password: password,
      peran: 'pegawai',
    );
    _users.add(user);
    _currentUser = user;
    _perubahan.add(user);
    return user;
  }

  @override
  Future<void> logout() async {
    _currentUser = null;
    _perubahan.add(null);
  }

  @override
  User? get currentUser => _currentUser;

  @override
  Stream<User?> get authStateChanges async* {
    yield _currentUser;
    yield* _perubahan.stream;
  }
}
