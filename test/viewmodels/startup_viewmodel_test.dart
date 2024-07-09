import 'package:flutter_test/flutter_test.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/ui/views/startup/startup_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  StartupViewModel getModel() => StartupViewModel();
  group('StartupViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    test(
        'When there is no language in localStorage , navigate to language view',
        () {});
  });
}
