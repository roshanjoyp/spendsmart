import 'package:flutter_test/flutter_test.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/app/currency_model.dart';
import 'package:spendsmart/models/app/language_model.dart';
import 'package:spendsmart/ui/views/language/language_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('LanguageViewModelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    final mockUserSettingsService = getAndRegisterUserSettingsService();
    final mockNavigationService = getAndRegisterNavigationService();

    LanguageViewModel getModel({bool fromSettings = false}) {
      return LanguageViewModel(fromSettings);
    }

    test('expandLanguageSheetTapped toggles isLanguageSheetExpanded', () {
      final model = getModel();

      model.expandLanguageSheetTapped();
      expect(model.isLanguageSheetExpanded, true);

      model.expandLanguageSheetTapped();
      expect(model.isLanguageSheetExpanded, false);
    });

    test('expandCurrencySheetTapped toggles isCurrencySheetExpanded', () {
      final model = getModel();

      model.expandCurrencySheetTapped();
      expect(model.isCurrencySheetExpanded, true);

      model.expandCurrencySheetTapped();
      expect(model.isCurrencySheetExpanded, false);
    });

    test('setSelectedLanguage updates selected language and closes sheet', () {
      final model = getModel();

      model.setSelectedLanguage(1);
      expect(model.selectedLanguageValue, languages[1].englishLanguageName);
      expect(model.isLanguageSheetExpanded, false);
    });

    test('setSelectedCurrency updates selected currency and closes sheet', () {
      final model = getModel();

      model.setSelectedCurrency(1);
      expect(model.selectedCurrencyValue, currencies[1].currency);
      expect(model.isCurrencySheetExpanded, false);
    });
  });
}
