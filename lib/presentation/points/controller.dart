import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/domain/entities/interaction/point_entity.dart';
import 'package:cold_app/domain/usecases/point_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PointsController {
  Future<List<PointPresentation>> getAllPoints() async {
    final List<PointEntity> pointsModel = await GetAllPoints().call();

    List<PointPresentation> pointsPresentation = [];

    pointsModel.forEach((element) {
      pointsPresentation.add(PointPresentation(
        id: element.id,
        iconData: getPointTypeIcon(element.pointType),
        name: element.name,
        pointType: element.pointType,
        item1: element.item1,
        item2: element.item2,
        item3: element.item3,
        item4: element.item4,
        item5: element.item5,
      ));
    });

    return pointsPresentation;
  }
}

class PointPresentation {
  final int id;
  final IconData iconData;
  final String name;
  final PointType pointType;
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;

  PointPresentation({
    @required this.id,
    @required this.iconData,
    @required this.name,
    @required this.pointType,
    @required this.item1,
    @required this.item2,
    @required this.item3,
    @required this.item4,
    @required this.item5,
  });
}
