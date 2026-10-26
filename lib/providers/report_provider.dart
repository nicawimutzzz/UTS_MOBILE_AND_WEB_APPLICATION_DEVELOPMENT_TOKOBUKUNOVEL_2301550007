import 'package:flutter/foundation.dart';
import '../models/transaction.dart';
import '../repositories/transaction_repository.dart';

class ReportProvider extends ChangeNotifier {
  final TransactionRepository _transactionRepository;

  List<Transaction> _transactions = [];
  int _totalPendapatan = 0;
  int _jumlahTransaksi = 0;
  int _totalBukuTerjual = 0;
  bool _isLoading = false;
  String _errorMessage = '';
  DateTime? _fromDate;
  DateTime? _toDate;

  ReportProvider(this._transactionRepository);

  List<Transaction> get transactions => _transactions;
  int get totalPendapatan => _totalPendapatan;
  int get jumlahTransaksi => _jumlahTransaksi;
  int get totalBukuTerjual => _totalBukuTerjual;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;

  Future<void> loadReport({DateTime? from, DateTime? to}) async {
    _isLoading = true;
    _fromDate = from;
    _toDate = to;
    _errorMessage = '';
    notifyListeners();

    try {
      final summary = await _transactionRepository.getReportSummary(from: from, to: to);
      _totalPendapatan = summary['totalPendapatan'] as int;
      _jumlahTransaksi = summary['jumlahTransaksi'] as int;
      _totalBukuTerjual = summary['totalBukuTerjual'] as int;
      _transactions = summary['transactions'] as List<Transaction>;
    } catch (e) {
      _errorMessage = 'Gagal memuat laporan: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  void setDateRange(DateTime? from, DateTime? to) {
    loadReport(from: from, to: to);
  }
}
