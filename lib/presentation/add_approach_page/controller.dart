import 'package:cold_app/core/app_localizations.dart';
import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:cold_app/domain/usecases/approach_usecases.dart';
import 'package:flutter/material.dart';
import 'package:cold_app/domain/entities/approach/point_entity.dart';

class AddApproachController {
  Future<ApproachPresentation> getApproach(context) async {
    ApproachEntity approachEntity = await GetApproach().call(null);
    //
    List<PointPresentation> pointPresentationList = [];
    //
    PointType lastPointType;
    //
    approachEntity.points.forEach((element) {
      // if (lastPointType != element.pointType) {
      if (PointType.skill == element.pointType && lastPointType != element.pointType) {
        pointPresentationList.add(PointPresentation(
          isHeader: true,
          headerTitle: element.pointType.toString(),
          headerIcon: getPointTypeIcon(element.pointType),
        ));
      }
      if (PointType.skill == lastPointType && PointType.skill != element.pointType) {
        pointPresentationList.add(PointPresentation(
          isHeader: true,
          headerTitle: AppLocalizations.of(context).translate('other_point_type'),
          headerIcon: null,
        ));
      }
      //
      pointPresentationList.add(PointPresentation(
        isHeader: false,
        id: element.id,
        name: element.name,
        pointType: element.pointType,
        value: element.value,
        headerIcon: getPointTypeIcon(element.pointType),
        fullTitle: element.pointType == PointType.skill ? false : true,
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

  void saveApproach(ApproachPresentation approachPresentation) async {
    final DateTime dateTime = DateTime(
        approachPresentation.date.year,
        approachPresentation.date.month,
        approachPresentation.date.second,
        approachPresentation.time.hour,
        approachPresentation.time.minute);
    List<PointEntity> points = [];

    print('Saving approach');
    print(approachPresentation.date);
    print(approachPresentation.time);
    print(dateTime.toString());
    approachPresentation.points.forEach((element) {
      print(element.isHeader.toString());
      print(element.name);
      print(element.value);
      //
      if (!element.isHeader)
        points.add(PointEntity(
            id: element.id,
            name: element.name,
            pointType: element.pointType,
            value: element.value));
    });
    //
    //
    //
    ApproachEntity approachEntity = ApproachEntity(
      id: approachPresentation.id,
      dateTime: dateTime,
      name: approachPresentation.name,
      description: approachPresentation.description,
      notes: approachPresentation.notes,
      points: points,
    );
    //
    await SaveApproach().call(approachEntity);
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
  final bool fullTitle;
  int value;

  PointPresentation(
      {this.id,
      this.name,
      this.value,
      this.pointType,
      @required this.isHeader,
      this.headerTitle,
      this.headerIcon,
      this.fullTitle});
}
