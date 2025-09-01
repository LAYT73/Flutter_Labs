import '../../dto/book_dto.dart';

abstract class BookSearchState {}

class BookSearchInitial extends BookSearchState {}

class BookSearchLoading extends BookSearchState {}

class BookSearchSuccess extends BookSearchState {
  final List<BookDto> books;

  BookSearchSuccess(this.books);
}

class BookSearchError extends BookSearchState {
  final String message;

  BookSearchError(this.message);
}