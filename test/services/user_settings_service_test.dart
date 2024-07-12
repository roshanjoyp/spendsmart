import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/user_settings_model.dart';
import 'package:spendsmart/services/user_settings_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('UserSettingsServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    UserSettingsService getModel() => UserSettingsService();

    test('When userSettingsData is null, default values should be returned',
        () {
      final localStorageService = getAndRegisterLocalStorageService();
      when(localStorageService.userSettingsData).thenReturn(null);

      final model = getModel();

      expect(model.languageString, isNull);
      expect(model.currencySymbol, isNull);
      expect(model.pushNotificationsEnabled, isFalse);
      expect(model.pushNotificationTimeHour, isNull);
      expect(model.pushNotificationTimeMinute, isNull);
    });

    test('When userSettingsData is not null, correct values should be returned',
        () {
      final localStorageService = getAndRegisterLocalStorageService();
      const userSettings = UserSettingsModel(
        language: 'en',
        currency: 'USD',
        pushNotificationsEnabled: true,
        hour: 9,
        minute: 30,
      );

      when(localStorageService.userSettingsData).thenReturn(userSettings);

      final model = getModel();

      expect(model.languageString, 'en');
      expect(model.currencySymbol, 'USD');
      expect(model.pushNotificationsEnabled, isTrue);
      expect(model.pushNotificationTimeHour, 9);
      expect(model.pushNotificationTimeMinute, 30);
    });

    test('When updateUserSettings is called, should update settings', () async {
      final localStorageService = getAndRegisterLocalStorageService();

      final model = getModel();
      await model.updateUserSettings(
        language: 'fr',
        currency: 'EUR',
        pushNotificationsEnabled: true,
        hour: 10,
        minute: 45,
      );

      verify(localStorageService.setUserSettingsData(
        language: 'fr',
        currency: 'EUR',
        pushNotificationsEnabled: true,
        hour: 10,
        minute: 45,
      )).called(1);
    });

    test('When saveUserSettingsData is called, should save settings', () async {
      final localStorageService = getAndRegisterLocalStorageService();

      final model = getModel();
      await model.saveUserSettingsData();

      verify(localStorageService.saveUserSettingsData()).called(1);
    });

    test('When deleteAllData is called, should delete all data', () async {
      final localStorageService = getAndRegisterLocalStorageService();

      final model = getModel();
      await model.deleteAllData();

      verify(localStorageService.deleteAllData()).called(1);
    });

    test('When setPushNotificationEnabled is called, should update setting',
        () async {
      final localStorageService = getAndRegisterLocalStorageService();

      final model = getModel();
      await model.setPushNotificationEnabled(true);

      verify(localStorageService.setUserSettingsData(
              pushNotificationsEnabled: true))
          .called(1);
    });

    test('When setPushNotificationTime is called, should update time',
        () async {
      final localStorageService = getAndRegisterLocalStorageService();

      final model = getModel();
      await model.setPushNotificationTime(8, 15);

      verify(localStorageService.setUserSettingsData(hour: 8, minute: 15))
          .called(1);
    });
  });
}
