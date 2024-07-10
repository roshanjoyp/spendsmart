import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/constants/app_defaults.dart';
import 'package:spendsmart/main_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  MainViewModel getModel() => MainViewModel();
  group('MainViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    test('When user settings is null, should return appDefaultLanguage locale',
        () {
      final userSettingService = getAndRegisterUserSettingsService();
      when(userSettingService.languageString).thenReturn(null);

      final model = getModel();
      expect(model.currentLocale, Locale(appDefaultLanguage));
    });

    test(
        'When user settings -  language is not null, should return locale accordingly',
        () {
      final userSettingService = getAndRegisterUserSettingsService();
      when(userSettingService.languageString).thenReturn("es");

      final model = getModel();
      expect(model.currentLocale, const Locale("es"));
    });
  });
}
