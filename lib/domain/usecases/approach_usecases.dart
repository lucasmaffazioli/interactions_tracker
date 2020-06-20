// Isto aqui NÃO CONHECE o banco de dados
import 'package:cold_app/data/services/local_datastore.dart';
import 'package:cold_app/domain/entities/approach/approach.dart';

class DeleteApproach {
  void call(String uid) async {
    await LocalDatastore().deleteApproach(uid);
  }
}

class SetApproach {
  void call(String uid, Approach approach) async {
    Map<String, dynamic> newApproach = approach.toMap();
    print('newApproach.toString()');
    print(newApproach.toString());
    dynamic lol = await LocalDatastore().setApproach(uid, newApproach);
    // print('Set approach');
    // print(lol.toString());
  }
}

class GetApproach {
  Future<Approach> call(String uid) async {
    Map map = await LocalDatastore().getApproach(uid);
    print('map.toString()');
    print(map.toString());
    return Approach.fromMap(uid, map);
  }
}

class GetAllApproaches {
  dynamic call(String uid) async {
    // Map map = await LocalDatastore().getAllApproaches();
    dynamic map = await LocalDatastore().getAllApproaches();
    print(map.toString());
    return map;
  }
}
