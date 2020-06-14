import 'package:cold_app/domain/entities/approach/pointer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

void main() {
  Pointer pointer = Pointer(
    pointType: PointType.result,
    name: 'Test',
    value: 5,
  );
  // test('isPointerArg1isRequired', () {
  //   // aignore: missing_required_param
  //   expect(() => Pointer(name: ''), throwsA(TypeMatcher<ArgumentError>()));
  // });
  // test('isPointerArg2isRequired', () {
  //   expect(() => Pointer(value: 1), throwsA(TypeMatcher<ArgumentError>()));
  // });
  test('is Pointer Limited to 0-10 Scale', () {
    expect(() => Pointer(pointType: PointType.attraction, name: 'Test', value: 11),
        throwsA(TypeMatcher<ArgumentError>()));
    expect(() => Pointer(pointType: PointType.result, name: 'Test', value: -1),
        throwsA(TypeMatcher<ArgumentError>()));
  });

  test('do values match', () {
    expect(pointer.pointType, PointType.result);
    expect(pointer.name, 'Test');
    expect(pointer.value, 5);
  });

  test('to Json', () {
    expect(pointer.toJson(), {
      'name': 'Test',
      'value': 5,
      'pointType': PointType.result,
    });
  });
}
