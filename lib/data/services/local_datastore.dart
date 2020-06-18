import 'package:cold_app/domain/entities/approach/approach.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class LocalDatastore {
  // File path to a file in the current directory
  String dbPath = 'sample.db';
  DatabaseFactory dbFactory = databaseFactoryIo;

  Future<Approach> getApproach(String uid) async {
    Database db = await dbFactory.openDatabase(dbPath);
    var store = StoreRef.main();
    return await store.record('title').get(db) as Approach;
  }

  Future<Approach> setApproach(String uid, Approach) async {
    // Database db = await dbFactory.openDatabase(dbPath);
    // var store = StoreRef.main();
    // return await store.record('title').get(db) as Approach;
  }
}
