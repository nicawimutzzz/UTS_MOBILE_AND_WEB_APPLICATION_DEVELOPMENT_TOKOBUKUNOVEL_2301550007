// TODO: Implementasi Firebase — aktifkan saat user bilang "siap"
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../../models/book.dart';
// import '../book_repository.dart';
//
// class FirebaseBookRepository implements BookRepository {
//   final _db = FirebaseFirestore.instance;
//   final _collection = 'books';
//
//   @override
//   Future<List<Book>> getBooks({String? search, String? kategori}) async {
//     QuerySnapshot snapshot = await _db.collection(_collection).get();
//     // ... implementasi
//   }
//   // ... implementasi method lainnya
// }
//
// Saat ini masih menggunakan LocalBookRepository.
