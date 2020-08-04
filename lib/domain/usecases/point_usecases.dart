import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:flutter/foundation.dart';

PointFloorGateway pointFloorGateway = PointFloorGateway();

class SavePoint {
  void call(int id, String name, String pointType, String item1, String item2, String item3,
      String item4, String item5) async {
    String _pointType = pointType;
    if (pointType == null) {
      _pointType = 'skill';
    }

    await pointFloorGateway.savePoint(PointModel(
      id: id,
      name: name,
      pointType: _pointType,
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
  Future<List<PointModel>> call() async {
    return await pointFloorGateway.getAllPoint();
  }
}

class PointPresentation {
  final int id;
  final String name;
  final String pointType;
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;

  PointPresentation({
    @required this.id,
    @required this.name,
    @required this.pointType,
    @required this.item1,
    @required this.item2,
    @required this.item3,
    @required this.item4,
    @required this.item5,
  });
}
