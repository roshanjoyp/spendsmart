import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.router.dart';
import 'package:spendsmart/constants/app_defaults.dart';
import 'package:spendsmart/models/app/currency_model.dart';
import 'package:spendsmart/models/app/language_model.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LanguageViewModel extends BaseViewModel {
  final _userSettingService = locator<UserSettingsService>();
  final _navigationService = locator<NavigationService>();

  bool _isLanguageSheetExpanded = false;
  bool _isCurrencySheetExpanded = false;

  late int _selectedLanguageIndex;
  late int _selectedCurrencyIndex;

  bool get isLanguageSheetExpanded => _isLanguageSheetExpanded;
  bool get isCurrencySheetExpanded => _isCurrencySheetExpanded;

  String get selectedCurrencyValue =>
      currencies[_selectedCurrencyIndex].currency;
  String get selectedLanguageValue =>
      languages[_selectedLanguageIndex].language;

  String get selectedCurrencySymbol =>
      currencies[_selectedCurrencyIndex].currencySymbol;
  String get selectedLanguageCode =>
      languages[_selectedLanguageIndex].languageCountryCode;

  LanguageViewModel() {
    _selectedLanguageIndex =
        languages.indexWhere((item) => item.language == appDefaultLanguage);

    _selectedCurrencyIndex =
        currencies.indexWhere((item) => item.currency == appDefaultCurrency);

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
    rebuildUi();
  }

  void setSelectedCurrency(int index) {
    _selectedCurrencyIndex = index;
    _isCurrencySheetExpanded = false;
    rebuildUi();
  }

  void saveAndContinue() async {
    setBusy(true);
    await _userSettingService.saveUserSettingsData();
    setBusy(false);
    _navigationService.replaceWithHomeView();
  }
}
