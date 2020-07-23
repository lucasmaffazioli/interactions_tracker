// Isto aqui NÃO CONHECE o banco de dados

import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:cold_app/data/models/approach/approach_points_model.dart';
import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:cold_app/domain/entities/approach/point_entity.dart';

ApproachFloorGateway approachFloorGateway = ApproachFloorGateway();
ApproachPointsFloorGateway approachPointsFloorGateway = ApproachPointsFloorGateway();
PointFloorGateway pointFloorGateway = PointFloorGateway();
ApproachPointsViewFloorGateway approachPointsViewFloorGateway = ApproachPointsViewFloorGateway();
ApproachSummaryViewFloorGateway approachSummaryViewFloorGateway = ApproachSummaryViewFloorGateway();

class DeleteApproach {
  Future<void> call(int id) async {
    return await approachFloorGateway
        .deleteApproach(ApproachModel(id: id, name: '', description: '', dateTime: ''));
  }
}

class SaveApproach {
  void call(ApproachEntity approach) async {
    int approachId;
    print('Save approach');
    print(approach.toJson());

    if (approach.id == null || approach == 0) {
      approachId = await approachFloorGateway.insertApproach(ApproachModel(
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
              value: element.value,
            ));
          } catch (e) {
            print('Erro ao inserir pontos! ' + e.toString());
          }
        });
      }
    } else {
      approachId = approach.id;
      await approachFloorGateway.updateApproach(ApproachModel(
        id: approach.id,
        name: approach.name,
        dateTime: approach.dateTime.toIso8601String(),
        description: approach.description,
        notes: approach.notes,
      ));

      if (approachId != null && approachId != 0) {
        approach.points.forEach((element) async {
          try {
            await approachPointsFloorGateway.updateApproachPoints(ApproachPointsModel(
              approachId: approachId,
              pointId: element.id,
              value: element.value,
            ));
          } catch (e) {
            print('Erro ao inserir pontos! ' + e.toString());
          }
        });
      }
    }

    //
    //

    // ApproachEntity ap = await GetApproach().call(approachId);
    // print('Inserted approach:');
    // print(ap.toJson());
  }
}

class GetApproach {
  Future<ApproachEntity> call(int id) async {
    ApproachModel approachModel;
    //
    ApproachEntity approach;
    List<PointEntity> points = [];
    //
    // print('call');
    // print(id);
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

      // List<PointModel> allPointsModel = await pointFloorGateway.getAllPoint();
      // allPointsModel.forEach((element) {
      //   print(element.toJson());
      // });
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
          notes: approachModel.notes,
          dateTime: DateTime.parse(approachModel.dateTime),
          points: points,
        );
      });
    }
    //
    return approach;
  }
}

class GetAllSummaryApproachesStream {
  Stream<List<ApproachSummaryView>> call() {
    return approachSummaryViewFloorGateway.findApproachesSummaryStream();
  }
}
