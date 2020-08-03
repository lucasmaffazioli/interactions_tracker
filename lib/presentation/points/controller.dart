import 'package:cold_app/data/models/approach/point_model.dart';
import 'package:cold_app/domain/usecases/point_usecases.dart';

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