import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/domain/entities/interaction/interaction_entity.dart';
import 'package:cold_app/domain/usecases/interaction_usecases.dart';
import 'package:flutter/material.dart';

class AddInteractionController {
  Future<InteractionPresentation> getInteraction(context, interactionId) async {
    InteractionEntity interactionEntity = await GetInteraction().call(interactionId);
    //
    List<PointPresentation> pointPresentationList = [];
    //
    PointType lastPointType;
    //
    print('controller.dart: interactionEntity.toJson()');
    print(interactionEntity.toJson());
    //
    interactionEntity.points.forEach((element) {
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
    interactionEntity.points.forEach((element) {
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
    InteractionPresentation interactionPresentation = InteractionPresentation(
      id: interactionEntity.id,
      date: interactionEntity.dateTime.toLocal(),
      time: TimeOfDay.fromDateTime(interactionEntity.dateTime),
      name: interactionEntity.name,
      description: interactionEntity.description,
      notes: interactionEntity.notes,
      points: pointPresentationList,
    );

    // print(interactionPresentation.name);
    // interactionPresentation.points.forEach((element) {
    //   print(element.isHeader.toString());
    //   print(element.headerTitle);
    //   print(element.name);
    // });

    // print(interactionPresentation);

    return interactionPresentation;
  }

  void saveInteraction(InteractionPresentation interactionPresentation) async {
    print('save app1');
    print(interactionPresentation.date);
    print(interactionPresentation.date.toString());
    print(interactionPresentation.date.toIso8601String());
    print(interactionPresentation.date.day.toString());

    final DateTime dateTime = DateTime(
      interactionPresentation.date.year,
      interactionPresentation.date.month,
      interactionPresentation.date.day,
      interactionPresentation.time.hour,
      interactionPresentation.time.minute,
      interactionPresentation.date.second,
    );
    List<InteractionPointEntity> points = [];

    // print('Saving interaction');
    // print(interactionPresentation.date);
    // print(interactionPresentation.time);
    // print(dateTime.toString());
    interactionPresentation.points.forEach((element) {
      print('forEach presentation points');
      print(element.name);
      print(element.value);
      //
      if (!element.isHeader)
        points.add(InteractionPointEntity(
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
    InteractionEntity interactionEntity = InteractionEntity(
      id: interactionPresentation.id,
      dateTime: dateTime,
      name: interactionPresentation.name,
      description: interactionPresentation.description,
      notes: interactionPresentation.notes,
      points: points,
    );
    //
    await SaveInteraction().call(interactionEntity);
    // if (interactionEntity.id == null) await SaveInteraction().call(interactionEntity);
    // if (interactionEntity.id == null) await SaveInteraction().call(interactionEntity);
    // if (interactionEntity.id == null) await SaveInteraction().call(interactionEntity);
  }
}

class InteractionPresentation {
  int id;
  DateTime date;
  TimeOfDay time;
  String name;
  String description;
  String notes;
  List<PointPresentation> points;

  InteractionPresentation(
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
