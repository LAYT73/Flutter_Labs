import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import '../../repositories/book_repository.dart';
import 'book_search_event.dart';
import 'book_search_state.dart';

class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  final BookRepository repository;

  BookSearchBloc(this.repository) : super(BookSearchInitial()) {
    // Обработка поиска с debounce
    on<SearchBooks>(
      _handleSearch,
      transformer: (events, transitionFn) =>
          events.debounceTime(const Duration(milliseconds: 500)).switchMap(transitionFn),
    );

    // Обработка обновления
    on<RefreshBooks>((event, emit) async {
      final query = event.currentQuery.trim();
      if (query.isEmpty) return;

      emit(BookSearchLoading());
      try {
        final books = await repository.searchBooks(query);
        emit(BookSearchSuccess(books));
      } on Exception catch (e) {
        emit(BookSearchError(e.toString()));
      }
    });
  }

  Future<void> _handleSearch(SearchBooks event, Emitter<BookSearchState> emit) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(BookSearchSuccess([]));
      return;
    }

    emit(BookSearchLoading());
    try {
      final books = await repository.searchBooks(query);
      emit(BookSearchSuccess(books));
    } on Exception catch (e) {
      emit(BookSearchError(e.toString()));
    }
  }
}