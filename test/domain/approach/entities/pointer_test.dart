import 'package:cold_app/domain/entities/approach/pointer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

void main() {
  final Pointer setupPointer = Pointer(
    pointType: PointType.result,
    name: 'Setup Test',
    value: 5,
  );

  test('is Pointer Limited to 0-10 Scale', () {
    expect(() => Pointer(pointType: PointType.attraction, name: 'Test', value: 11),
        throwsA(TypeMatcher<ArgumentError>()));
    expect(() => Pointer(pointType: PointType.result, name: 'Test', value: -1),
        throwsA(TypeMatcher<ArgumentError>()));
  });

  test('do values match', () {
    expect(setupPointer.pointType, PointType.result);
    expect(setupPointer.name, 'Setup Test');
    expect(setupPointer.value, 5);
  });

  test('to Map', () {
    expect(setupPointer.toMap(), {
      'name': 'Setup Test',
      'value': 5,
      'pointType': PointType.result,
    });
  });

  test('from Map', () {
    Pointer pointer = Pointer.fromMap({
      'name': 'Test from map',
      'value': 7,
      'pointType': PointType.skill,
    });

    expect(pointer.name, 'Test from map');
    expect(pointer.value, 7);
    expect(pointer.pointType, PointType.skill);
  });

  test('from and to Map', () {
    Pointer pointer = Pointer.fromMap({
      'name': 'Test from to map',
      'value': 7,
      'pointType': PointType.attraction,
    });

    expect(pointer.toMap(), {
      'name': 'Test from to map',
      'value': 7,
      'pointType': PointType.attraction,
    });
  });
}
