// Isto aqui NÃO CONHECE o banco de dados

// class DeleteApproach {
//   void call(String uid) async {
//     await LocalDatastore().deleteApproach(uid);
//   }
// }

// class SetApproach {
//   void call(String uid, Approach approach) async {
//     dynamic lol = await LocalDatastore().setApproach(uid, approach);
//     // print('Set approach');
//     // print(lol.toString());
//   }
// }

// class GetApproach {
//   Future<Approach> call(String uid) async {
//     Map map = await LocalDatastore().getApproach(uid);
//     print('map.toString()');
//     print(map.toString());
//     // return Approach.fromMap(uid, map);
//   }
// }

// class GetAllApproaches {
//   dynamic call(String uid) async {
//     // Map map = await LocalDatastore().getAllApproaches();
//     dynamic map = await LocalDatastore().getAllApproaches();
//     print(map.toString());
//     return map;
//   }
// }
