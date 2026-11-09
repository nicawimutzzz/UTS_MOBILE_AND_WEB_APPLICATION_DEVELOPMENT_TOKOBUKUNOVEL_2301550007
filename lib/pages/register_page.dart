import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_text_styles.dart';
import '../utils/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _namaController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;
    final success = await context.read<AuthProvider>().register(
      _namaController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );
    if (success && mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Text('Buat akun baru', style: AppTextStyles.h2, textAlign: TextAlign.center),
                const SizedBox(height: 8),
                Text(
                  'Daftar sebagai pegawai toko',
                  style: AppTextStyles.bodySecondary,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) => validateRequired(v, 'Nama'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: validateEmail,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Kata Sandi',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: validatePassword,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _confirmController,
                  obscureText: _obscurePassword,
                  decoration: const InputDecoration(
                    labelText: 'Konfirmasi Kata Sandi',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  // Minggu 9, tabel 6: wajib diisi dan harus sama dengan password
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Ulangi password';
                    if (v != _passwordController.text) return 'Password tidak sama';
                    return null;
                  },
                ),
                if (auth.errorMessage.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.errorBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(auth.errorMessage, style: TextStyle(color: AppColors.error, fontSize: 13)),
                  ),
                ],
                const SizedBox(height: 24),
                // Tombol dinonaktifkan selama proses (Latihan 2)
                ElevatedButton(
                  style: AppButtonStyles.primary,
                  onPressed: auth.status == AuthStatus.loading
                      ? null
                      : _handleRegister,
                  child: auth.status == AuthStatus.loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Daftar'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Sudah punya akun? Masuk',
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
