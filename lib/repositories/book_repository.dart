import '../dto/book_dto.dart';
import '../services/book_service.dart';

class BookRepository {
  final BookService bookService;

  BookRepository(this.bookService);

  Future<List<BookDto>> searchBooks(String query) async {
    return await bookService.searchBooks(query);
  }
}