// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookDto _$BookDtoFromJson(Map<String, dynamic> json) => BookDto(
  rawTitle: json['title'] as String,
  authorName:
      (json['author_name'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      [],
  coverId: (json['cover_i'] as num?)?.toInt(),
);

Map<String, dynamic> _$BookDtoToJson(BookDto instance) => <String, dynamic>{
  'title': instance.rawTitle,
  'author_name': instance.authorName,
  'cover_i': instance.coverId,
};
