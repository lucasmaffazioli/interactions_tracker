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

  // List<Categories> getAllCategories() {
  //   List<Categories> list = [];

  //   list.add(Categories(PointType.skill, [
  //     PointItem(id: null, name: null, ish),
  //     PointItem(id: 3, name: 'Contato Visual'),
  //     PointItem(id: 4, name: 'Postura física'),
  //   ]));
  //   list.add(Categories(PointType.attraction, [PointItem(id: 1, name: 'Atração')]));
  //   list.add(Categories(PointType.result, [PointItem(id: 2, name: 'Resultado')]));

  //   return list;
  // }
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
  final PointType pointType;
  final int id;
  final String name;
  int value;

  PointPresentation(
      {this.id, this.name, this.value, this.pointType, this.isHeader, this.headerTitle});
}
