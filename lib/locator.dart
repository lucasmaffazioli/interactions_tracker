import 'package:cold_app/data/services/floor/floor_database.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

const bool USE_TEST_IMPLEMENTATION = true;

void setupLocator() async {
  // locator.registerSingleton<LocatorDatabase>(LocatorDatabase());
  locator.registerLazySingleton<LocatorDatabase>(() => LocatorDatabase());
}

void resetLocator() async {
  // locator.registerLazySingleton<LocatorDatabase>(() => new LocatorDatabase());
  locator.resetLazySingleton<LocatorDatabase>(
    instance: locator<LocatorDatabase>(),
  );

  // locator.resetLazySingleton<T>({Object instance,
  //                           String instanceName,
  //                           void Function(T) disposingFunction})
}

class LocatorDatabase {
  bool _isInstanciated = false;
  AppDatabase _database;

  Future<AppDatabase> getDatabase() async {
    print('_isInstanciated');
    print(_isInstanciated.toString());
    if (!_isInstanciated) {
      if (USE_TEST_IMPLEMENTATION) {
        _database = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
        // _database.dr;
      } else {
        _database = await $FloorAppDatabase
            .databaseBuilder('app_database.db')
            .addCallback(callback)
            .build();
      }

      _isInstanciated = true;
    }

    return _database;
  }
}
