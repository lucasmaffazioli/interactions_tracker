import 'package:cold_app/core/enums/PointType.dart';
import 'package:cold_app/domain/entities/approach/point_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

void main() {
  final PointEntity setupPointEntity = PointEntity(
    id: 1,
    pointType: PointType.result,
    name: 'Setup Test',
    value: 5,
  );

  test('is PointEntity Limited to 0-10 Scale', () {
    expect(() => PointEntity(id: 1, pointType: PointType.attraction, name: 'Test', value: 11),
        throwsA(TypeMatcher<ArgumentError>()));
    expect(() => PointEntity(id: 1, pointType: PointType.result, name: 'Test', value: -1),
        throwsA(TypeMatcher<ArgumentError>()));
  });

  test('do values match', () {
    expect(setupPointEntity.pointType, PointType.result);
    expect(setupPointEntity.name, 'Setup Test');
    expect(setupPointEntity.value, 5);
  });
}
