import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dto/book_dto.dart';
import '../services/book_service.dart';

class BookServiceImpl implements BookService {
  static const String baseUrl = 'https://openlibrary.org';

  @override
  Future<List<BookDto>> searchBooks(String query) async {
    final url = Uri.parse('$baseUrl/search.json?q=$query');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Ошибка загрузки данных');
    }

    final data = json.decode(response.body);
    final List<dynamic> docs = data['docs'] ?? [];

    return docs.map((json) => BookDto.fromJson(json)).toList();
  }
}