import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.logger.dart';
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
  final logger = getLogger('SettingsViewModel');

  final _userSettingsService = locator<UserSettingsService>();
  final _navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();
  final _notificationService = locator<LocalNotificationService>();

  AppLocalizations? _appLocalizations;

  SettingsViewModel() {
    _initialize();
    logger.i('SettingsViewModel initialized');
  }

  String get language {
    String code = _userSettingsService.languageString ?? appDefaultLanguage;
    return languages
        .firstWhere((element) => element.languageCountryCode == code)
        .language;
  }

  String get currency {
    String currencySymbol =
        _userSettingsService.currencySymbol ?? appDefaultCurrency;
    var item = currencies
        .firstWhere((element) => element.currencySymbol == currencySymbol);
    return "${item.currencySymbol} ----- ${item.currency}";
  }

  bool get isDailyNotificationOn =>
      _userSettingsService.pushNotificationsEnabled;

  TimeOfDay get notificationTime {
    int hour = _userSettingsService.pushNotificationTimeHour ?? appDefaultHour;
    int minute =
        _userSettingsService.pushNotificationTimeMinute ?? appDefaultMinute;
    return TimeOfDay(hour: hour, minute: minute);
  }

  Future<void> deleteAllData() async {
    try {
      await _userSettingsService.deleteAllData();
      logger.i('All data deleted');
      _navigationService.clearStackAndShow(Routes.startupView);
    } catch (e) {
      logger.e('Error deleting all data: $e');
    }
  }

  Future<void> generateMockData() async {
    try {
      List<ExpenseDataModel> mockExpenses = List.generate(100, (index) {
        final random = Random();
        final amount = (random.nextDouble() * 1000).roundToDouble();
        final date =
            DateTime.now().subtract(Duration(days: random.nextInt(365)));
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
            "${_appLocalizations!.aShortDescription} ${index + 1}";
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
      logger.i('Mock data generated');
    } catch (e) {
      logger.e('Error generating mock data: $e');
    }
  }

  Future<void> showNotification() async {
    try {
      await _notificationService.cancelAllNotifications();
      TimeOfDay time = TimeOfDay.now();
      TimeOfDay newTimeOfDay = TimeOfDay(
        hour: time.hour,
        minute: time.minute + 1,
      );
      await _notificationService.scheduleDailyNotification(newTimeOfDay);
      logger.i('Notification scheduled for $newTimeOfDay');
    } catch (e) {
      logger.e('Error showing notification: $e');
    }
  }

  Future<void> onLanguageCurrencyTap() async {
    try {
      await _navigationService.navigateToLanguageView(fromSettings: true);
      rebuildUi();
      logger.i('Navigated to Language and Currency settings');
    } catch (e) {
      logger.e('Error navigating to Language and Currency settings: $e');
    }
  }

  Future<void> onDailyNotificationToggle(bool value) async {
    try {
      await _userSettingsService.setPushNotificationEnabled(value);
      if (value) {
        TimeOfDay time = notificationTime;
        await _notificationService.scheduleDailyNotification(time);
      } else {
        await _notificationService.cancelAllNotifications();
      }
      rebuildUi();
      logger.i('Daily notification toggled to $value');
    } catch (e) {
      logger.e('Error toggling daily notification: $e');
    }
  }

  void onNotificationTimeTap() {
    // Implement time picker logic
  }

  Future<void> updateNotificationTime(TimeOfDay picked) async {
    try {
      await _userSettingsService.setPushNotificationTime(
          picked.hour, picked.minute);
      rebuildUi();
      logger.i('Notification time updated to $picked');
    } catch (e) {
      logger.e('Error updating notification time: $e');
    }
  }

  void _initialize() {
    _appLocalizations = lookupAppLocalizations(
        Locale(_userSettingsService.languageString ?? 'en'));
  }
}
