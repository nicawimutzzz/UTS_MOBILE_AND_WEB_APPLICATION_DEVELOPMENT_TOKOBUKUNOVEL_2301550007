import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'providers/auth_provider.dart';
import 'providers/book_provider.dart';
import 'providers/report_provider.dart';
import 'providers/transaction_provider.dart';
import 'repositories/local/local_auth_repository.dart';
import 'repositories/local/local_book_repository.dart';
import 'repositories/local/local_transaction_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // --- LOCAL FIRST (tanpa Firebase) ---
  // Saat user bilang "siap", ganti ini dengan FirebaseRepository
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
