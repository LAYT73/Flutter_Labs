import 'package:flutter/material.dart';
import 'package:lab_flutter/models/book.dart';
import '../repositories/book_repository.dart';
import '../services/book_service_impl.dart';
import '../widgets/book_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final BookRepository _repository = BookRepository(BookServiceImpl());

  List<Book> _books = [];
  bool _loading = false;
  String _error = '';

  void _searchBooks(String query) async {
    if (query.isEmpty) return;

    setState(() {
      _loading = true;
      _books = [];
      _error = '';
    });

    try {
      final result = await _repository.searchBooks(query);
      setState(() {
        _books = result;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Шипилов Никита Сергеевич ПИбд-31'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Введите название книги или автора...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchBooks(_controller.text),
                ),
              ),
              onSubmitted: _searchBooks,
            ),
            const SizedBox(height: 16),
            if (_loading)
              const Center(child: CircularProgressIndicator())
            else if (_error.isNotEmpty)
              Text('Ошибка: $_error', style: const TextStyle(color: Colors.red))
            else if (_books.isEmpty)
                const Text('Введите запрос для поиска')
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _books.length,
                    itemBuilder: (context, index) {
                      return BookItem(book: _books[index]);
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}