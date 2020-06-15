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

  test('to Json', () {
    expect(setupPointer.toJson(), {
      'name': 'Setup Test',
      'value': 5,
      'pointType': PointType.result,
    });
  });

  test('from Json', () {
    Pointer pointer = Pointer.fromJson({
      'name': 'Test from json',
      'value': 7,
      'pointType': PointType.skill,
    });

    expect(pointer.name, 'Test from json');
    expect(pointer.value, 7);
    expect(pointer.pointType, PointType.skill);
  });

  test('from and to Json', () {
    Pointer pointer = Pointer.fromJson({
      'name': 'Test from to json',
      'value': 7,
      'pointType': PointType.attraction,
    });

    expect(pointer.toJson(), {
      'name': 'Test from to json',
      'value': 7,
      'pointType': PointType.attraction,
    });
  });
}
