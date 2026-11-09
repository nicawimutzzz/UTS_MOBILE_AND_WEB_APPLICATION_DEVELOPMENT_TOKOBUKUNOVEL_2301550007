import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_text_styles.dart';
import '../utils/validators.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // Minggu 9: tidak ada lagi kredensial bawaan. Gunakan akun simulasi
  // yang dibuat lewat Firebase Authentication (jangan pakai password asli).
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    await context.read<AuthProvider>().login(
      _emailController.text.trim(),
      _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - 48,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo / Title
                Icon(Icons.book, size: 64, color: AppColors.primary),
                const SizedBox(height: 16),
                Text(
                  'Toko Buku Novel',
                  style: AppTextStyles.h1.copyWith(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Buku baru, cerita baru!',
                  style: AppTextStyles.bodySecondary,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
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
                            icon: Icon(_obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                        ),
                        validator: (v) => validatePassword(v),
                      ),
                      const SizedBox(height: 8),
                      // Error message
                      if (auth.errorMessage.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: AppColors.errorBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline, color: AppColors.error, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  auth.errorMessage,
                                  style: TextStyle(color: AppColors.error, fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Lupa kata sandi
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Fitur lupa kata sandi akan tersedia di Fase 2'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          child: Text(
                            'Lupa kata sandi?',
                            style: TextStyle(color: AppColors.primary, fontSize: 13),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Tombol Masuk: DINONAKTIFKAN selama proses (Latihan 2)
                      ElevatedButton(
                        style: AppButtonStyles.primary,
                        onPressed: auth.status == AuthStatus.loading
                            ? null
                            : _handleLogin,
                        child: auth.status == AuthStatus.loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Masuk'),
                      ),
                      const SizedBox(height: 16),
                      // Tautan Daftar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Belum punya akun? ', style: AppTextStyles.bodySecondary),
                          TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RegisterPage()),
                          );
                        },
                        child: Text(
                          'Daftar',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Hint
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBg,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Akun simulasi',
                              style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Gunakan email & password simulasi, bukan password asli.',
                              style: AppTextStyles.caption,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Belum punya akun? Tekan Daftar.',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
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
