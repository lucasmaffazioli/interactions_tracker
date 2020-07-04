import 'package:cold_app/core/enums/PointType.dart';
import 'package:flutter/material.dart';

class ApproachData {
  DateTime date;
  TimeOfDay time;
  String name;
  String description;
  String notes;
  List<Points> points;
}

class AddApproachController {
  List<Points> getAllPoints() {
    List<Points> list = [];

    list.add(Points(PointType.skill, [
      PointItem(3, 'Contato Visual'),
      PointItem(4, 'Postura física'),
    ]));
    list.add(Points(PointType.attraction, [PointItem(1, 'Atração')]));
    list.add(Points(PointType.result, [PointItem(2, 'Resultado')]));

    return list;
  }
}

class Points {
  final PointType pointType;
  final List<PointItem> point;

  Points(this.pointType, this.point);
}

class PointItem {
  final int id;
  final String title;

  PointItem(this.id, this.title);
}
