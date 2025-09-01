import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/book_search_bloc.dart';
import '../../bloc/book_search_event.dart';
import '../../bloc/book_search_state.dart';
import '../../dto/book_dto.dart';
import '../../repositories/book_repository.dart';
import '../../widgets/book_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  late BookSearchBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BookSearchBloc(context.read<BookRepository>());
  }

  @override
  void dispose() {
    _controller.dispose();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _bloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Поиск книг'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Введите название или автора...',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      final query = _controller.text.trim();
                      _bloc.add(SearchBooks(query));
                    },
                  ),
                ),
                onChanged: (value) {
                  final query = value.trim();
                  if (query.length > 2 || query.isEmpty) {
                    _bloc.add(SearchBooks(query));
                  }
                },
              ),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<BookSearchBloc, BookSearchState>(
                  builder: (context, state) {
                    if (state is BookSearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is BookSearchSuccess) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          final query = _controller.text.trim();
                          if (query.isNotEmpty) {
                            context.read<BookSearchBloc>().add(RefreshBooks(query));
                          }
                        },
                        child: state.books.isEmpty
                            ? const Center(child: Text('Ничего не найдено'))
                            : ListView.builder(
                          itemCount: state.books.length,
                          itemBuilder: (context, index) {
                            return BookItem(book: state.books[index]);
                          },
                        ),
                      );
                    } else if (state is BookSearchError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Ошибка: ${state.message}'),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                final query = _controller.text.trim();
                                if (query.isNotEmpty) {
                                  context.read<BookSearchBloc>().add(RefreshBooks(query));
                                }
                              },
                              child: const Text('Повторить'),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Center(child: Text('Введите запрос'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}