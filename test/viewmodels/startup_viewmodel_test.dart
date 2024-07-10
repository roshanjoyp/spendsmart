import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.router.dart';
import 'package:spendsmart/models/local/user_settings_model.dart';
import 'package:spendsmart/ui/views/startup/startup_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  StartupViewModel getModel() => StartupViewModel();
  group('StartupViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    group('runStartupLogic -', () {
      setUp(() => registerServices());
      tearDown(() => locator.reset());
      test('When userSettingsData is null, should navigate to LanguageView',
          () {
        final userSettingsModelMock = getAndRegisterUserSettingsService();
        when(userSettingsModelMock.userSettingsData).thenReturn(null);

        final navigationService = getAndRegisterNavigationService();

        final model = getModel();
        model.runStartupLogic();
        verify(navigationService.replaceWithLanguageView());
      });

      test('When userSettingsData is not null, should navigate to HomeView',
          () {
        final userSettingsModelMock = getAndRegisterUserSettingsService();
        when(userSettingsModelMock.userSettingsData).thenReturn(
            UserSettingsModel(
                id: "id", language: "language", currency: "currency"));

        final navigationService = getAndRegisterNavigationService();

        final model = getModel();
        model.runStartupLogic();
        verify(navigationService.replaceWithHomeView());
      });
    });
  });
}
