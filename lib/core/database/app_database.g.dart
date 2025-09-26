// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TableIncidentTable extends TableIncident
    with TableInfo<$TableIncidentTable, TableIncidentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TableIncidentTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleEnMeta = const VerificationMeta(
    'titleEn',
  );
  @override
  late final GeneratedColumn<String> titleEn = GeneratedColumn<String>(
    'title_en',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleBnMeta = const VerificationMeta(
    'titleBn',
  );
  @override
  late final GeneratedColumn<String> titleBn = GeneratedColumn<String>(
    'title_bn',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isOnlineMeta = const VerificationMeta(
    'isOnline',
  );
  @override
  late final GeneratedColumn<bool> isOnline = GeneratedColumn<bool>(
    'is_online',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_online" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    titleEn,
    titleBn,
    tags,
    description,
    isOnline,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'table_incident';
  @override
  VerificationContext validateIntegrity(
    Insertable<TableIncidentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('title_en')) {
      context.handle(
        _titleEnMeta,
        titleEn.isAcceptableOrUnknown(data['title_en']!, _titleEnMeta),
      );
    } else if (isInserting) {
      context.missing(_titleEnMeta);
    }
    if (data.containsKey('title_bn')) {
      context.handle(
        _titleBnMeta,
        titleBn.isAcceptableOrUnknown(data['title_bn']!, _titleBnMeta),
      );
    } else if (isInserting) {
      context.missing(_titleBnMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_online')) {
      context.handle(
        _isOnlineMeta,
        isOnline.isAcceptableOrUnknown(data['is_online']!, _isOnlineMeta),
      );
    } else if (isInserting) {
      context.missing(_isOnlineMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TableIncidentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TableIncidentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      titleEn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_en'],
      )!,
      titleBn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title_bn'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isOnline: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_online'],
      )!,
    );
  }

  @override
  $TableIncidentTable createAlias(String alias) {
    return $TableIncidentTable(attachedDatabase, alias);
  }
}

class TableIncidentData extends DataClass
    implements Insertable<TableIncidentData> {
  final int id;
  final int categoryId;
  final String titleEn;
  final String titleBn;
  final String tags;
  final String? description;
  final bool isOnline;
  const TableIncidentData({
    required this.id,
    required this.categoryId,
    required this.titleEn,
    required this.titleBn,
    required this.tags,
    this.description,
    required this.isOnline,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['category_id'] = Variable<int>(categoryId);
    map['title_en'] = Variable<String>(titleEn);
    map['title_bn'] = Variable<String>(titleBn);
    map['tags'] = Variable<String>(tags);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_online'] = Variable<bool>(isOnline);
    return map;
  }

  TableIncidentCompanion toCompanion(bool nullToAbsent) {
    return TableIncidentCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      titleEn: Value(titleEn),
      titleBn: Value(titleBn),
      tags: Value(tags),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isOnline: Value(isOnline),
    );
  }

  factory TableIncidentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TableIncidentData(
      id: serializer.fromJson<int>(json['id']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      titleEn: serializer.fromJson<String>(json['titleEn']),
      titleBn: serializer.fromJson<String>(json['titleBn']),
      tags: serializer.fromJson<String>(json['tags']),
      description: serializer.fromJson<String?>(json['description']),
      isOnline: serializer.fromJson<bool>(json['isOnline']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'categoryId': serializer.toJson<int>(categoryId),
      'titleEn': serializer.toJson<String>(titleEn),
      'titleBn': serializer.toJson<String>(titleBn),
      'tags': serializer.toJson<String>(tags),
      'description': serializer.toJson<String?>(description),
      'isOnline': serializer.toJson<bool>(isOnline),
    };
  }

  TableIncidentData copyWith({
    int? id,
    int? categoryId,
    String? titleEn,
    String? titleBn,
    String? tags,
    Value<String?> description = const Value.absent(),
    bool? isOnline,
  }) => TableIncidentData(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    titleEn: titleEn ?? this.titleEn,
    titleBn: titleBn ?? this.titleBn,
    tags: tags ?? this.tags,
    description: description.present ? description.value : this.description,
    isOnline: isOnline ?? this.isOnline,
  );
  TableIncidentData copyWithCompanion(TableIncidentCompanion data) {
    return TableIncidentData(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      titleEn: data.titleEn.present ? data.titleEn.value : this.titleEn,
      titleBn: data.titleBn.present ? data.titleBn.value : this.titleBn,
      tags: data.tags.present ? data.tags.value : this.tags,
      description: data.description.present
          ? data.description.value
          : this.description,
      isOnline: data.isOnline.present ? data.isOnline.value : this.isOnline,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TableIncidentData(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleBn: $titleBn, ')
          ..write('tags: $tags, ')
          ..write('description: $description, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    titleEn,
    titleBn,
    tags,
    description,
    isOnline,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TableIncidentData &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.titleEn == this.titleEn &&
          other.titleBn == this.titleBn &&
          other.tags == this.tags &&
          other.description == this.description &&
          other.isOnline == this.isOnline);
}

class TableIncidentCompanion extends UpdateCompanion<TableIncidentData> {
  final Value<int> id;
  final Value<int> categoryId;
  final Value<String> titleEn;
  final Value<String> titleBn;
  final Value<String> tags;
  final Value<String?> description;
  final Value<bool> isOnline;
  const TableIncidentCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.titleEn = const Value.absent(),
    this.titleBn = const Value.absent(),
    this.tags = const Value.absent(),
    this.description = const Value.absent(),
    this.isOnline = const Value.absent(),
  });
  TableIncidentCompanion.insert({
    this.id = const Value.absent(),
    required int categoryId,
    required String titleEn,
    required String titleBn,
    required String tags,
    this.description = const Value.absent(),
    required bool isOnline,
  }) : categoryId = Value(categoryId),
       titleEn = Value(titleEn),
       titleBn = Value(titleBn),
       tags = Value(tags),
       isOnline = Value(isOnline);
  static Insertable<TableIncidentData> custom({
    Expression<int>? id,
    Expression<int>? categoryId,
    Expression<String>? titleEn,
    Expression<String>? titleBn,
    Expression<String>? tags,
    Expression<String>? description,
    Expression<bool>? isOnline,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (titleEn != null) 'title_en': titleEn,
      if (titleBn != null) 'title_bn': titleBn,
      if (tags != null) 'tags': tags,
      if (description != null) 'description': description,
      if (isOnline != null) 'is_online': isOnline,
    });
  }

  TableIncidentCompanion copyWith({
    Value<int>? id,
    Value<int>? categoryId,
    Value<String>? titleEn,
    Value<String>? titleBn,
    Value<String>? tags,
    Value<String?>? description,
    Value<bool>? isOnline,
  }) {
    return TableIncidentCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      titleEn: titleEn ?? this.titleEn,
      titleBn: titleBn ?? this.titleBn,
      tags: tags ?? this.tags,
      description: description ?? this.description,
      isOnline: isOnline ?? this.isOnline,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (titleEn.present) {
      map['title_en'] = Variable<String>(titleEn.value);
    }
    if (titleBn.present) {
      map['title_bn'] = Variable<String>(titleBn.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TableIncidentCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('titleEn: $titleEn, ')
          ..write('titleBn: $titleBn, ')
          ..write('tags: $tags, ')
          ..write('description: $description, ')
          ..write('isOnline: $isOnline')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TableIncidentTable tableIncident = $TableIncidentTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tableIncident];
}

typedef $$TableIncidentTableCreateCompanionBuilder =
    TableIncidentCompanion Function({
      Value<int> id,
      required int categoryId,
      required String titleEn,
      required String titleBn,
      required String tags,
      Value<String?> description,
      required bool isOnline,
    });
typedef $$TableIncidentTableUpdateCompanionBuilder =
    TableIncidentCompanion Function({
      Value<int> id,
      Value<int> categoryId,
      Value<String> titleEn,
      Value<String> titleBn,
      Value<String> tags,
      Value<String?> description,
      Value<bool> isOnline,
    });

class $$TableIncidentTableFilterComposer
    extends Composer<_$AppDatabase, $TableIncidentTable> {
  $$TableIncidentTableFilterComposer({
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

  ColumnFilters<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titleBn => $composableBuilder(
    column: $table.titleBn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOnline => $composableBuilder(
    column: $table.isOnline,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TableIncidentTableOrderingComposer
    extends Composer<_$AppDatabase, $TableIncidentTable> {
  $$TableIncidentTableOrderingComposer({
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

  ColumnOrderings<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleEn => $composableBuilder(
    column: $table.titleEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titleBn => $composableBuilder(
    column: $table.titleBn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOnline => $composableBuilder(
    column: $table.isOnline,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TableIncidentTableAnnotationComposer
    extends Composer<_$AppDatabase, $TableIncidentTable> {
  $$TableIncidentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get titleEn =>
      $composableBuilder(column: $table.titleEn, builder: (column) => column);

  GeneratedColumn<String> get titleBn =>
      $composableBuilder(column: $table.titleBn, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isOnline =>
      $composableBuilder(column: $table.isOnline, builder: (column) => column);
}

class $$TableIncidentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TableIncidentTable,
          TableIncidentData,
          $$TableIncidentTableFilterComposer,
          $$TableIncidentTableOrderingComposer,
          $$TableIncidentTableAnnotationComposer,
          $$TableIncidentTableCreateCompanionBuilder,
          $$TableIncidentTableUpdateCompanionBuilder,
          (
            TableIncidentData,
            BaseReferences<
              _$AppDatabase,
              $TableIncidentTable,
              TableIncidentData
            >,
          ),
          TableIncidentData,
          PrefetchHooks Function()
        > {
  $$TableIncidentTableTableManager(_$AppDatabase db, $TableIncidentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TableIncidentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TableIncidentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TableIncidentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<String> titleEn = const Value.absent(),
                Value<String> titleBn = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isOnline = const Value.absent(),
              }) => TableIncidentCompanion(
                id: id,
                categoryId: categoryId,
                titleEn: titleEn,
                titleBn: titleBn,
                tags: tags,
                description: description,
                isOnline: isOnline,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int categoryId,
                required String titleEn,
                required String titleBn,
                required String tags,
                Value<String?> description = const Value.absent(),
                required bool isOnline,
              }) => TableIncidentCompanion.insert(
                id: id,
                categoryId: categoryId,
                titleEn: titleEn,
                titleBn: titleBn,
                tags: tags,
                description: description,
                isOnline: isOnline,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TableIncidentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TableIncidentTable,
      TableIncidentData,
      $$TableIncidentTableFilterComposer,
      $$TableIncidentTableOrderingComposer,
      $$TableIncidentTableAnnotationComposer,
      $$TableIncidentTableCreateCompanionBuilder,
      $$TableIncidentTableUpdateCompanionBuilder,
      (
        TableIncidentData,
        BaseReferences<_$AppDatabase, $TableIncidentTable, TableIncidentData>,
      ),
      TableIncidentData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TableIncidentTableTableManager get tableIncident =>
      $$TableIncidentTableTableManager(_db, _db.tableIncident);
}
