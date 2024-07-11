import 'package:flutter_test/flutter_test.dart';
import 'package:spendsmart/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('SummaryViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}

