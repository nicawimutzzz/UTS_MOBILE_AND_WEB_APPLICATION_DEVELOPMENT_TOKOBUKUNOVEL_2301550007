import '../../models/book.dart';
import '../book_repository.dart';
import 'mock_data.dart';

/// Implementasi lokal BookRepository — data di memori.
/// Saat migrasi Firebase, ganti dengan FirebaseBookRepository.
class LocalBookRepository implements BookRepository {
  final List<Book> _books = List.from(mockBooks);

  @override
  Future<List<Book>> getBooks({String? search, String? kategori}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    var result = _books.toList();

    if (kategori != null && kategori.isNotEmpty && kategori != 'Semua') {
      result = result.where((b) => b.kategori == kategori).toList();
    }

    if (search != null && search.isNotEmpty) {
      final q = search.toLowerCase();
      result = result
          .where((b) =>
              b.judul.toLowerCase().contains(q) ||
              b.penulis.toLowerCase().contains(q))
          .toList();
    }

    return result;
  }

  @override
  Future<Book?> getBookById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _books.where((b) => b.id == id).firstOrNull;
  }

  @override
  Future<void> addBook(Book book) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _books.add(book);
  }

  @override
  Future<void> updateBook(Book book) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final idx = _books.indexWhere((b) => b.id == book.id);
    if (idx >= 0) {
      _books[idx] = book;
    }
  }

  @override
  Future<void> deleteBook(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _books.removeWhere((b) => b.id == id);
  }

  @override
  Future<List<Book>> getLowStockBooks({int threshold = 5}) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _books.where((b) => b.stok < threshold).toList();
  }

  @override
  Future<void> decreaseStock(String bookId, int qty) async {
    final idx = _books.indexWhere((b) => b.id == bookId);
    if (idx >= 0) {
      final book = _books[idx];
      _books[idx] = book.copyWith(stok: book.stok - qty);
    }
  }

  /// Generate ID berikutnya
  String generateNextId() {
    if (_books.isEmpty) return 'B001';
    final lastId = _books.last.id;
    final num = int.tryParse(lastId.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return 'B${(num + 1).toString().padLeft(3, '0')}';
  }
}
