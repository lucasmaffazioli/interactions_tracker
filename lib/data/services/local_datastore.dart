import 'package:cold_app/domain/entities/approach/approach.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class LocalDatastore {
  // File path to a file in the current directory
  String dbPath = 'sample.db';
  DatabaseFactory dbFactory = databaseFactoryIo;

  Future<Map> getApproach(String uid) async {
    Database db = await dbFactory.openDatabase(dbPath);
    var store = StoreRef.main();
    return await store.record(uid).get(db) as Map;
  }

  Future<dynamic> setApproach(String uid, Map mapApproach) async {
    Database db = await dbFactory.openDatabase(dbPath);
    var store = StoreRef.main();
    return await store.record(uid).put(db, mapApproach);
  }

  Future<Approach> deleteApproach(String uid) async {}
}
