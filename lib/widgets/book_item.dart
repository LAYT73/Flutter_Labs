import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/database/app_database.dart';
import '../../dto/book_dto.dart';

class BookItem extends StatefulWidget {
  final BookDto book;
  final AppDatabase db;
  final VoidCallback? onFavoriteChanged;

  const BookItem({
    super.key,
    required this.book,
    required this.db,
    this.onFavoriteChanged,
  });

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> {
  late AppDatabase _db;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _db = context.read<AppDatabase>();
    _checkFavorite();
  }

  void _checkFavorite() async {
    final isFav = await _db.isFavorite(widget.book.title);
    if (mounted) {
      setState(() {
        _isFavorite = isFav;
      });
    }
  }

  void _toggleFavorite() async {
    if (_isFavorite) {
      final favorites = await _db.getFavorites();
      final item = favorites.firstWhere((f) => f.title == widget.book.title);
      await _db.removeFavorite(item.id);
    } else {
      await _db.addFavorite(widget.book);
    }

    if (mounted) {
      setState(() {
        _isFavorite = !_isFavorite;
      });

      widget.onFavoriteChanged?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            widget.book.coverUrl,
            width: 60,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const SizedBox(
              width: 60,
              height: 80,
              child: Icon(Icons.book, size: 30),
            ),
          ),
        ),
        title: Text(
          widget.book.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.book.authors.join(', '),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          icon: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            color: _isFavorite ? Colors.red : null,
          ),
          onPressed: _toggleFavorite,
        ),
      ),
    );
  }
}