import '../models/book.dart';

abstract class BookService {
  Future<List<Book>> searchBooks(String query);
}