import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.router.dart';
import 'package:spendsmart/constants/app_defaults.dart';
import 'package:spendsmart/models/app/currency_model.dart';
import 'package:spendsmart/models/local/user_settings_model.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LanguageViewModel extends BaseViewModel {
  final _userSettingService = locator<UserSettingsService>();
  final _navigationService = locator<NavigationService>();

  bool _isLanguageSheetExpanded = false;
  bool _isCurrencySheetExpanded = false;

  String? _selectedLanguage;
  String? _selectedCurrency;

  bool get isLanguageSheetExpanded => _isLanguageSheetExpanded;

  bool get isCurrencySheetExpanded => _isCurrencySheetExpanded;

  String get selectedCurrencyValue => _selectedCurrency ?? 'USD';
  String get selectedLanguageValue => _selectedLanguage ?? 'English';

  String get selectedCurrencySymbol {
    var item =
        currencies.firstWhere((item) => item.currency == selectedCurrencyValue);
    return item.currencySymbol;
  }

  LanguageViewModel() {
    _userSettingService.updateUserSettings(UserSettingsModel(
        id: "id", language: appDefaultLanguage, currency: appDefaultCurrency));
  }

  void expandLanguageSheetTapped() {
    _isLanguageSheetExpanded = !_isLanguageSheetExpanded;
    rebuildUi();
  }

  void expandCurrencySheetTapped() {
    _isCurrencySheetExpanded = !_isCurrencySheetExpanded;
    rebuildUi();
  }

  void setSelectedLanguage(String language) {
    _selectedLanguage = language;
    _isLanguageSheetExpanded = false;
    rebuildUi();
  }

  void setSelectedCurrency(String currency) {
    _selectedCurrency = currency;
    _isCurrencySheetExpanded = false;
    rebuildUi();
  }

  void saveAndContinue() async {
    _userSettingService.saveUserSettingsData();
    _navigationService.replaceWithHomeView();
  }
}
