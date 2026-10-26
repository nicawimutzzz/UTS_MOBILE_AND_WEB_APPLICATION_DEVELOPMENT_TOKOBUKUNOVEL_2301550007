import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'providers/auth_provider.dart';
import 'theme/app_theme.dart';

class TokoBukuNovelApp extends StatelessWidget {
  const TokoBukuNovelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Buku Novel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const _AppGate(),
    );
  }
}

class _AppGate extends StatelessWidget {
  const _AppGate();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    if (auth.isAuthenticated) {
      return const HomePage();
    }
    return const LoginPage();
  }
}
