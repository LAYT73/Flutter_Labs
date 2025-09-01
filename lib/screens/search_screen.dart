import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/book_search_bloc.dart';
import '../../bloc/book_search_event.dart';
import '../../bloc/book_search_state.dart';
import '../../data/database/app_database.dart';
import '../../dto/book_dto.dart';
import '../../widgets/book_item.dart';
import '../../localization/app_localizations.dart';
import '../repositories/book_repository.dart';

class SearchScreen extends StatefulWidget {
  final void Function(Locale locale) setLocale;

  const SearchScreen({super.key, required this.setLocale});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  late BookSearchBloc _searchBloc;

  late AppLocalizations? L;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchBloc = BookSearchBloc(context.read<BookRepository>());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchBloc.close();
    _tabController.dispose();
    super.dispose();
  }

  void _changeLanguage(String langCode) {
    final locale = Locale(langCode);
    widget.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    L = AppLocalizations.of(context);

    return BlocProvider.value(
      value: _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.language),
              onSelected: _changeLanguage,
              itemBuilder: (context) => [
                PopupMenuItem(value: 'ru', child: Text('Русский')),
                PopupMenuItem(value: 'en', child: Text('English')),
              ],
            ),
          ],
          title: Text(L?.translate('appTitle') ?? 'Book Search'),
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                icon: const Icon(Icons.search),
                text: L?.translate('searchButton'),
              ),
              Tab(
                icon: const Icon(Icons.favorite),
                text: L?.translate('favorites'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildSearchTab(),
            _buildFavoritesTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: L?.translate('searchHint'),
              suffixIcon: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  final query = _searchController.text.trim();
                  _searchBloc.add(SearchBooks(query));
                },
              ),
            ),
            onChanged: (value) {
              final query = value.trim();
              if (query.length > 2 || query.isEmpty) {
                _searchBloc.add(SearchBooks(query));
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
                      final query = _searchController.text.trim();
                      if (query.isNotEmpty) {
                        context.read<BookSearchBloc>().add(RefreshBooks(query));
                      }
                    },
                    child: state.books.isEmpty
                        ? Center(child: Text(L?.translate('noResults') ?? 'No results found'))
                        : ListView.builder(
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        return BookItem(
                          book: state.books[index],
                          db: context.read<AppDatabase?>()!,
                          onFavoriteChanged: () {
                            if (mounted) setState(() {});
                          },
                        );
                      },
                    ),
                  );
                } else if (state is BookSearchError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${L?.translate('error')}: ${state.message}'),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () {
                            final query = _searchController.text.trim();
                            if (query.isNotEmpty) {
                              context.read<BookSearchBloc>().add(RefreshBooks(query));
                            }
                          },
                          child: Text(L?.translate('tryAgain') ?? 'Try again'),
                        ),
                      ],
                    ),
                  );
                }
                return Center(child: Text(L?.translate('enterQuery') ?? 'Enter a query'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesTab() {
    final db = context.watch<AppDatabase?>();
    if (db == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<List<FavoriteBook>>(
      future: db.getFavorites(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final favorites = snapshot.data!;
          if (favorites.isEmpty) {
            return Center(child: Text(L?.translate('noFavorites') ?? 'No favorite books'));
          }

          return RefreshIndicator(
            onRefresh: () async {
              if (mounted) setState(() {});
            },
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final f = favorites[index];
                final book = BookDto(
                  title: f.title,
                  authors: f.authors?.split(', ') ?? [],
                  coverId: f.coverUrl?.split('/').last.split('-').first,
                );
                return BookItem(
                  book: book,
                  db: db,
                  onFavoriteChanged: () {
                    if (mounted) setState(() {});
                  },
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('${L?.translate('error')}: ${snapshot.error}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}