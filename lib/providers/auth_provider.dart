import 'dart:async';

import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';
import '../utils/auth_errors.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  StreamSubscription<User?>? _langganan;
  bool _ditutup = false;

  User? _user;
  AuthStatus _status = AuthStatus.initial;
  String _errorMessage = '';

  AuthProvider(this._authRepository) {
    // Minggu 9: dengarkan perubahan status login.
    // Firebase mengirim user yang masih aktif saat aplikasi dibuka ulang,
    // sehingga sesi bertahan setelah browser di-refresh.
    _langganan = _authRepository.authStateChanges.listen((user) {
      _user = user;
      if (_status != AuthStatus.loading && _status != AuthStatus.error) {
        _status = user != null
            ? AuthStatus.authenticated
            : AuthStatus.unauthenticated;
      }
      _notifyAman();
    });
  }

  User? get user => _user;
  AuthStatus get status => _status;
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  bool get isPemilik => _user?.isPemilik ?? false;

  /// Dipakai StreamBuilder pada app.dart (Latihan 3).
  Stream<User?> get authStateChanges => _authRepository.authStateChanges;

  Future<void> login(String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      final user = await _authRepository.login(email, password);
      if (user != null) {
        _user = user;
        _status = AuthStatus.authenticated;
      } else {
        _errorMessage = 'Email atau password salah';
        _status = AuthStatus.error;
      }
    } on AuthFailure catch (e) {
      _errorMessage = e.pesan;
      _status = AuthStatus.error;
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
      _status = AuthStatus.error;
    }
    notifyListeners();
  }

  Future<bool> register(String nama, String email, String password) async {
    _status = AuthStatus.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      final user = await _authRepository.register(nama, email, password);
      if (user != null) {
        _user = user;
        _status = AuthStatus.authenticated;
        notifyListeners();
        return true;
      }
      _errorMessage = 'Email sudah terdaftar. Silakan masuk.';
      _status = AuthStatus.error;
    } on AuthFailure catch (e) {
      _errorMessage = e.pesan;
      _status = AuthStatus.error;
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan. Silakan coba lagi.';
      _status = AuthStatus.error;
    }
    notifyListeners();
    return false;
  }

  Future<void> logout() async {
    await _authRepository.logout();
    _user = null;
    _status = AuthStatus.unauthenticated;
    _errorMessage = '';
    notifyListeners();
  }

  void resetStatus() {
    _status = AuthStatus.initial;
    _errorMessage = '';
    notifyListeners();
  }

  void _notifyAman() {
    Future.microtask(() {
      if (!_ditutup) notifyListeners();
    });
  }

  @override
  void dispose() {
    _ditutup = true;
    _langganan?.cancel();
    super.dispose();
  }
}
