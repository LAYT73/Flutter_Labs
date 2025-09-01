import 'package:drift/drift.dart';

class FavoriteBooks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get authors => text()();
  TextColumn get coverUrl => text().nullable()();
}