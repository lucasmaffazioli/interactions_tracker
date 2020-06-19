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
    Map newApproach = approach.toMap();
    dynamic lol = await LocalDatastore().setApproach(uid, newApproach);
    print('Set approach');
    print(lol.toString());
  }
}

class GetApproach {
  Future<Approach> call(String uid) async {
    Map map = await LocalDatastore().getApproach(uid);
    print(map.toString());
    // return
  }
}
