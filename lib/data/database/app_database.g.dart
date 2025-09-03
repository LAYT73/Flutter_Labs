// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FavoriteBooksTable extends FavoriteBooks
    with TableInfo<$FavoriteBooksTable, FavoriteBook> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoriteBooksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _authorsMeta = const VerificationMeta(
    'authors',
  );
  @override
  late final GeneratedColumn<String> authors = GeneratedColumn<String>(
    'authors',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coverUrlMeta = const VerificationMeta(
    'coverUrl',
  );
  @override
  late final GeneratedColumn<String> coverUrl = GeneratedColumn<String>(
    'cover_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, title, authors, coverUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorite_books';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoriteBook> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('authors')) {
      context.handle(
        _authorsMeta,
        authors.isAcceptableOrUnknown(data['authors']!, _authorsMeta),
      );
    } else if (isInserting) {
      context.missing(_authorsMeta);
    }
    if (data.containsKey('cover_url')) {
      context.handle(
        _coverUrlMeta,
        coverUrl.isAcceptableOrUnknown(data['cover_url']!, _coverUrlMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FavoriteBook map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoriteBook(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      authors: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}authors'],
      )!,
      coverUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cover_url'],
      ),
    );
  }

  @override
  $FavoriteBooksTable createAlias(String alias) {
    return $FavoriteBooksTable(attachedDatabase, alias);
  }
}

class FavoriteBook extends DataClass implements Insertable<FavoriteBook> {
  final int id;
  final String title;
  final String authors;
  final String? coverUrl;
  const FavoriteBook({
    required this.id,
    required this.title,
    required this.authors,
    this.coverUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['authors'] = Variable<String>(authors);
    if (!nullToAbsent || coverUrl != null) {
      map['cover_url'] = Variable<String>(coverUrl);
    }
    return map;
  }

  FavoriteBooksCompanion toCompanion(bool nullToAbsent) {
    return FavoriteBooksCompanion(
      id: Value(id),
      title: Value(title),
      authors: Value(authors),
      coverUrl: coverUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(coverUrl),
    );
  }

  factory FavoriteBook.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoriteBook(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      authors: serializer.fromJson<String>(json['authors']),
      coverUrl: serializer.fromJson<String?>(json['coverUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'authors': serializer.toJson<String>(authors),
      'coverUrl': serializer.toJson<String?>(coverUrl),
    };
  }

  FavoriteBook copyWith({
    int? id,
    String? title,
    String? authors,
    Value<String?> coverUrl = const Value.absent(),
  }) => FavoriteBook(
    id: id ?? this.id,
    title: title ?? this.title,
    authors: authors ?? this.authors,
    coverUrl: coverUrl.present ? coverUrl.value : this.coverUrl,
  );
  FavoriteBook copyWithCompanion(FavoriteBooksCompanion data) {
    return FavoriteBook(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      authors: data.authors.present ? data.authors.value : this.authors,
      coverUrl: data.coverUrl.present ? data.coverUrl.value : this.coverUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteBook(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('authors: $authors, ')
          ..write('coverUrl: $coverUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, authors, coverUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoriteBook &&
          other.id == this.id &&
          other.title == this.title &&
          other.authors == this.authors &&
          other.coverUrl == this.coverUrl);
}

class FavoriteBooksCompanion extends UpdateCompanion<FavoriteBook> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> authors;
  final Value<String?> coverUrl;
  const FavoriteBooksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.authors = const Value.absent(),
    this.coverUrl = const Value.absent(),
  });
  FavoriteBooksCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String authors,
    this.coverUrl = const Value.absent(),
  }) : title = Value(title),
       authors = Value(authors);
  static Insertable<FavoriteBook> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? authors,
    Expression<String>? coverUrl,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (authors != null) 'authors': authors,
      if (coverUrl != null) 'cover_url': coverUrl,
    });
  }

  FavoriteBooksCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? authors,
    Value<String?>? coverUrl,
  }) {
    return FavoriteBooksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      authors: authors ?? this.authors,
      coverUrl: coverUrl ?? this.coverUrl,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (authors.present) {
      map['authors'] = Variable<String>(authors.value);
    }
    if (coverUrl.present) {
      map['cover_url'] = Variable<String>(coverUrl.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoriteBooksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('authors: $authors, ')
          ..write('coverUrl: $coverUrl')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FavoriteBooksTable favoriteBooks = $FavoriteBooksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [favoriteBooks];
}

typedef $$FavoriteBooksTableCreateCompanionBuilder =
    FavoriteBooksCompanion Function({
      Value<int> id,
      required String title,
      required String authors,
      Value<String?> coverUrl,
    });
typedef $$FavoriteBooksTableUpdateCompanionBuilder =
    FavoriteBooksCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> authors,
      Value<String?> coverUrl,
    });

class $$FavoriteBooksTableFilterComposer
    extends Composer<_$AppDatabase, $FavoriteBooksTable> {
  $$FavoriteBooksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get authors => $composableBuilder(
    column: $table.authors,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoriteBooksTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoriteBooksTable> {
  $$FavoriteBooksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get authors => $composableBuilder(
    column: $table.authors,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get coverUrl => $composableBuilder(
    column: $table.coverUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoriteBooksTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoriteBooksTable> {
  $$FavoriteBooksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get authors =>
      $composableBuilder(column: $table.authors, builder: (column) => column);

  GeneratedColumn<String> get coverUrl =>
      $composableBuilder(column: $table.coverUrl, builder: (column) => column);
}

class $$FavoriteBooksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoriteBooksTable,
          FavoriteBook,
          $$FavoriteBooksTableFilterComposer,
          $$FavoriteBooksTableOrderingComposer,
          $$FavoriteBooksTableAnnotationComposer,
          $$FavoriteBooksTableCreateCompanionBuilder,
          $$FavoriteBooksTableUpdateCompanionBuilder,
          (
            FavoriteBook,
            BaseReferences<_$AppDatabase, $FavoriteBooksTable, FavoriteBook>,
          ),
          FavoriteBook,
          PrefetchHooks Function()
        > {
  $$FavoriteBooksTableTableManager(_$AppDatabase db, $FavoriteBooksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoriteBooksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoriteBooksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoriteBooksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> authors = const Value.absent(),
                Value<String?> coverUrl = const Value.absent(),
              }) => FavoriteBooksCompanion(
                id: id,
                title: title,
                authors: authors,
                coverUrl: coverUrl,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String authors,
                Value<String?> coverUrl = const Value.absent(),
              }) => FavoriteBooksCompanion.insert(
                id: id,
                title: title,
                authors: authors,
                coverUrl: coverUrl,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoriteBooksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoriteBooksTable,
      FavoriteBook,
      $$FavoriteBooksTableFilterComposer,
      $$FavoriteBooksTableOrderingComposer,
      $$FavoriteBooksTableAnnotationComposer,
      $$FavoriteBooksTableCreateCompanionBuilder,
      $$FavoriteBooksTableUpdateCompanionBuilder,
      (
        FavoriteBook,
        BaseReferences<_$AppDatabase, $FavoriteBooksTable, FavoriteBook>,
      ),
      FavoriteBook,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FavoriteBooksTableTableManager get favoriteBooks =>
      $$FavoriteBooksTableTableManager(_db, _db.favoriteBooks);
}
