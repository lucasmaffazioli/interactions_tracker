// Isto aqui NÃO CONHECE o banco de dados

import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:cold_app/domain/entities/approach/point_entity.dart';

PointFloorGateway pointFloorGateway = PointFloorGateway();
ApproachFloorGateway approachFloorGateway = ApproachFloorGateway();
ApproachPointsFloorGateway approachPointsFloorGateway = ApproachPointsFloorGateway();
ApproachSummaryViewFloorGateway approachViewsFloorGateway = ApproachSummaryViewFloorGateway();
ApproachPointsViewFloorGateway approachPointsViewFloorGateway = ApproachPointsViewFloorGateway();

// class DeleteApproach {
//   void call(String uid) async {
//     await LocalDatastore().deleteApproach(uid);
//   }
// }

class SaveApproach {
  void call(ApproachEntity approach) async {
    // dynamic lol = await LocalDatastore().setApproach(uid, approach);
    print('Save approach');
    print(approach.toJson());

    int approachId = await approachFloorGateway.insertApproach(ApproachModel(
      id: approach.id,
      name: approach.name,
      dateTime: approach.dateTime.toIso8601String(),
      description: approach.description,
      notes: approach.notes,
    ));
    
    
    ERROR HANDLING
  }
}

class GetApproach {
  Future<ApproachEntity> call(int id) async {
    ApproachModel approachModel;
    //
    ApproachEntity approach;
    List<PointEntity> points = [];
    //
    print('call');
    print(id);
    //
    if (id == null) {
      List<PointModel> allPointsModel = await pointFloorGateway.getAllPoint();
      allPointsModel.forEach((element) {
        points.add(PointEntity(
          id: element.id,
          name: element.name,
          pointType: getPointTypeWithString(element.pointType),
          value: 0,
        ));
        approach = ApproachEntity(
          id: 0,
          name: '',
          description: '',
          dateTime: DateTime.now(),
          points: points,
        );
      });
    } else {
      approachModel = await approachFloorGateway.getApproachById(id);
      List<ApproachPointsView> approachPointsView =
          await approachPointsViewFloorGateway.findApproachesPointsByApproachId(id);
      //
      //
      approachPointsView.forEach((element) {
        points.add(PointEntity(
          id: element.pointId,
          name: element.pointName,
          pointType: getPointTypeWithString(element.pointType),
          value: element.pointValue,
        ));
        approach = ApproachEntity(
          id: approachModel.id,
          name: approachModel.name,
          description: approachModel.description,
          dateTime: DateTime.parse(approachModel.dateTime),
          points: points,
        );
      });
    }
    //
    //
    //
    print('Approach_usecases');
    print('approach.toJson()');
    print(approach.toJson());
    approach.points.forEach((element) {
      print(element.toJson());
    });
    //
    return approach;
  }
}

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
