import 'package:cold_app/domain/entities/approach/approach.dart';
import 'package:cold_app/domain/entities/approach/pointer.dart';

Approach testGetApproach() {
  return Approach(
    uid: 'a2sd1a2sA',
    dateTime: DateTime(2020, 06, 13, 13, 30),
    name: 'Teste',
    description: 'Beautiful day',
    notes: 'Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    points: [
      Pointer(pointType: PointType.skill, name: 'Visual contact', value: 5),
      Pointer(pointType: PointType.skill, name: 'Phisical posture', value: 8),
      Pointer(pointType: PointType.skill, name: 'Vocal projection', value: 3),
      Pointer(pointType: PointType.skill, name: 'Calibration', value: 0),
      Pointer(pointType: PointType.skill, name: 'Frame', value: 10),
      Pointer(pointType: PointType.skill, name: 'Confidence', value: 5),
      Pointer(pointType: PointType.attraction, name: 'Attraction', value: 10),
      Pointer(pointType: PointType.result, name: 'Result', value: 10),
    ],
  );
}
