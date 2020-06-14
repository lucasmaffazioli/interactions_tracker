import 'package:cold_app/domain/entities/approach/approach.dart';
import 'package:cold_app/domain/entities/approach/pointer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Approach approach = Approach(
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

  setUpAll(() {});

  test('is DateTime correct', () {
    expect(approach.dateTime, DateTime(2020, 06, 13, 13, 30));
  });

  test('is skills correct', () {
    expect(approach.points[3].pointType, PointType.skill);
    expect(approach.points[3].name, 'Calibration');
    expect(approach.points[3].value, 0);
    // expect(approach.skills[2], identical(Pointer(name: 'Vocal projection', value: 3)));
  });

  test('are parms ok', () {
    expect(
      approach.dateTime,
      DateTime(2020, 06, 13, 13, 30),
    );
    expect(
      approach.name,
      'Teste',
    );
    expect(
      approach.description,
      'Beautiful day',
    );
    expect(
      approach.notes,
      'Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
    );
    // expect(approach.skills.name, 'Attraction');
    // expect(approach.result, );
    // expect(approach.skills[2], identical(Pointer(name: 'Vocal projection', value: 3)));
  });

  test('is to Json OK', () {
    Object json = approach.toJson();
    String jsonString = approach.toString();

    print('json');
    print(json);
    print('jsonString');
    print(jsonString);

    expect(
      json,
      'a',
    );
    expect(
      jsonString,
      'a',
    );
  });
  // test('is from Json OK', () {
  //   approach = Approach.fromJson('TestUid', 'aaaaaa');
  //   expect(
  //     approach.notes,
  //     'Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
  //   );
  // });
}
