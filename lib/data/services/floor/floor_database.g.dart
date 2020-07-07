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

  ApproachPointsModelDao _approachPointsModelDaoInstance;

  ApproachSummaryDao _approachSummaryDaoInstance;

  ApproachPointsViewDao _approachPointsViewDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `approach_points` (`approachId` INTEGER, `pointId` INTEGER, `value` INTEGER, FOREIGN KEY (`approachId`) REFERENCES `approach` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`pointId`) REFERENCES `point` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`approachId`, `pointId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `point` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `pointType` TEXT)');
        await database.execute(
            'CREATE UNIQUE INDEX `index_point_name` ON `point` (`name`)');
        await database.execute(
            '''CREATE VIEW IF NOT EXISTS `approach_summary_view` AS SELECT a.id, a.name, a.dateTime, a.description, 
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'difficulty') as difficulty,
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'skill') as skill,
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'attraction') as attraction,
(SELECT AVG(value) FROM approach_points INNER JOIN point ON id = pointId where approachId = a.id AND pointType = 'result') as result
FROM approach a
ORDER BY a.dateTime DESC
''');
        await database.execute(
            '''CREATE VIEW IF NOT EXISTS `approach_points_view` AS SELECT ap.approachId, ap.pointId, p.name AS pointName, ap.value AS pointValue, p.pointType
FROM approach_points ap
INNER JOIN point p ON p.id = ap.pointId 
ORDER BY p.pointType
''');

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

  @override
  ApproachPointsModelDao get approachPointsModelDao {
    return _approachPointsModelDaoInstance ??=
        _$ApproachPointsModelDao(database, changeListener);
  }

  @override
  ApproachSummaryDao get approachSummaryDao {
    return _approachSummaryDaoInstance ??=
        _$ApproachSummaryDao(database, changeListener);
  }

  @override
  ApproachPointsViewDao get approachPointsViewDao {
    return _approachPointsViewDaoInstance ??=
        _$ApproachPointsViewDao(database, changeListener);
  }
}

class _$ApproachModelDao extends ApproachModelDao {
  _$ApproachModelDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _approachModelInsertionAdapter = InsertionAdapter(
            database,
            'approach',
            (ApproachModel item) => <String, dynamic>{
                  'id': item.id,
                  'dateTime': item.dateTime,
                  'name': item.name,
                  'description': item.description,
                  'notes': item.notes
                }),
        _approachModelUpdateAdapter = UpdateAdapter(
            database,
            'approach',
            ['id'],
            (ApproachModel item) => <String, dynamic>{
                  'id': item.id,
                  'dateTime': item.dateTime,
                  'name': item.name,
                  'description': item.description,
                  'notes': item.notes
                }),
        _approachModelDeletionAdapter = DeletionAdapter(
            database,
            'approach',
            ['id'],
            (ApproachModel item) => <String, dynamic>{
                  'id': item.id,
                  'dateTime': item.dateTime,
                  'name': item.name,
                  'description': item.description,
                  'notes': item.notes
                });

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

  final UpdateAdapter<ApproachModel> _approachModelUpdateAdapter;

  final DeletionAdapter<ApproachModel> _approachModelDeletionAdapter;

  @override
  Future<List<ApproachModel>> findAllApproachModels() async {
    return _queryAdapter.queryList('SELECT * FROM approach',
        mapper: _approachMapper);
  }

  @override
  Future<ApproachModel> findApproachModelById(int id) async {
    return _queryAdapter.query('SELECT * FROM approach WHERE id = ?',
        arguments: <dynamic>[id], mapper: _approachMapper);
  }

  @override
  Future<void> deleteApproachById(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM approach WHERE id = ?',
        arguments: <dynamic>[id]);
  }

  @override
  Future<void> insertApproach(ApproachModel approach) async {
    await _approachModelInsertionAdapter.insert(
        approach, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateApproach(ApproachModel approach) async {
    await _approachModelUpdateAdapter.update(
        approach, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteApproach(ApproachModel approach) async {
    await _approachModelDeletionAdapter.delete(approach);
  }
}

class _$PointModelDao extends PointModelDao {
  _$PointModelDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _pointModelInsertionAdapter = InsertionAdapter(
            database,
            'point',
            (PointModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'pointType': item.pointType
                }),
        _pointModelUpdateAdapter = UpdateAdapter(
            database,
            'point',
            ['id'],
            (PointModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'pointType': item.pointType
                }),
        _pointModelDeletionAdapter = DeletionAdapter(
            database,
            'point',
            ['id'],
            (PointModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'pointType': item.pointType
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _pointMapper = (Map<String, dynamic> row) => PointModel(
      id: row['id'] as int,
      name: row['name'] as String,
      pointType: row['pointType'] as String);

  final InsertionAdapter<PointModel> _pointModelInsertionAdapter;

  final UpdateAdapter<PointModel> _pointModelUpdateAdapter;

  final DeletionAdapter<PointModel> _pointModelDeletionAdapter;

  @override
  Future<List<PointModel>> findAllPointModels() async {
    return _queryAdapter.queryList(
        'SELECT * FROM point ORDER BY pointType DESC, name',
        mapper: _pointMapper);
  }

  @override
  Future<PointModel> findPointModelById(int id) async {
    return _queryAdapter.query('SELECT * FROM point WHERE id = ?',
        arguments: <dynamic>[id], mapper: _pointMapper);
  }

  @override
  Future<void> deletePointById(int id) async {
    await _queryAdapter.queryNoReturn('DELETE FROM point WHERE id = ?',
        arguments: <dynamic>[id]);
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

class _$ApproachPointsModelDao extends ApproachPointsModelDao {
  _$ApproachPointsModelDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _approachPointsModelInsertionAdapter = InsertionAdapter(
            database,
            'approach_points',
            (ApproachPointsModel item) => <String, dynamic>{
                  'approachId': item.approachId,
                  'pointId': item.pointId,
                  'value': item.value
                }),
        _approachPointsModelUpdateAdapter = UpdateAdapter(
            database,
            'approach_points',
            ['approachId', 'pointId'],
            (ApproachPointsModel item) => <String, dynamic>{
                  'approachId': item.approachId,
                  'pointId': item.pointId,
                  'value': item.value
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _approach_pointsMapper = (Map<String, dynamic> row) =>
      ApproachPointsModel(
          approachId: row['approachId'] as int,
          pointId: row['pointId'] as int,
          value: row['value'] as int);

  final InsertionAdapter<ApproachPointsModel>
      _approachPointsModelInsertionAdapter;

  final UpdateAdapter<ApproachPointsModel> _approachPointsModelUpdateAdapter;

  @override
  Future<ApproachPointsModel> findApproachPointByApproachAndPointId(
      int approachId, int pointId) async {
    return _queryAdapter.query(
        'SELECT * FROM approach_points WHERE approachId = ? AND pointId = ?',
        arguments: <dynamic>[approachId, pointId],
        mapper: _approach_pointsMapper);
  }

  @override
  Future<List<ApproachPointsModel>> findApproachPointsByApproachId(
      int approachId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM approach_points WHERE approachId = ?',
        arguments: <dynamic>[approachId],
        mapper: _approach_pointsMapper);
  }

  @override
  Future<void> deleteApproachPointsByApproachId(int approachId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM approach_points WHERE approachId = ?',
        arguments: <dynamic>[approachId]);
  }

  @override
  Future<void> deleteApproachPointsByApproachAndPointId(
      int approachId, int pointId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM approach_points WHERE approachId = ? AND pointId = ?',
        arguments: <dynamic>[approachId, pointId]);
  }

  @override
  Future<void> insertApproachPoints(ApproachPointsModel approachPoints) async {
    await _approachPointsModelInsertionAdapter.insert(
        approachPoints, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateApproachPoints(ApproachPointsModel approachPoints) async {
    await _approachPointsModelUpdateAdapter.update(
        approachPoints, OnConflictStrategy.abort);
  }
}

class _$ApproachSummaryDao extends ApproachSummaryDao {
  _$ApproachSummaryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _approach_summary_viewMapper = (Map<String, dynamic> row) =>
      ApproachSummaryView(
          row['id'] as int,
          row['name'] as String,
          row['dateTime'] as String,
          row['description'] as String,
          row['difficulty'] as double,
          row['skill'] as double,
          row['attraction'] as double,
          row['result'] as double);

  @override
  Future<List<ApproachSummaryView>> findApproachesSummary() async {
    return _queryAdapter.queryList('SELECT * FROM approach_summary_view',
        mapper: _approach_summary_viewMapper);
  }
}

class _$ApproachPointsViewDao extends ApproachPointsViewDao {
  _$ApproachPointsViewDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _approach_points_viewMapper = (Map<String, dynamic> row) =>
      ApproachPointsView(
          approachId: row['approachId'] as int,
          pointId: row['pointId'] as int,
          pointName: row['pointName'] as String,
          pointValue: row['pointValue'] as int,
          pointType: row['pointType'] as String);

  @override
  Future<List<ApproachPointsView>> findApproachesPointsByApproachId(
      int approachId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM approach_points_view WHERE approachId = ?',
        arguments: <dynamic>[approachId],
        mapper: _approach_points_viewMapper);
  }
}
