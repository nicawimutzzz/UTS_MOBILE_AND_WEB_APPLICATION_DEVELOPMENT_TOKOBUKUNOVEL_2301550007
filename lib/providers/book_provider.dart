import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../repositories/book_repository.dart';
import '../repositories/local/local_book_repository.dart';
import '../repositories/local/mock_data.dart';

class BookProvider extends ChangeNotifier {
  final BookRepository _bookRepository;
  List<Book> _books = [];
  List<Book> _filteredBooks = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedKategori = 'Semua';
  String _errorMessage = '';

  BookProvider(this._bookRepository);

  List<Book> get books => _filteredBooks;
  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String get selectedKategori => _selectedKategori;
  String get errorMessage => _errorMessage;
  List<String> get categories => ['Semua', ...mockCategories];

  Future<void> loadBooks() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _books = await _bookRepository.getBooks();
      _applyFilters();
    } catch (e) {
      _errorMessage = 'Gagal memuat buku: $e';
    }
    _isLoading = false;
    notifyListeners();
  }

  void setSearch(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void setKategori(String kategori) {
    _selectedKategori = kategori;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredBooks = _books.where((book) {
      final matchKategori =
          _selectedKategori == 'Semua' || book.kategori == _selectedKategori;
      final matchSearch = _searchQuery.isEmpty ||
          book.judul.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          book.penulis.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchKategori && matchSearch;
    }).toList();
  }

  Future<Book?> getBookById(String id) async {
    return _bookRepository.getBookById(id);
  }

  Future<bool> addBook(Book book) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _bookRepository.addBook(book);
      await loadBooks();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal menambah buku: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateBook(Book book) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _bookRepository.updateBook(book);
      await loadBooks();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal mengubah buku: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteBook(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _bookRepository.deleteBook(id);
      await loadBooks();
      return true;
    } catch (e) {
      _errorMessage = 'Gagal menghapus buku: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<List<Book>> getLowStockBooks() async {
    return _bookRepository.getLowStockBooks();
  }

  Future<void> decreaseStock(String bookId, int qty) async {
    await _bookRepository.decreaseStock(bookId, qty);
    await loadBooks();
  }

  String generateNextId() {
    if (_bookRepository is LocalBookRepository) {
      return _bookRepository.generateNextId();
    }
    return 'B${DateTime.now().millisecondsSinceEpoch}';
  }
}
