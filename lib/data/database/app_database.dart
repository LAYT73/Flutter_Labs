import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../dto/book_dto.dart';
import 'entities/favorite_book.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [FavoriteBooks])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Добавить в избранное
  Future<int> addFavorite(BookDto book) {
    return into(favoriteBooks).insert(
      FavoriteBooksCompanion(
        title: Value(book.title),
        authors: Value(book.authors.join(', ')),
        coverUrl: Value(book.coverUrl),
      ),
    );
  }

  // Удалить из избранного
  Future<void> removeFavorite(int id) {
    return (delete(favoriteBooks)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Получить все избранные
  Future<List<FavoriteBook>> getFavorites() {
    return select(favoriteBooks).get();
  }

  Future<bool> isFavorite(String title) async {
    final List<FavoriteBook> results = await (select(favoriteBooks)
      ..where((tbl) => tbl.title.equals(title)))
        .get();
    return results.isNotEmpty;
  }
}

// ✅ Правильно: передаём File, а не String
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = p.join(dbFolder.path, 'db.sqlite');
    return NativeDatabase(File(file)); // ← Оберни в File
  });
}