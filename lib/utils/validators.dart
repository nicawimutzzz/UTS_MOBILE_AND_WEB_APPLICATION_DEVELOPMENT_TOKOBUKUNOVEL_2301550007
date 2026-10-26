/// Validasi email sederhana
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email tidak boleh kosong';
  }
  if (!value.contains('@') || !value.contains('.')) {
    return 'Format email tidak valid';
  }
  return null;
}

/// Validasi kata sandi
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Kata sandi tidak boleh kosong';
  }
  if (value.length < 6) {
    return 'Kata sandi minimal 6 karakter';
  }
  return null;
}

/// Validasi field wajib
String? validateRequired(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return '$fieldName tidak boleh kosong';
  }
  return null;
}

/// Validasi angka positif
String? validatePositiveInt(String? value, String fieldName) {
  if (value == null || value.isEmpty) {
    return '$fieldName tidak boleh kosong';
  }
  final n = int.tryParse(value);
  if (n == null || n < 0) {
    return '$fieldName harus angka positif';
  }
  return null;
}
