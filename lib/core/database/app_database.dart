import 'dart:io';

import 'package:app/core/database/table_incident.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

const int localDbVersion = 3;

/// [AppDatabase] is a singleton class that provides a connection to the local database.
/// It uses drift to define the schema and perform database operations.
/// Also it uses drift's lazy database to open the database connection when needed.
/// And can be configured to use a custom migration strategy.
@DriftDatabase(tables: [TableIncident])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => localDbVersion;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
      onUpgrade: (m, from, to) async {
        if (from == 1 && to == 2) {
          await m.deleteTable('table_incident');
          await m.createAll();
        }
      },
    );
  }
}

/// [_openConnection] returns a lazy database connection to the local database.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await path_provider.getApplicationSupportDirectory();
    final file = File(path.join(dbFolder.path, 'database', 'shojag.sqlite'));

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await path_provider.getTemporaryDirectory()).path;

    sqlite3.tempDirectory = cachebase;
    return NativeDatabase.createInBackground(file);
  });
}
