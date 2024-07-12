import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.router.dart';
import 'package:spendsmart/models/local/user_settings_model.dart';
import 'package:spendsmart/ui/views/startup/startup_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  StartupViewModel getModel() => StartupViewModel();

  group('StartupViewModelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    test('When userSettingsData is null, should navigate to LanguageView',
        () async {
      final userSettingsService = getAndRegisterUserSettingsService();
      final navigationService = getAndRegisterNavigationService();

      when(userSettingsService.userSettingsData).thenReturn(null);

      final model = getModel();
      await model.runStartupLogic();

      verify(navigationService.replaceWithLanguageView()).called(1);
    });

    test('When userSettingsData is not null, should navigate to HomeView',
        () async {
      final userSettingsService = getAndRegisterUserSettingsService();
      final navigationService = getAndRegisterNavigationService();
      const userSettings = UserSettingsModel(
        language: 'en',
        currency: 'USD',
        pushNotificationsEnabled: true,
        hour: 9,
        minute: 30,
      );

      when(userSettingsService.userSettingsData).thenReturn(userSettings);

      final model = getModel();
      await model.runStartupLogic();

      verify(navigationService.replaceWithHomeView()).called(1);
    });
  });
}
