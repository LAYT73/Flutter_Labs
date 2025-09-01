class BookSearchEvent {}

class SearchBooks extends BookSearchEvent {
  final String query;

  SearchBooks(this.query);
}

class RefreshBooks extends BookSearchEvent {
  final String currentQuery;

  RefreshBooks(this.currentQuery);
}