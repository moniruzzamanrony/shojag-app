import 'package:drift/drift.dart';

/// [TableIncident] table model class
/// It defines the table structure and its columns
/// [build_runner] will create the table
///
/// In terminal run [dart run build_runner build --delete-conflicting-outputs]
class TableIncident extends Table {
  IntColumn get id => integer().named('id').autoIncrement()();

  IntColumn get categoryId => integer().named('category_id')();

  TextColumn get titleEn => text().named('title_en')();

  TextColumn get titleBn => text().named('title_bn')();

  TextColumn get tags => text().named('tags')();

  TextColumn get description => text().named('description').nullable()();

  BoolColumn get isOnline => boolean().named('is_online')();
}
