import 'package:cold_app/data/services/floor/floor_database.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {
  dynamic _database;
  _database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').addCallback(dbCallback).build();
  locator.registerSingleton<AppDatabase>(_database);
}

void setupLocatorTest() async {
  dynamic _database;
  _database = await $FloorAppDatabase.inMemoryDatabaseBuilder().addCallback(dbCallback).build();
  locator.registerSingleton<AppDatabase>(_database);
}

void closeDb() {
  locator.get<AppDatabase>().close();
}
