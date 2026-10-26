import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../repositories/auth_repository.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;
  User? _user;
  AuthStatus _status = AuthStatus.initial;
  String _errorMessage = '';

  AuthProvider(this._authRepository);

  User? get user => _user;
  AuthStatus get status => _status;
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  bool get isPemilik => _user?.isPemilik ?? false;

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
        _errorMessage = 'Email atau kata sandi salah';
        _status = AuthStatus.error;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
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
      } else {
        _errorMessage = 'Email sudah terdaftar';
        _status = AuthStatus.error;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
      _status = AuthStatus.error;
      notifyListeners();
      return false;
    }
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
}
