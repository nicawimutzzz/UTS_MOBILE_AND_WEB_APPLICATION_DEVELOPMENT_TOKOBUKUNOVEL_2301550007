import '../../models/transaction.dart';
import '../transaction_repository.dart';
import 'mock_data.dart';

/// Implementasi lokal TransactionRepository — data di memori.
class LocalTransactionRepository implements TransactionRepository {
  final List<Transaction> _transactions = List.from(mockTransactions);
  int _counter = 5;

  @override
  Future<List<Transaction>> getTransactions({DateTime? from, DateTime? to}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var result = _transactions.toList();

    if (from != null) {
      result = result.where((t) => t.tanggal.isAfter(from.subtract(const Duration(days: 1)))).toList();
    }
    if (to != null) {
      result = result.where((t) => t.tanggal.isBefore(to.add(const Duration(days: 1)))).toList();
    }

    result.sort((a, b) => b.tanggal.compareTo(a.tanggal));
    return result;
  }

  @override
  Future<Transaction?> getTransactionById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _transactions.where((t) => t.id == id).firstOrNull;
  }

  @override
  Future<String> addTransaction(Transaction txn) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _counter++;
    final id = 'TRX${_counter.toString().padLeft(3, '0')}';
    final newTxn = Transaction(
      id: id,
      items: txn.items,
      total: txn.total,
      tanggal: DateTime.now(),
      status: 'selesai',
      userId: txn.userId,
    );
    _transactions.add(newTxn);
    return id;
  }

  @override
  Future<Map<String, dynamic>> getReportSummary({DateTime? from, DateTime? to}) async {
    final transactions = await getTransactions(from: from, to: to);
    final totalPendapatan = transactions.fold<int>(0, (sum, t) => sum + t.total);
    final jumlahTransaksi = transactions.length;
    final totalBukuTerjual = transactions.fold<int>(
      0, (sum, t) => sum + t.items.fold(0, (s, i) => s + i.qty));

    return {
      'totalPendapatan': totalPendapatan,
      'jumlahTransaksi': jumlahTransaksi,
      'totalBukuTerjual': totalBukuTerjual,
      'transactions': transactions,
    };
  }
}
