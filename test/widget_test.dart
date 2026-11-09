import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tokobukunovel/app.dart';
import 'package:tokobukunovel/pages/login_page.dart';
import 'package:tokobukunovel/providers/auth_provider.dart';
import 'package:tokobukunovel/providers/book_provider.dart';
import 'package:tokobukunovel/providers/report_provider.dart';
import 'package:tokobukunovel/providers/transaction_provider.dart';
import 'package:tokobukunovel/repositories/local/local_auth_repository.dart';
import 'package:tokobukunovel/repositories/local/local_book_repository.dart';
import 'package:tokobukunovel/repositories/local/local_transaction_repository.dart';
import 'package:tokobukunovel/utils/auth_errors.dart';

/// Minggu 9, hal. 23: test memakai `halamanAwal` supaya tidak membuka
/// auth gate yang bergantung pada Firebase.initializeApp().
Widget _bangunAplikasi() {
  final authRepo = LocalAuthRepository();
  final bookRepo = LocalBookRepository();
  final txRepo = LocalTransactionRepository();

  return MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider(authRepo)),
      ChangeNotifierProvider(create: (_) => BookProvider(bookRepo)),
      ChangeNotifierProvider(
          create: (_) => TransactionProvider(txRepo, bookRepo)),
      ChangeNotifierProvider(create: (_) => ReportProvider(txRepo)),
    ],
    child: const TokoBukuNovelApp(halamanAwal: LoginPage()),
  );
}

void main() {
  testWidgets('Halaman login menampilkan form email dan password',
      (WidgetTester tester) async {
    await tester.pumpWidget(_bangunAplikasi());
    await tester.pumpAndSettle();

    expect(find.text('Masuk'), findsWidgets);
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('Halaman login memuat petunjuk akun simulasi', (tester) async {
    await tester.pumpWidget(_bangunAplikasi());
    await tester.pumpAndSettle();

    expect(find.text('Akun simulasi'), findsOneWidget);
    expect(find.textContaining('password simulasi'), findsOneWidget);
  });

  testWidgets('Tombol Masuk tersedia dan aktif', (tester) async {
    await tester.pumpWidget(_bangunAplikasi());
    await tester.pumpAndSettle();

    final tombol = find.widgetWithText(ElevatedButton, 'Masuk');
    expect(tombol, findsOneWidget);
    expect(tester.widget<ElevatedButton>(tombol).onPressed, isNotNull);
  });

  // Latihan 4: pesan kesalahan tidak boleh membocorkan email terdaftar.
  group('pesanKesalahanAuth', () {
    test('email tak dikenal dan password salah diberi pesan sama', () {
      expect(pesanKesalahanAuth('user-not-found'), 'Email atau password salah');
      expect(pesanKesalahanAuth('wrong-password'), 'Email atau password salah');
      expect(
          pesanKesalahanAuth('invalid-credential'), 'Email atau password salah');
    });

    test('kode utama modul diterjemahkan dengan benar', () {
      expect(pesanKesalahanAuth('invalid-email'), 'Format email belum benar');
      expect(pesanKesalahanAuth('email-already-in-use'),
          'Email sudah terdaftar. Silakan masuk.');
      expect(pesanKesalahanAuth('weak-password'),
          'Password terlalu lemah, minimal 6 karakter');
      expect(pesanKesalahanAuth('network-request-failed'),
          'Tidak dapat terhubung. Periksa koneksi internet.');
      expect(pesanKesalahanAuth('operation-not-allowed'),
          'Login email/password belum diaktifkan');
    });
  });
}
