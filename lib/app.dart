import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'providers/auth_provider.dart';
import 'theme/app_theme.dart';

class TokoBukuNovelApp extends StatelessWidget {
  const TokoBukuNovelApp({super.key, this.halamanAwal});

  /// Hanya untuk widget test: melewati auth gate sehingga test tidak
  /// membutuhkan Firebase (Modul Minggu 9, hal. 23 — "Widget test gagal").
  final Widget? halamanAwal;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Buku Novel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: halamanAwal ?? const _AuthGate(),
    );
  }
}

/// Latihan 3: halaman mengikuti status login lewat authStateChanges().
/// Kode login/daftar tidak perlu memanggil Navigator — StreamBuilder
/// otomatis mengganti halaman saat status berubah (termasuk saat Keluar).
class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: context.read<AuthProvider>().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          return const HomePage();
        }
        return const LoginPage();
      },
    );
  }
}
