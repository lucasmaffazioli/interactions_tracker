import 'package:cold_app/data/services/floor/floor_database.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

bool USE_TEST_IMPLEMENTATION = true;

void setupLocator() {
  locator.registerSingleton<LocatorDatabase>(LocatorDatabase());
  // locator.registerLazySingleton<LocatorDatabase>(() => LocatorDatabase());
  // locator.registerFactory<LocatorDatabase>(() => LocatorDatabase());
}

void closeDb() {
  locator.get<LocatorDatabase>().closeDb();
}

// void resetLocator() async {
//   // locator.registerLazySingleton<LocatorDatabase>(() => new LocatorDatabase());
//   locator.resetLazySingleton<LocatorDatabase>(
//     instance: locator<LocatorDatabase>(),
//   );        void Function(T) disposingFunction})
// }

class LocatorDatabase {
  bool _isInstanciated = false;
  AppDatabase _database;

  void closeDb() {
    if (_database != null) _database.close();
  }

  Future<AppDatabase> getDatabase() async {
    print('_isInstanciated');
    print(_isInstanciated);

    if (!_isInstanciated) {
      if (USE_TEST_IMPLEMENTATION) {
        _database =
            await $FloorAppDatabase.inMemoryDatabaseBuilder().addCallback(dbCallback).build();
        // await resetDatabase(_database);
        // print('reseted DB');
        //
        List<dynamic> a = await _database.database.rawQuery('SELECT * FROM point');
        a != null ?? print('some error in resetting db');
        //
      } else {
        _database = await $FloorAppDatabase
            .databaseBuilder('app_database.db')
            .addCallback(dbCallback)
            .build();
      }
      _isInstanciated = true;
    }
    print(_isInstanciated);
    return _database;
  }
}
