import 'package:cold_app/domain/entities/approach/approach.dart';
import 'package:cold_app/domain/usecases/approach_usecases.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:matcher/matcher.dart';

import '../../approachTestModel.dart';

void main() {
  Approach approach = testGetApproach();

  test('set, read, delete approach', () async {
    SetApproach().call('unit test uid', approach);
    dynamic savedApproach = await GetApproach().call('unit test uid');
    print(savedApproach);

    // expect(() => Pointer(pointType: PointType.attraction, name: 'Test', value: 11),
    //     throwsA(TypeMatcher<ArgumentError>()));
    // expect(() => Pointer(pointType: PointType.result, name: 'Test', value: -1),
    //     throwsA(TypeMatcher<ArgumentError>()));
  });
}
