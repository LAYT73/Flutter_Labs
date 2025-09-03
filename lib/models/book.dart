// models/book.dart
class Book {
  final String title;
  final List<String> authors;
  final String? coverUrl; // уже готовый URL, удобно для UI

  Book({
    required this.title,
    required this.authors,
    this.coverUrl,
  });

  // Опционально: копирование с изменением полей
  Book copyWith({
    String? title,
    List<String>? authors,
    String? coverUrl,
  }) {
    return Book(
      title: title ?? this.title,
      authors: authors ?? this.authors,
      coverUrl: coverUrl ?? this.coverUrl,
    );
  }
}