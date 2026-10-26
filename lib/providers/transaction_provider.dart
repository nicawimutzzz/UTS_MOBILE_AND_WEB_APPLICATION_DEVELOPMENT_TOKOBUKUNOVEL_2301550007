import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../models/transaction.dart';
import '../models/transaction_item.dart';
import '../models/user.dart';
import '../repositories/book_repository.dart';
import '../repositories/transaction_repository.dart';
import '../repositories/local/mock_data.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository _transactionRepository;
  final BookRepository _bookRepository;

  final List<TransactionItem> _cart = [];
  List<Transaction> _history = [];
  Transaction? _lastTransaction;
  bool _isLoading = false;
  String _errorMessage = '';

  TransactionProvider(this._transactionRepository, this._bookRepository);

  List<TransactionItem> get cart => _cart;
  List<Transaction> get history => _history;
  Transaction? get lastTransaction => _lastTransaction;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  int get cartCount => _cart.fold(0, (sum, item) => sum + item.qty);
  int get cartTotal => _cart.fold(0, (sum, item) => sum + item.subtotal);
  bool get isCartEmpty => _cart.isEmpty;

  void addToCart(Book book, int qty) {
    final existing = _cart.indexWhere((item) => item.bookId == book.id);
    if (existing >= 0) {
      final item = _cart[existing];
      _cart[existing] = TransactionItem(
        bookId: item.bookId,
        judul: item.judul,
        qty: item.qty + qty,
        harga: item.harga,
      );
    } else {
      _cart.add(TransactionItem(
        bookId: book.id,
        judul: book.judul,
        qty: qty,
        harga: book.harga,
      ));
    }
    notifyListeners();
  }

  void updateCartQty(String bookId, int qty) {
    if (qty <= 0) {
      removeFromCart(bookId);
      return;
    }
    final idx = _cart.indexWhere((item) => item.bookId == bookId);
    if (idx >= 0) {
      final item = _cart[idx];
      _cart[idx] = TransactionItem(
        bookId: item.bookId,
        judul: item.judul,
        qty: qty,
        harga: item.harga,
      );
      notifyListeners();
    }
  }

  void removeFromCart(String bookId) {
    _cart.removeWhere((item) => item.bookId == bookId);
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  /// Validasi stok: return null jika OK, pesan error jika stok tidak cukup
  String? validateCart() {
    for (final item in _cart) {
      // Cari buku di mock data (sync, karena data lokal ada di memori)
      final book = _findBookSync(item.bookId);
      if (book == null) {
        return 'Buku "${item.judul}" tidak ditemukan';
      }
      if (book.stok < item.qty) {
        return 'Stok "${item.judul}" tidak mencukupi (tersisa ${book.stok})';
      }
    }
    return null;
  }

  Book? _findBookSync(String id) {
    // Data lokal ada di mock_data — cari di sana untuk validasi cepat
    for (final b in mockBooks) {
      if (b.id == id) return b;
    }
    return null;
  }

  Future<bool> checkout(User user) async {
    final validationError = validateCart();
    if (validationError != null) {
      _errorMessage = validationError;
      notifyListeners();
      return false;
    }

    if (_cart.isEmpty) {
      _errorMessage = 'Keranjang masih kosong';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      final total = cartTotal;
      final txn = Transaction(
        id: '',
        items: List.from(_cart),
        total: total,
        tanggal: DateTime.now(),
        status: 'selesai',
        userId: user.id,
      );

      final txnId = await _transactionRepository.addTransaction(txn);

      // Kurangi stok buku
      for (final item in _cart) {
        await _bookRepository.decreaseStock(item.bookId, item.qty);
      }

      _lastTransaction = Transaction(
        id: txnId,
        items: List.from(_cart),
        total: total,
        tanggal: DateTime.now(),
        status: 'selesai',
        userId: user.id,
      );

      _cart.clear();
      await loadHistory();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal menyimpan transaksi: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> loadHistory() async {
    _isLoading = true;
    notifyListeners();
    _history = await _transactionRepository.getTransactions();
    _isLoading = false;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }
}
