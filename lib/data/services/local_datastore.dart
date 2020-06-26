import 'dart:async';
import 'package:cold_app/domain/entities/approach/approach.dart';

class LocalDatastore {
  Future<Map> getApproach(String uid) async {
    // Database db = await dbFactory.openDatabase(dbPath);
    // var store = StoreRef.main();
    // return await store.record(uid).get(db) as Map;
  }

  Future<List<Map<String, dynamic>>> getAllApproaches() async {
    // Database db = await dbFactory.openDatabase(dbPath);
    // final recordSnapshot = await _approachFolder.find(await db);
    // return recordSnapshot.map((snapshot) {
    //   final record = snapshot.value;
    //   return record;
    // }).toList();

    // return recordSnapshot;
  }

  Future<dynamic> setApproach(String uid, Approach approach) async {}

  Future<Approach> deleteApproach(String uid) async {}
}
