import '../../models/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions({DateTime? from, DateTime? to});
  Future<Transaction?> getTransactionById(String id);
  Future<String> addTransaction(Transaction txn);
  Future<Map<String, dynamic>> getReportSummary({DateTime? from, DateTime? to});
}
