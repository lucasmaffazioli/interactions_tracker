// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

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

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

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
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
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
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ApproachModelDao _approachModelDaoInstance;

  PointModelDao _pointModelDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
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
            'CREATE TABLE IF NOT EXISTS `approach` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dateTime` TEXT, `name` TEXT, `description` TEXT, `notes` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `approach_points` (`approachId` INTEGER, `id` INTEGER, `value` INTEGER, FOREIGN KEY (`approachId`) REFERENCES `approach_points` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`id`) REFERENCES `pointmodel` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`approachId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `pointmodel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `pointType` TEXT)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_pointmodel_name` ON `pointmodel` (`name`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ApproachModelDao get approachModelDao {
    return _approachModelDaoInstance ??=
        _$ApproachModelDao(database, changeListener);
  }

  @override
  PointModelDao get pointModelDao {
    return _pointModelDaoInstance ??= _$PointModelDao(database, changeListener);
  }
}

class _$ApproachModelDao extends ApproachModelDao {
  _$ApproachModelDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _approachModelInsertionAdapter = InsertionAdapter(
            database,
            'approach',
            (ApproachModel item) => <String, dynamic>{
                  'id': item.id,
                  'dateTime': item.dateTime,
                  'name': item.name,
                  'description': item.description,
                  'notes': item.notes
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _approachMapper = (Map<String, dynamic> row) => ApproachModel(
      id: row['id'] as int,
      dateTime: row['dateTime'] as String,
      name: row['name'] as String,
      description: row['description'] as String,
      notes: row['notes'] as String);

  final InsertionAdapter<ApproachModel> _approachModelInsertionAdapter;

  @override
  Future<List<ApproachModel>> findAllApproachModels() async {
    return _queryAdapter.queryList('SELECT * FROM ApproachModel',
        mapper: _approachMapper);
  }

  @override
  Stream<ApproachModel> findApproachModelById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM ApproachModel WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'approach',
        isView: false,
        mapper: _approachMapper);
  }

  @override
  Future<void> insertApproachModel(ApproachModel approach) async {
    await _approachModelInsertionAdapter.insert(
        approach, OnConflictStrategy.abort);
  }
}

class _$PointModelDao extends PointModelDao {
  _$PointModelDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _pointModelInsertionAdapter = InsertionAdapter(
            database,
            'pointmodel',
            (PointModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'pointType': item.pointType
                },
            changeListener),
        _pointModelUpdateAdapter = UpdateAdapter(
            database,
            'pointmodel',
            ['id'],
            (PointModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'pointType': item.pointType
                },
            changeListener),
        _pointModelDeletionAdapter = DeletionAdapter(
            database,
            'pointmodel',
            ['id'],
            (PointModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'pointType': item.pointType
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _pointmodelMapper = (Map<String, dynamic> row) => PointModel(
      id: row['id'] as int,
      name: row['name'] as String,
      pointType: row['pointType'] as String);

  final InsertionAdapter<PointModel> _pointModelInsertionAdapter;

  final UpdateAdapter<PointModel> _pointModelUpdateAdapter;

  final DeletionAdapter<PointModel> _pointModelDeletionAdapter;

  @override
  Future<List<PointModel>> findAllPointModels() async {
    return _queryAdapter.queryList('SELECT * FROM PointModel',
        mapper: _pointmodelMapper);
  }

  @override
  Stream<PointModel> findPointModelById(int id) {
    return _queryAdapter.queryStream('SELECT * FROM PointModel WHERE id = ?',
        arguments: <dynamic>[id],
        queryableName: 'pointmodel',
        isView: false,
        mapper: _pointmodelMapper);
  }

  @override
  Future<void> insertPoint(PointModel point) async {
    await _pointModelInsertionAdapter.insert(point, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePoint(PointModel point) async {
    await _pointModelUpdateAdapter.update(point, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePoint(PointModel point) async {
    await _pointModelDeletionAdapter.delete(point);
  }
}