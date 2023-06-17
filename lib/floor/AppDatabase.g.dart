// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AssessmentDao? _assessmentDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Assessment` (`id` TEXT NOT NULL, `aspect` TEXT NOT NULL, `criteria` TEXT NOT NULL, `type` INTEGER NOT NULL, `bobot` INTEGER NOT NULL, `bobot_penilaian` REAL NOT NULL, `target` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AssessmentDao get assessmentDao {
    return _assessmentDaoInstance ??= _$AssessmentDao(database, changeListener);
  }
}

class _$AssessmentDao extends AssessmentDao {
  _$AssessmentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _assessmentInsertionAdapter = InsertionAdapter(
            database,
            'Assessment',
            (Assessment item) => <String, Object?>{
                  'id': item.id,
                  'aspect': item.aspect,
                  'criteria': item.criteria,
                  'type': item.type,
                  'bobot': item.bobot,
                  'bobot_penilaian': item.bobot_penilaian,
                  'target': item.target
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Assessment> _assessmentInsertionAdapter;

  @override
  Future<List<Assessment>> getAllAssessments() async {
    return _queryAdapter.queryList('SELECT * FROM Assesment',
        mapper: (Map<String, Object?> row) => Assessment(
            id: row['id'] as String,
            aspect: row['aspect'] as String,
            criteria: row['criteria'] as String,
            type: row['type'] as int,
            bobot: row['bobot'] as int,
            bobot_penilaian: row['bobot_penilaian'] as double,
            target: row['target'] as int));
  }

  @override
  Future<void> addAssessment(Assessment assesment) async {
    await _assessmentInsertionAdapter.insert(
        assesment, OnConflictStrategy.replace);
  }
}
