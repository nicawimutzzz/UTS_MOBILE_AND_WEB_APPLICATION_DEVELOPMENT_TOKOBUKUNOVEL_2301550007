import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';
import 'providers/book_provider.dart';
import 'providers/report_provider.dart';
import 'providers/transaction_provider.dart';
import 'repositories/local/local_auth_repository.dart';
import 'repositories/local/local_book_repository.dart';
import 'repositories/local/local_transaction_repository.dart';

/// Minggu 9: main menjadi async, Firebase diinisialisasi SEBELUM runApp.
/// Urutan wajib: ensureInitialized() -> await initializeApp() -> runApp().
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Katalog, transaksi, dan laporan masih local (Firestore masuk Minggu 10).
  final authRepository = LocalAuthRepository();
  final bookRepository = LocalBookRepository();
  final transactionRepository = LocalTransactionRepository();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(authRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => BookProvider(bookRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => TransactionProvider(transactionRepository, bookRepository),
        ),
        ChangeNotifierProvider(
          create: (_) => ReportProvider(transactionRepository),
        ),
      ],
      child: const TokoBukuNovelApp(),
    ),
  );
}
