import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/domain/entities/approach/approach_entity.dart';
import 'package:cold_app/domain/usecases/approach_usecases.dart';
import 'package:flutter/material.dart';
import 'package:cold_app/domain/entities/approach/point_entity.dart';

class AddApproachController {
  Future<ApproachPresentation> getApproach(context, approachId) async {
    ApproachEntity approachEntity = await GetApproach().call(approachId);
    //
    List<PointPresentation> pointPresentationList = [];
    //
    PointType lastPointType;
    //
    print('controller.dart: approachEntity.toJson()');
    print(approachEntity.toJson());
    //
    approachEntity.points.forEach((element) {
      if (element.pointType == PointType.skill) {
        if (lastPointType != element.pointType) {
          pointPresentationList.add(PointPresentation(
            isHeader: true,
            headerTitle: element.pointType.toString(),
            headerIcon: getPointTypeIcon(element.pointType),
          ));
        }
        pointPresentationList.add(
          PointPresentation(
            isHeader: false,
            id: element.id,
            name: element.name,
            pointType: element.pointType,
            value: element.value,
            headerIcon: getPointTypeIcon(element.pointType),
            fullTitle: element.pointType == PointType.skill ? false : true,
            item1: element.item1,
            item2: element.item2,
            item3: element.item3,
            item4: element.item4,
            item5: element.item5,
          ),
        );

        lastPointType = element.pointType;
      }
    });
    //
    //
    pointPresentationList.add(PointPresentation(
      isHeader: true,
      headerTitle: 'Other'.i18n,
      headerIcon: null,
    ));
    approachEntity.points.forEach((element) {
      if (element.pointType != PointType.skill) {
        if (lastPointType != element.pointType) {
          //
          pointPresentationList.add(PointPresentation(
            isHeader: false,
            id: element.id,
            name: element.name,
            pointType: element.pointType,
            value: element.value,
            headerIcon: getPointTypeIcon(element.pointType),
            fullTitle: element.pointType == PointType.skill ? false : true,
            item1: element.item1,
            item2: element.item2,
            item3: element.item3,
            item4: element.item4,
            item5: element.item5,
          ));
        }
      }
    });
    //
    //
    //
    ApproachPresentation approachPresentation = ApproachPresentation(
      id: approachEntity.id,
      date: approachEntity.dateTime.toLocal(),
      time: TimeOfDay.fromDateTime(approachEntity.dateTime),
      name: approachEntity.name,
      description: approachEntity.description,
      notes: approachEntity.notes,
      points: pointPresentationList,
    );

    // print(approachPresentation.name);
    // approachPresentation.points.forEach((element) {
    //   print(element.isHeader.toString());
    //   print(element.headerTitle);
    //   print(element.name);
    // });

    // print(approachPresentation);

    return approachPresentation;
  }

  void saveApproach(ApproachPresentation approachPresentation) async {
    print('save app1');
    print(approachPresentation.date);
    print(approachPresentation.date.toString());
    print(approachPresentation.date.toIso8601String());
    print(approachPresentation.date.day.toString());

    final DateTime dateTime = DateTime(
      approachPresentation.date.year,
      approachPresentation.date.month,
      approachPresentation.date.day,
      approachPresentation.time.hour,
      approachPresentation.time.minute,
      approachPresentation.date.second,
    );
    List<ApproachPointEntity> points = [];

    // print('Saving approach');
    // print(approachPresentation.date);
    // print(approachPresentation.time);
    // print(dateTime.toString());
    approachPresentation.points.forEach((element) {
      print('forEach presentation points');
      print(element.name);
      print(element.value);
      //
      if (!element.isHeader)
        points.add(ApproachPointEntity(
          id: element.id,
          name: element.name,
          pointType: element.pointType,
          value: element.value,
          item1: element.item1,
          item2: element.item2,
          item3: element.item3,
          item4: element.item4,
          item5: element.item5,
        ));
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
    // if (approachEntity.id == null) await SaveApproach().call(approachEntity);
    // if (approachEntity.id == null) await SaveApproach().call(approachEntity);
    // if (approachEntity.id == null) await SaveApproach().call(approachEntity);
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
  final bool fullTitle;
  final String headerTitle;
  final IconData headerIcon;
  final PointType pointType;
  final int id;
  final String name;
  final String item1;
  final String item2;
  final String item3;
  final String item4;
  final String item5;
  int value;

  PointPresentation({
    this.id,
    this.name,
    this.value,
    this.pointType,
    @required this.isHeader,
    this.headerTitle,
    this.headerIcon,
    this.fullTitle,
    this.item1,
    this.item2,
    this.item3,
    this.item4,
    this.item5,
  });
}
