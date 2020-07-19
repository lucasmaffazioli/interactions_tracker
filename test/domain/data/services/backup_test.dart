import 'package:matcher/matcher.dart';
import 'package:cold_app/locator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    print('setupLocator');
    await setupLocatorTest();
  });

  tearDown(() {
    print('tearDown;');
    closeDb();
    locator.reset();
  });

  group('Export', () {
    test('export', () async {
      //
    });
  });
}
