import 'dart:async';
import 'package:cold_app/domain/entities/approach/approach.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class LocalDatastore {
  // static final LocalDatastore _singleton = LocalDatastore._();

  // File path to a file in the current directory
  static final String dbPath = 'sample.db';
  DatabaseFactory dbFactory = databaseFactoryIo;
  final _approachFolder = intMapStoreFactory.store(dbPath);

  // Future<Database> get _db async => await LocalDatastore.instance.database;

  // A private constructor. Allows us to create instances of LocalDatastore
  // only from within the LocalDatastore class itself.
  // LocalDatastore._();

  Future<Map> getApproach(String uid) async {
    Database db = await dbFactory.openDatabase(dbPath);
    var store = StoreRef.main();
    return await store.record(uid).get(db) as Map;
  }

  Future<List<Map<String, dynamic>>> getAllApproaches() async {
    Database db = await dbFactory.openDatabase(dbPath);
    final recordSnapshot = await _approachFolder.find(await db);
    return recordSnapshot.map((snapshot) {
      final record = snapshot.value;
      return record;
    }).toList();

    // return recordSnapshot;
  }

  Future<dynamic> setApproach(String uid, Map mapApproach) async {
    final Database db = await dbFactory.openDatabase(dbPath);
    var store = StoreRef.main();
    return await store.record(uid).put(db, mapApproach);
  }

  Future<Approach> deleteApproach(String uid) async {}
}
