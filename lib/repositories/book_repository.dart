import '../../models/book.dart';

abstract class BookRepository {
  Future<List<Book>> getBooks({String? search, String? kategori});
  Future<Book?> getBookById(String id);
  Future<void> addBook(Book book);
  Future<void> updateBook(Book book);
  Future<void> deleteBook(String id);
  Future<List<Book>> getLowStockBooks({int threshold = 5});
  Future<void> decreaseStock(String bookId, int qty);
}
