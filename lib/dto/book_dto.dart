import 'package:json_annotation/json_annotation.dart';

import '../models/book.dart';

part 'book_dto.g.dart';

@JsonSerializable()
class BookDto {
  @JsonKey(name: 'title')
  final String rawTitle;
  @JsonKey(name: 'author_name', defaultValue: [])
  final List<String> authorName;
  @JsonKey(name: 'cover_i')
  final int? coverId;

  BookDto({
    required this.rawTitle,
    required this.authorName,
    this.coverId,
  });

  factory BookDto.fromJson(Map<String, dynamic> json) => _$BookDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BookDtoToJson(this);

  String get coverUrl {
    if (coverId == null) return 'https://via.placeholder.com/100x150';
    return 'https://covers.openlibrary.org/b/id/$coverId-M.jpg';
  }

  Book toBook() {
    return Book(
      title: rawTitle?.trim().isNotEmpty == true ? rawTitle! : 'Без названия',
      authors: authorName.isNotEmpty ? authorName : ['Неизвестный автор'],
      coverUrl: coverId != null
          ? 'https://covers.openlibrary.org/b/id/$coverId-M.jpg'
          : null,
    );
  }
}