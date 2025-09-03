import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../dto/book_dto.dart';
import '../../models/book.dart';
import 'book_service.dart';

class BookServiceImpl implements BookService {
  static const String baseUrl = 'https://openlibrary.org';

  @override
  Future<List<Book>> searchBooks(String query) async {
    final url = Uri.parse('$baseUrl/search.json');
    final response = await http.get(
      url.replace(queryParameters: {'q': query, 'limit': '20'}),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки данных: ${response.statusCode}');
    }

    final data = json.decode(response.body);

    if (data is! Map<String, dynamic> || !data.containsKey('docs')) {
      throw Exception('Неверный формат ответа от сервера');
    }

    final List<dynamic> docs = data['docs'];
    final List<BookDto> dtos = docs
        .where((e) => e is Map<String, dynamic>) // фильтр на случай некорректных данных
        .map((e) => BookDto.fromJson(e as Map<String, dynamic>))
        .toList();

    return dtos.map((dto) => dto.toBook()).toList();
  }
}