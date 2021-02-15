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

  InteractionModelDao _interactionModelDaoInstance;

  PointModelDao _pointModelDaoInstance;

  InteractionPointsModelDao _interactionPointsModelDaoInstance;

  InteractionSummaryDao _interactionSummaryDaoInstance;

  InteractionPointsViewDao _interactionPointsViewDaoInstance;

  GoalsModelDao _goalsModelDaoInstance;

  ConfigModelDao _configModelDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `interaction` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `dateTime` TEXT, `name` TEXT, `description` TEXT, `notes` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `interaction_points` (`interactionId` INTEGER, `pointId` INTEGER, `value` INTEGER, FOREIGN KEY (`interactionId`) REFERENCES `interaction` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, FOREIGN KEY (`pointId`) REFERENCES `point` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`interactionId`, `pointId`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `point` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT, `pointType` TEXT, `item1` TEXT, `item2` TEXT, `item3` TEXT, `item4` TEXT, `item5` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `goals` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `weeklyInteractionGoal` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `config` (`id` INTEGER, `lastRunVersion` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE UNIQUE INDEX `index_point_name` ON `point` (`name`)');
        await database.execute(
            '''CREATE VIEW IF NOT EXISTS `interaction_summary_view` AS SELECT a.id, a.name, a.dateTime, a.description, 
(SELECT AVG(value) FROM interaction_points INNER JOIN point ON id = pointId where interactionId = a.id AND pointType = 'PointType.difficulty') as difficulty,
(SELECT AVG(value) FROM interaction_points INNER JOIN point ON id = pointId where interactionId = a.id AND pointType = 'PointType.skill') as skill,
(SELECT AVG(value) FROM interaction_points INNER JOIN point ON id = pointId where interactionId = a.id AND pointType = 'PointType.attraction') as attraction,
(SELECT AVG(value) FROM interaction_points INNER JOIN point ON id = pointId where interactionId = a.id AND pointType = 'PointType.result') as result
FROM interaction a
ORDER BY a.dateTime DESC
''');
        await database.execute(
            '''CREATE VIEW IF NOT EXISTS `interaction_points_view` AS SELECT ap.interactionId, ap.pointId, p.name AS pointName, ap.value AS pointValue, p.pointType, p.item1, p.item2, p.item3, p.item4, p.item5 
FROM interaction_points ap
INNER JOIN point p ON p.id = ap.pointId 
ORDER BY p.pointType
''');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  InteractionModelDao get interactionModelDao {
    return _interactionModelDaoInstance ??=
        _$InteractionModelDao(database, changeListener);
  }

  @override
  PointModelDao get pointModelDao {
    return _pointModelDaoInstance ??= _$PointModelDao(database, changeListener);
  }

  @override
  InteractionPointsModelDao get interactionPointsModelDao {
    return _interactionPointsModelDaoInstance ??=
        _$InteractionPointsModelDao(database, changeListener);
  }

  @override
  InteractionSummaryDao get interactionSummaryDao {
    return _interactionSummaryDaoInstance ??=
        _$InteractionSummaryDao(database, changeListener);
  }

  @override
  InteractionPointsViewDao get interactionPointsViewDao {
    return _interactionPointsViewDaoInstance ??=
        _$InteractionPointsViewDao(database, changeListener);
  }

  @override
  GoalsModelDao get goalsModelDao {
    return _goalsModelDaoInstance ??= _$GoalsModelDao(database, changeListener);
  }

  @override
  ConfigModelDao get configModelDao {
    return _configModelDaoInstance ??=
        _$ConfigModelDao(database, changeListener);
  }
}

class _$InteractionModelDao extends InteractionModelDao {
  _$InteractionModelDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _interactionModelInsertionAdapter = InsertionAdapter(
            database,
            'interaction',
            (InteractionModel item) => <String, dynamic>{
                  'id': item.id,
                  'dateTime': item.dateTime,
                  'name': item.name,
                  'description': item.description,
                  'notes': item.notes
                },
            changeListener),
        _interactionModelUpdateAdapter = UpdateAdapter(
            database,
            'interaction',
            ['id'],
            (InteractionModel item) => <String, dynamic>{
                  'id': item.id,
                  'dateTime': item.dateTime,
                  'name': item.name,
                  'description': item.description,
                  'notes': item.notes
                },
            changeListener),
        _interactionModelDeletionAdapter = DeletionAdapter(
            database,
            'interaction',
            ['id'],
            (InteractionModel item) => <String, dynamic>{
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

  final InsertionAdapter<InteractionModel> _interactionModelInsertionAdapter;

  final UpdateAdapter<InteractionModel> _interactionModelUpdateAdapter;

  final DeletionAdapter<InteractionModel> _interactionModelDeletionAdapter;

  @override
  Future<List<InteractionModel>> findAllInteractionModels() async {
    return _queryAdapter.queryList('SELECT * FROM interaction',
        mapper: (Map<String, dynamic> row) => InteractionModel(
            id: row['id'] as int,
            dateTime: row['dateTime'] as String,
            name: row['name'] as String,
            description: row['description'] as String,
            notes: row['notes'] as String));
  }

  @override
  Future<InteractionModel> findInteractionModelById(int id) async {
    return _queryAdapter.query('SELECT * FROM interaction WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => InteractionModel(
            id: row['id'] as int,
            dateTime: row['dateTime'] as String,
            name: row['name'] as String,
            description: row['description'] as String,
            notes: row['notes'] as String));
  }

  @override
  Future<List<InteractionModel>> findLast30Interactions() async {
    return _queryAdapter.queryList(
        'SELECT * FROM interaction ORDER BY dateTime DESC LIMIT 30',
        mapper: (Map<String, dynamic> row) => InteractionModel(
            id: row['id'] as int,
            dateTime: row['dateTime'] as String,
            name: row['name'] as String,
            description: row['description'] as String,
            notes: row['notes'] as String));
  }

  @override
  Future<void> insertInteraction(InteractionModel interaction) async {
    await _interactionModelInsertionAdapter.insert(
        interaction, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateInteraction(InteractionModel interaction) async {
    await _interactionModelUpdateAdapter.update(
        interaction, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteInteraction(InteractionModel interaction) async {
    await _interactionModelDeletionAdapter.delete(interaction);
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
                  'pointType': item.pointType,
                  'item1': item.item1,
                  'item2': item.item2,
                  'item3': item.item3,
                  'item4': item.item4,
                  'item5': item.item5
                },
            changeListener),
        _pointModelUpdateAdapter = UpdateAdapter(
            database,
            'point',
            ['id'],
            (PointModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'pointType': item.pointType,
                  'item1': item.item1,
                  'item2': item.item2,
                  'item3': item.item3,
                  'item4': item.item4,
                  'item5': item.item5
                },
            changeListener),
        _pointModelDeletionAdapter = DeletionAdapter(
            database,
            'point',
            ['id'],
            (PointModel item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'pointType': item.pointType,
                  'item1': item.item1,
                  'item2': item.item2,
                  'item3': item.item3,
                  'item4': item.item4,
                  'item5': item.item5
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PointModel> _pointModelInsertionAdapter;

  final UpdateAdapter<PointModel> _pointModelUpdateAdapter;

  final DeletionAdapter<PointModel> _pointModelDeletionAdapter;

  @override
  Future<List<PointModel>> findAllPointModels() async {
    return _queryAdapter.queryList(
        'SELECT * FROM point ORDER BY pointType, name',
        mapper: (Map<String, dynamic> row) => PointModel(
            id: row['id'] as int,
            name: row['name'] as String,
            pointType: row['pointType'] as String,
            item1: row['item1'] as String,
            item2: row['item2'] as String,
            item3: row['item3'] as String,
            item4: row['item4'] as String,
            item5: row['item5'] as String));
  }

  @override
  Future<PointModel> findPointModelById(int id) async {
    return _queryAdapter.query('SELECT * FROM point WHERE id = ?',
        arguments: <dynamic>[id],
        mapper: (Map<String, dynamic> row) => PointModel(
            id: row['id'] as int,
            name: row['name'] as String,
            pointType: row['pointType'] as String,
            item1: row['item1'] as String,
            item2: row['item2'] as String,
            item3: row['item3'] as String,
            item4: row['item4'] as String,
            item5: row['item5'] as String));
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

class _$InteractionPointsModelDao extends InteractionPointsModelDao {
  _$InteractionPointsModelDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _interactionPointsModelInsertionAdapter = InsertionAdapter(
            database,
            'interaction_points',
            (InteractionPointsModel item) => <String, dynamic>{
                  'interactionId': item.interactionId,
                  'pointId': item.pointId,
                  'value': item.value
                },
            changeListener),
        _interactionPointsModelUpdateAdapter = UpdateAdapter(
            database,
            'interaction_points',
            ['interactionId', 'pointId'],
            (InteractionPointsModel item) => <String, dynamic>{
                  'interactionId': item.interactionId,
                  'pointId': item.pointId,
                  'value': item.value
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<InteractionPointsModel>
      _interactionPointsModelInsertionAdapter;

  final UpdateAdapter<InteractionPointsModel>
      _interactionPointsModelUpdateAdapter;

  @override
  Future<InteractionPointsModel> findInteractionPointByInteractionAndPointId(
      int interactionId, int pointId) async {
    return _queryAdapter.query(
        'SELECT * FROM interaction_points WHERE interactionId = ? AND pointId = ?',
        arguments: <dynamic>[interactionId, pointId],
        mapper: (Map<String, dynamic> row) => InteractionPointsModel(
            interactionId: row['interactionId'] as int,
            pointId: row['pointId'] as int,
            value: row['value'] as int));
  }

  @override
  Future<List<InteractionPointsModel>> findInteractionPointsByInteractionId(
      int interactionId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM interaction_points WHERE interactionId = ?',
        arguments: <dynamic>[interactionId],
        mapper: (Map<String, dynamic> row) => InteractionPointsModel(
            interactionId: row['interactionId'] as int,
            pointId: row['pointId'] as int,
            value: row['value'] as int));
  }

  @override
  Future<void> deleteInteractionPointsByInteractionId(int interactionId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM interaction_points WHERE interactionId = ?',
        arguments: <dynamic>[interactionId]);
  }

  @override
  Future<void> deleteInteractionPointsByInteractionAndPointId(
      int interactionId, int pointId) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM interaction_points WHERE interactionId = ? AND pointId = ?',
        arguments: <dynamic>[interactionId, pointId]);
  }

  @override
  Future<void> insertInteractionPoints(
      InteractionPointsModel interactionPoints) async {
    await _interactionPointsModelInsertionAdapter.insert(
        interactionPoints, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateInteractionPoints(
      InteractionPointsModel interactionPoints) async {
    await _interactionPointsModelUpdateAdapter.update(
        interactionPoints, OnConflictStrategy.abort);
  }
}

class _$InteractionSummaryDao extends InteractionSummaryDao {
  _$InteractionSummaryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<InteractionSummaryView>> findInteractionsSummary() async {
    return _queryAdapter.queryList('SELECT * FROM interaction_summary_view',
        mapper: (Map<String, dynamic> row) => InteractionSummaryView(
            row['id'] as int,
            row['name'] as String,
            row['dateTime'] as String,
            row['description'] as String,
            row['difficulty'] as double,
            row['skill'] as double,
            row['attraction'] as double,
            row['result'] as double));
  }

  @override
  Stream<List<InteractionSummaryView>> findInteractionsSummaryStream() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM interaction_summary_view',
        queryableName: 'interaction_summary_view',
        isView: true,
        mapper: (Map<String, dynamic> row) => InteractionSummaryView(
            row['id'] as int,
            row['name'] as String,
            row['dateTime'] as String,
            row['description'] as String,
            row['difficulty'] as double,
            row['skill'] as double,
            row['attraction'] as double,
            row['result'] as double));
  }
}

class _$InteractionPointsViewDao extends InteractionPointsViewDao {
  _$InteractionPointsViewDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<InteractionPointsView>> findInteractionsPointsByInteractionId(
      int interactionId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM interaction_points_view WHERE interactionId = ?',
        arguments: <dynamic>[interactionId],
        mapper: (Map<String, dynamic> row) => InteractionPointsView(
            interactionId: row['interactionId'] as int,
            pointId: row['pointId'] as int,
            pointName: row['pointName'] as String,
            pointValue: row['pointValue'] as int,
            pointType: row['pointType'] as String,
            item1: row['item1'] as String,
            item2: row['item2'] as String,
            item3: row['item3'] as String,
            item4: row['item4'] as String,
            item5: row['item5'] as String));
  }
}

class _$GoalsModelDao extends GoalsModelDao {
  _$GoalsModelDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _goalsModelUpdateAdapter = UpdateAdapter(
            database,
            'goals',
            ['id'],
            (GoalsModel item) => <String, dynamic>{
                  'id': item.id,
                  'weeklyInteractionGoal': item.weeklyInteractionGoal
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final UpdateAdapter<GoalsModel> _goalsModelUpdateAdapter;

  @override
  Future<GoalsModel> findGoalsModel() async {
    return _queryAdapter.query('SELECT * FROM goals',
        mapper: (Map<String, dynamic> row) =>
            GoalsModel(row['weeklyInteractionGoal'] as int));
  }

  @override
  Future<void> saveGoalsModel(GoalsModel goalsModel) async {
    await _goalsModelUpdateAdapter.update(goalsModel, OnConflictStrategy.abort);
  }
}

class _$ConfigModelDao extends ConfigModelDao {
  _$ConfigModelDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _configModelInsertionAdapter = InsertionAdapter(
            database,
            'config',
            (ConfigModel item) => <String, dynamic>{
                  'id': item.id,
                  'lastRunVersion': item.lastRunVersion
                },
            changeListener),
        _configModelUpdateAdapter = UpdateAdapter(
            database,
            'config',
            ['id'],
            (ConfigModel item) => <String, dynamic>{
                  'id': item.id,
                  'lastRunVersion': item.lastRunVersion
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ConfigModel> _configModelInsertionAdapter;

  final UpdateAdapter<ConfigModel> _configModelUpdateAdapter;

  @override
  Future<ConfigModel> findConfigModel() async {
    return _queryAdapter.query('SELECT * FROM config',
        mapper: (Map<String, dynamic> row) =>
            ConfigModel(lastRunVersion: row['lastRunVersion'] as int));
  }

  @override
  Future<void> insertConfigModel(ConfigModel configModel) async {
    await _configModelInsertionAdapter.insert(
        configModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> saveConfigModel(ConfigModel configModel) async {
    await _configModelUpdateAdapter.update(
        configModel, OnConflictStrategy.abort);
  }
}
