import 'package:cold_app/data/services/floor/floor_database.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

const bool USE_TEST_IMPLEMENTATION = true;

void setupLocator() {
  // locator.registerSingleton<LocatorDatabase>(LocatorDatabase());
  locator.registerLazySingleton<LocatorDatabase>(() => LocatorDatabase());
  // locator.registerFactory<LocatorDatabase>(() => LocatorDatabase());
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

  Future<AppDatabase> getDatabase() async {
    print('_isInstanciated');
    print(_isInstanciated.toString());
    if (!_isInstanciated) {
      if (USE_TEST_IMPLEMENTATION) {
        _database = await $FloorAppDatabase.inMemoryDatabaseBuilder().addCallback(callback).build();
        await resetDatabase(_database);
        List<dynamic> a = await _database.database.rawQuery('SELECT * FROM approach');
        // List<dynamic> a = await _database.database.rawQuery('SELECT * FROM approach');
        //
        print('db created');
        a.forEach((e) {
          print(e);
        });
        print('end print');
        // _database.dr;
        //   print('Created DB');
        //  ApproachFloorGateway floorGateway = ApproachFloorGateway();
        //   List<ApproachModel> list = await floorGateway.getAllApproach();
        //   list.forEach((element) {
        //     print(element.toJson());
        //   });
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
