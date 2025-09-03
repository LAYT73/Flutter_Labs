import '../dto/book_dto.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class BookRepository {
  final BookService bookService;

  BookRepository(this.bookService);

  Future<List<Book>> searchBooks(String query) async {
    return await bookService.searchBooks(query);
  }
}