import 'package:flutter/material.dart';
import '../dto/book_dto.dart';

class BookItem extends StatelessWidget {
  final BookDto book;

  const BookItem({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            book.coverUrl,
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
          book.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          book.authors.isEmpty ? 'Автор неизвестен' : book.authors.join(', '),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}