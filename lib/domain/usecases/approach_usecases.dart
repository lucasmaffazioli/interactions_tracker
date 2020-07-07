// Isto aqui NÃO CONHECE o banco de dados

import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:cold_app/data/models/approach/approach_points_model.dart';
import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:cold_app/domain/entities/approach/point_entity.dart';

PointFloorGateway pointFloorGateway = PointFloorGateway();
ApproachFloorGateway approachFloorGateway = ApproachFloorGateway();
ApproachPointsFloorGateway approachPointsFloorGateway = ApproachPointsFloorGateway();
ApproachSummaryViewFloorGateway approachViewsFloorGateway = ApproachSummaryViewFloorGateway();
ApproachPointsViewFloorGateway approachPointsViewFloorGateway = ApproachPointsViewFloorGateway();
ApproachSummaryViewFloorGateway approachSummaryViewFloorGateway = ApproachSummaryViewFloorGateway();

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

    // TODO - ERROR HANDLING
    if (approachId != null && approachId != 0) {
      approach.points.forEach((element) async {
        try {
          await approachPointsFloorGateway.insertApproachPoints(ApproachPointsModel(
            approachId: approachId,
            pointId: element.id,
            value: element.id,
          ));
        } catch (e) {
          print('Erro ao inserir pontos! ' + e.toString());
        }
      });
    }

    //
    //

    ApproachEntity ap = await GetApproach().call(approachId);
    print('Inserted approach:');
    print(ap.toJson());
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
          id: null,
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

      List<PointModel> allPointsModel = await pointFloorGateway.getAllPoint();
      allPointsModel.forEach((element) {
        print(element.toJson());
      });
      //
      //
      approachPointsView.forEach((element) {
        print(element.toJson());
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

class GetAllSummaryApproaches {
  Future<List<ApproachSummaryView>> call() async {
    //
    List<ApproachSummaryView> approachesView =
        await approachSummaryViewFloorGateway.findApproachesSummary();

    return approachesView;
  }
}

class GetAllApproaches {
  Future<List<ApproachModel>> call() async {
    //
    List<ApproachModel> approaches = await approachFloorGateway.getAllApproach();

    return approaches;
  }
}
