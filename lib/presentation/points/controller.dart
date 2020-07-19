import 'package:cold_app/data/models/approach/approach_views.dart';
import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/domain/usecases/approach_usecases.dart';
import 'package:cold_app/domain/usecases/point_usecases.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../core/extensions/string_extension.dart';

class PointsController {
  Future<List<PointPresentation>> getAllPoints() async {
    final List<PointModel> pointsModel = await GetAllPoints().call();

    List<PointPresentation> pointsPresentation = [];

    pointsModel.forEach((element) {
      if (element.pointType == 'skill')
        pointsPresentation.add(PointPresentation(
          id: element.id,
          name: element.name,
          pointType: element.pointType,
        ));
    });

    return pointsPresentation;
  }
}
