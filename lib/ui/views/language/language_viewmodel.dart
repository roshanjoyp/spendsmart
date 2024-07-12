import 'package:logger/logger.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/app/app.router.dart';
import 'package:spendsmart/constants/app_defaults.dart';
import 'package:spendsmart/models/app/currency_model.dart';
import 'package:spendsmart/models/app/language_model.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LanguageViewModel extends BaseViewModel {
  final Logger _logger = getLogger('LanguageViewModel');
  final _userSettingService = locator<UserSettingsService>();
  final _navigationService = locator<NavigationService>();

  final bool _fromSettings;

  bool _isLanguageSheetExpanded = false;
  bool _isCurrencySheetExpanded = false;

  late int _selectedLanguageIndex;
  late int _selectedCurrencyIndex;

  bool get isLanguageSheetExpanded => _isLanguageSheetExpanded;
  bool get isCurrencySheetExpanded => _isCurrencySheetExpanded;

  String get selectedCurrencyValue =>
      currencies[_selectedCurrencyIndex].currency;
  String get selectedLanguageValue =>
      languages[_selectedLanguageIndex].englishLanguageName;

  String get selectedCurrencySymbol =>
      currencies[_selectedCurrencyIndex].currencySymbol;
  String get selectedLanguageCode =>
      languages[_selectedLanguageIndex].languageCountryCode;

  LanguageViewModel(this._fromSettings) {
    _selectedLanguageIndex = languages
        .indexWhere((item) => item.languageCountryCode == appDefaultLanguage);

    _selectedCurrencyIndex = currencies
        .indexWhere((item) => item.currencySymbol == appDefaultCurrency);

    _userSettingService.updateUserSettings(
        currency: selectedCurrencySymbol, language: selectedLanguageCode);
  }

  void expandLanguageSheetTapped() {
    _isLanguageSheetExpanded = !_isLanguageSheetExpanded;
    rebuildUi();
  }

  void expandCurrencySheetTapped() {
    _isCurrencySheetExpanded = !_isCurrencySheetExpanded;
    rebuildUi();
  }

  void setSelectedLanguage(int index) {
    _selectedLanguageIndex = index;
    _isLanguageSheetExpanded = false;
    _userSettingService.updateUserSettings(language: selectedLanguageCode);
    rebuildUi();
  }

  void setSelectedCurrency(int index) {
    _selectedCurrencyIndex = index;
    _isCurrencySheetExpanded = false;
    _userSettingService.updateUserSettings(
      currency: selectedCurrencySymbol,
    );
    rebuildUi();
  }

  void saveAndContinue() async {
    setBusy(true);
    await _userSettingService.saveUserSettingsData();
    _logger.i('Language and Currency saved');
    setBusy(false);
    if (_fromSettings) {
      _navigationService.back();
    } else {
      _navigationService.replaceWithHomeView();
    }
  }
}
