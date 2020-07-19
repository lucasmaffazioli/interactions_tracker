import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:flutter/foundation.dart';

PointFloorGateway pointFloorGateway = PointFloorGateway();

class SavePoint {
  void call(int id, String name, String pointType) async {
    String _pointType = pointType;
    if (pointType == null) {
      _pointType = 'skill';
    }

    await pointFloorGateway.savePoint(PointModel(
      id: id,
      name: name,
      pointType: _pointType,
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

// class GetPoint {}

class GetAllPoints {
  Future<List<PointModel>> call() async {
    return await pointFloorGateway.getAllPoint();
  }
}

class PointPresentation {
  final int id;
  final String name;
  final String pointType;

  PointPresentation({
    @required this.id,
    @required this.name,
    @required this.pointType,
  });
}
