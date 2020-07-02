// Isto aqui NÃO CONHECE o banco de dados

import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:cold_app/domain/entities/approach/point_entity.dart';

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

class GetAllApproaches {
  // Future<List<ApproachEntity>> call() async {
  //   List<ApproachEntity> list = [
  //     ApproachEntity(
  //       id: 1,
  //       dateTime: DateTime(2020, 01, 17),
  //       name: 'Bruna',
  //       description: 'The Brunette',
  //       notes: 'A high staking girl',
  //       points: [
  //         PointEntity(id: 1, name: 'Contato visual', pointType: PointType.skill, value: 7),
  //         PointEntity(id: 2, name: 'Postura física', pointType: PointType.skill, value: 10),
  //         PointEntity(id: 3, name: 'Atração', pointType: PointType.attraction, value: 7),
  //         PointEntity(id: 4, name: 'Resultado', pointType: PointType.result, value: 9),
  //       ],
  //     )
  //   ];

  //   return list;
  // }
}
