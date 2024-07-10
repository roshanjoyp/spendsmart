import 'package:stacked/stacked.dart';

class LanguageViewModel extends BaseViewModel {
  bool _isLanguageSheetExpanded = false;
  bool _isCurrencySheetExpanded = false;

  String? _selectedLanguage;
  String? _selectedCurrency;

  bool get isLanguageSheetExpanded => _isLanguageSheetExpanded;

  bool get isCurrencySheetExpanded => _isCurrencySheetExpanded;

  String get selectedCurrencyValue => _selectedCurrency ?? 'USD';
  String get selectedLanguageValue => _selectedLanguage ?? 'English';

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
}
