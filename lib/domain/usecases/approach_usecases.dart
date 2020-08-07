// Isto aqui NÃO CONHECE o banco de dados

import 'dart:convert';

import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/approach/approach_model.dart';
import 'package:cold_app/data/models/approach/approach_points_model.dart';
import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/data/services/storage.dart';
import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:cold_app/presentation/common/constants.dart';

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
    ApproachModel approachFromDb;
    print('Save approach');
    print(approach.toJson());

    ///
    /// For the case of a import from backup approach
    if (approach.id != null && approach.id != 0) {
      approachFromDb = await approachFloorGateway.getApproachById(approach.id);
    }

    if (approach.id == null || approach.id == 0 || approachFromDb == null) {
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

class ExportAllApproachesJson {
  Future<String> call() async {
    List<ApproachModel> listModels = await approachFloorGateway.getAllApproaches();
    List<ApproachEntity> listApproach = [];
    List<Map> listMap = [];

    for (ApproachModel e in listModels) {
      listApproach.add(await GetApproach().call(e.id));
      print('e');
      print(e.toJson());
    }

    if (listApproach != null) {
      listApproach.forEach((element) {
        listMap.add(element.toMap());
      });

      print('json.encode(listMap)');
      print(json.encode(listMap));
    }
    print('Saving file to:');
    final String savedPath =
        await Storage().saveExternalFile('Approaches.json', json.encode(listMap));
    print(savedPath);

    return savedPath;
  }
}

class ImportApproachesJson {
  Future<int> call() async {
    // List<Map<dynamic>> listMap;
    final String source = await Storage().readExternalFile('Approaches.json');

    final List<dynamic> listMap = json.decode(source);

    for (dynamic e in listMap) {
      final ApproachEntity approach = ApproachEntity.fromMap(e);

      if (listMap == null) print(listMap);

      await SaveApproach().call(approach);

      print('approach.toJson()');
      print(approach.toJson());
    }
    print(listMap);

    return listMap.length;
  }
}

class GetApproach {
  Future<ApproachEntity> call(int id) async {
    ApproachModel approachModel;
    //
    ApproachEntity approach;
    List<ApproachPointEntity> points = [];
    //
    if (id == null) {
      List<PointModel> allPointsModel = await pointFloorGateway.getAllPoint();
      allPointsModel.forEach((element) {
        points.add(ApproachPointEntity(
          id: element.id,
          name: element.name,
          pointType: getPointTypeFromString(element.pointType),
          value: Constants.minPoints,
          item1: element.item1,
          item2: element.item2,
          item3: element.item3,
          item4: element.item4,
          item5: element.item5,
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
        points.add(ApproachPointEntity(
          id: element.pointId,
          name: element.pointName,
          pointType: getPointTypeFromString(element.pointType),
          value: element.pointValue,
          item1: element.item1,
          item2: element.item2,
          item3: element.item3,
          item4: element.item4,
          item5: element.item5,
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
