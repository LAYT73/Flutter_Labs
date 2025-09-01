import '../dto/book_dto.dart';

abstract class BookService {
  Future<List<BookDto>> searchBooks(String query);
}