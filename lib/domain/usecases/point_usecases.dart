import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:cold_app/domain/entities/approach/point_entity.dart';

PointFloorGateway pointFloorGateway = PointFloorGateway();

class SavePoint {
  void call(int id, String name, PointType pointType, String item1, String item2, String item3,
      String item4, String item5) async {
    PointType _pointType = pointType;
    if (pointType == null) {
      _pointType = PointType.skill;
    }

    await pointFloorGateway.savePoint(PointModel(
      id: id,
      name: name,
      pointType: _pointType.toString(),
      item1: item1,
      item2: item2,
      item3: item3,
      item4: item4,
      item5: item5,
    ));
  }
}

class DeletePoint {
  void call(int id) async {
    if (id != null && id != 0) {
      await pointFloorGateway.deletePointById(id);
    }
  }
}

class GetAllPoints {
  Future<List<PointEntity>> call() async {
    List<PointEntity> returnList = [];
    List<PointModel> pointModels = await pointFloorGateway.getAllPoint();

    pointModels.forEach((element) {
      print(element.pointType);
      returnList.add(PointEntity(
        id: element.id,
        name: element.name,
        pointType: getPointTypeFromString(element.pointType),
        item1: element.item1,
        item2: element.item2,
        item3: element.item3,
        item4: element.item4,
        item5: element.item5,
      ));
    });

    return returnList;
  }
}
