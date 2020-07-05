import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:cold_app/domain/usecases/approach_usecases.dart';
import 'package:flutter/material.dart';

class AddApproachController {
  Future<ApproachPresentation> getApproach() async {
    ApproachEntity approachEntity = await GetApproach().call(null);
    //
    List<PointPresentation> pointPresentationList = [];
    //
    PointType lastPointType;
    approachEntity.points.forEach((element) {
      if (lastPointType != element.pointType) {
        pointPresentationList.add(PointPresentation(
          isHeader: true,
          headerTitle: element.pointType.toString(),
          headerIcon: getPointTypeIcon(element.pointType),
        ));
      }
      //
      pointPresentationList.add(PointPresentation(
        isHeader: false,
        id: element.id,
        name: element.name,
        pointType: element.pointType,
        value: element.value,
      ));
      //
      lastPointType = element.pointType;
    });

    ApproachPresentation approachPresentation = ApproachPresentation(
      id: approachEntity.id,
      date: approachEntity.dateTime,
      time: TimeOfDay.fromDateTime(approachEntity.dateTime),
      name: approachEntity.name,
      description: approachEntity.description,
      notes: approachEntity.notes,
      points: pointPresentationList,
    );

    print(approachPresentation.name);
    approachPresentation.points.forEach((element) {
      print(element.isHeader.toString());
      print(element.headerTitle);
      print(element.name);
    });

    print(approachPresentation);

    return approachPresentation;
  }
}

class ApproachPresentation {
  int id;
  DateTime date;
  TimeOfDay time;
  String name;
  String description;
  String notes;
  List<PointPresentation> points;

  ApproachPresentation(
      {this.id, this.date, this.time, this.name, this.description, this.notes, this.points});
}

class PointPresentation {
  final bool isHeader;
  final String headerTitle;
  final IconData headerIcon;
  final PointType pointType;
  final int id;
  final String name;
  int value;

  PointPresentation({
    this.id,
    this.name,
    this.value,
    this.pointType,
    @required this.isHeader,
    this.headerTitle,
    this.headerIcon,
  });
}
