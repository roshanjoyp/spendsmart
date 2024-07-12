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

  LanguageViewModel(this._fromSettings) {
    _initializeIndices();
    _updateUserSettings();
    _logger.i('LanguageViewModel initialized');
  }

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

  void _initializeIndices() {
    _selectedLanguageIndex = languages
        .indexWhere((item) => item.languageCountryCode == appDefaultLanguage);
    _selectedCurrencyIndex = currencies
        .indexWhere((item) => item.currencySymbol == appDefaultCurrency);
  }

  void _updateUserSettings() {
    _userSettingService.updateUserSettings(
      currency: selectedCurrencySymbol,
      language: selectedLanguageCode,
    );
  }

  void expandLanguageSheetTapped() {
    _isLanguageSheetExpanded = !_isLanguageSheetExpanded;
    rebuildUi();
    _logger.i('Language sheet expanded: $_isLanguageSheetExpanded');
  }

  void expandCurrencySheetTapped() {
    _isCurrencySheetExpanded = !_isCurrencySheetExpanded;
    rebuildUi();
    _logger.i('Currency sheet expanded: $_isCurrencySheetExpanded');
  }

  void setSelectedLanguage(int index) {
    _selectedLanguageIndex = index;
    _isLanguageSheetExpanded = false;
    _userSettingService.updateUserSettings(language: selectedLanguageCode);
    rebuildUi();
    _logger.i('Selected language index set to: $index');
  }

  void setSelectedCurrency(int index) {
    _selectedCurrencyIndex = index;
    _isCurrencySheetExpanded = false;
    _userSettingService.updateUserSettings(currency: selectedCurrencySymbol);
    rebuildUi();
    _logger.i('Selected currency index set to: $index');
  }

  Future<void> saveAndContinue() async {
    setBusy(true);
    try {
      await _userSettingService.saveUserSettingsData();
      _logger.i('Language and Currency saved');
      if (_fromSettings) {
        _navigationService.back();
      } else {
        _navigationService.replaceWithHomeView();
      }
    } catch (e) {
      _logger.e('Error saving language and currency settings: $e');
    } finally {
      setBusy(false);
    }
  }
}
