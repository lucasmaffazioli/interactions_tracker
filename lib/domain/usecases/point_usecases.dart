import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/data/services/floor/floor_gateway.dart';
import 'package:flutter/foundation.dart';

PointFloorGateway pointFloorGateway = PointFloorGateway();

// class SavePoint {
//   void call(PointEntity point) async {}
// }

// class GetPoint {}

class GetAllPoints {
  Future<List<PointPresentation>> call() async {
    final List<PointModel> pointsModel = await pointFloorGateway.getAllPoint();
    List<PointPresentation> pointsPresentation = [];

    pointsModel.forEach((element) {
      if (element.pointType == 'skill')
        pointsPresentation.add(PointPresentation(id: element.id, name: element.name));
    });

    return pointsPresentation;
  }
}

class PointPresentation {
  final int id;
  final String name;

  PointPresentation({
    @required this.id,
    @required this.name,
  });
}
