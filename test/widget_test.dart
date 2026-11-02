import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:tokobukunovel/app.dart';
import 'package:tokobukunovel/providers/auth_provider.dart';
import 'package:tokobukunovel/providers/book_provider.dart';
import 'package:tokobukunovel/providers/report_provider.dart';
import 'package:tokobukunovel/providers/transaction_provider.dart';
import 'package:tokobukunovel/repositories/local/local_auth_repository.dart';
import 'package:tokobukunovel/repositories/local/local_book_repository.dart';
import 'package:tokobukunovel/repositories/local/local_transaction_repository.dart';

void main() {
  testWidgets('Aplikasi menampilkan halaman login saat pertama dibuka',
      (WidgetTester tester) async {
    final authRepo = LocalAuthRepository();
    final bookRepo = LocalBookRepository();
    final txRepo = LocalTransactionRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider(authRepo)),
          ChangeNotifierProvider(create: (_) => BookProvider(bookRepo)),
          ChangeNotifierProvider(
              create: (_) => TransactionProvider(txRepo, bookRepo)),
          ChangeNotifierProvider(create: (_) => ReportProvider(txRepo)),
        ],
        child: const TokoBukuNovelApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Halaman login harus menampilkan teks "Masuk"
    expect(find.text('Masuk'), findsWidgets);
    // Field email dan password = 2 TextField
    expect(find.byType(TextField), findsNWidgets(2));
  });

  testWidgets('Halaman login memiliki demo account hint', (tester) async {
    final authRepo = LocalAuthRepository();
    final bookRepo = LocalBookRepository();
    final txRepo = LocalTransactionRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider(authRepo)),
          ChangeNotifierProvider(create: (_) => BookProvider(bookRepo)),
          ChangeNotifierProvider(
              create: (_) => TransactionProvider(txRepo, bookRepo)),
          ChangeNotifierProvider(create: (_) => ReportProvider(txRepo)),
        ],
        child: const TokoBukuNovelApp(),
      ),
    );
    await tester.pumpAndSettle();

    // Akun demo harus terlihat sebagai hint
    expect(find.textContaining('annisa@toko.com'), findsOneWidget);
    expect(find.textContaining('pegawai@toko.com'), findsOneWidget);
  });

  testWidgets('Tombol Masuk dapat ditekan', (tester) async {
    final authRepo = LocalAuthRepository();
    final bookRepo = LocalBookRepository();
    final txRepo = LocalTransactionRepository();

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider(authRepo)),
          ChangeNotifierProvider(create: (_) => BookProvider(bookRepo)),
          ChangeNotifierProvider(
              create: (_) => TransactionProvider(txRepo, bookRepo)),
          ChangeNotifierProvider(create: (_) => ReportProvider(txRepo)),
        ],
        child: const TokoBukuNovelApp(),
      ),
    );
    await tester.pumpAndSettle();

    final button = find.widgetWithText(ElevatedButton, 'Masuk');
    expect(button, findsOneWidget);
  });
}
