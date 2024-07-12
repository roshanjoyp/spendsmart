import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.router.dart';
import 'package:spendsmart/constants/app_defaults.dart';
import 'package:spendsmart/models/app/currency_model.dart';
import 'package:spendsmart/models/app/language_model.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/expense_service.dart';
import 'package:spendsmart/services/local_notification_service.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _userSettingsService = locator<UserSettingsService>();
  final _navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();
  final _notificationService = locator<LocalNotificationService>();
  AppLocalizations? _appLocalizations;

  SettingsViewModel() {
    initialse();
  }

  String get language {
    String code = _userSettingsService.languageString!;
    return languages
        .firstWhere((element) => element.languageCountryCode == code)
        .language;
  }

  String get currency {
    String currencySymbol = _userSettingsService.currencySymbol!;
    var item = currencies
        .firstWhere((element) => element.currencySymbol == currencySymbol);
    return "${item.currencySymbol} ----- ${item.currency}";
  }

  get isDailyNotificationOn => _userSettingsService.pushNotificationsEnabled;
  TimeOfDay get notificationTime {
    int hour = _userSettingsService.pushNotificationTimeHour ?? appDefaultHour;
    int minute =
        _userSettingsService.pushNotificationTimeMinute ?? appDefaultMinute;
    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> deleteAllData() async {
    await _userSettingsService.deleteAllData();
    _navigationService.clearStackAndShow(Routes.startupView);
  }

  generatemockData() async {
    List<ExpenseDataModel> mockExpenses = List.generate(100, (index) {
      final random = Random();
      final amount = (random.nextDouble() * 1000).roundToDouble();
      final date = DateTime.now().subtract(Duration(days: random.nextInt(365)));
      final types = [
        _appLocalizations!.groceries,
        _appLocalizations!.entertainment,
        _appLocalizations!.utilities,
        _appLocalizations!.personal,
        _appLocalizations!.miscellaneous,
        _appLocalizations!.transport,
      ];
      final type = types[random.nextInt(types.length)];
      final description =
          "${_appLocalizations!.aShortDescription}} ${index + 1}";
      return ExpenseDataModel(
        id: 'id_${index + 1}',
        amount: amount,
        date: date,
        type: type,
        description: description,
      );
    });
    for (var element in mockExpenses) {
      await _expenseService.saveExpenseData(element);
    }
  }

  showNotification() async {
    await _notificationService.cancelAllNotifications();
    TimeOfDay time = TimeOfDay.now();

    TimeOfDay newTimeOfDay = TimeOfDay(
      hour: time.hour,
      minute: time.minute + 1,
    );
    print(newTimeOfDay);
    //await _notificationService.showANotification();
    await _notificationService.scheduleDailyNotification(newTimeOfDay);

    //_notificationService.scheduleDailyNotification(time);
  }

  void onLanguageCurrencyTap() async {
    // Implement navigation to language and currency settings
    await _navigationService.navigateToLanguageView(fromSettings: true);
    rebuildUi();
  }

  void onDailyNotificationToggle(bool value) async {
    await _userSettingsService.setPushNotificationEnabled(value);

    if (value) {
      TimeOfDay time = _userSettingsService.pushNotificationTimeHour == null
          ? TimeOfDay(hour: appDefaultHour, minute: appDefaultMinute)
          : TimeOfDay(
              hour: _userSettingsService.pushNotificationTimeHour!,
              minute: _userSettingsService.pushNotificationTimeMinute!);
      _notificationService.scheduleDailyNotification(time);
    } else {
      _notificationService.cancelAllNotifications();
    }
    rebuildUi();
  }

  void onNotificationTimeTap() {
    // Implement time picker logic
  }

  void generateMockData() {
    // Implement mock data generation
  }

  void updateNotificationTime(TimeOfDay picked) async {
    await _userSettingsService.setPushNotificationTime(
        picked.hour, picked.minute);
    rebuildUi();
  }

  void initialse() {
    _appLocalizations =
        lookupAppLocalizations(Locale(_userSettingsService.languageString!));
  }
}
