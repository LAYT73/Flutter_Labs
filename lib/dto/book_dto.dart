class BookDto {
  final String title;
  final List<String> authors;
  final String? coverId;

  BookDto({
    required this.title,
    required this.authors,
    this.coverId,
  });

  factory BookDto.fromJson(Map<String, dynamic> json) {
    final List<dynamic> authorDocs = json['author_name'] ?? [];
    final List<String> authors = authorDocs.cast<String>();

    return BookDto(
      title: json['title'] ?? 'Без названия',
      authors: authors,
      coverId: json['cover_i']?.toString(),
    );
  }

  String get coverUrl {
    if (coverId == null) return 'https://via.placeholder.com/100x150';
    return 'https://covers.openlibrary.org/b/id/$coverId-M.jpg';
  }
}