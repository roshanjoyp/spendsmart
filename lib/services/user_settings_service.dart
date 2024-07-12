import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/user_settings_model.dart';
import 'package:spendsmart/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';

class UserSettingsService with ListenableServiceMixin {
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  UserSettingsModel? get userSettingsData =>
      _localStorageService.userSettingsData;

  UserSettingsService() {
    listenToReactiveValues([_localStorageService.userSettingsData]);
  }

  String? get languageString => userSettingsData?.language;
  String? get currencySymbol => userSettingsData?.currency;
  bool get pushNotificationsEnabled =>
      userSettingsData?.pushNotificationsEnabled ?? false;
  int? get pushNotificationTimeHour => userSettingsData?.hour;
  int? get pushNotificationTimeMinute => userSettingsData?.minute;

  void updateUserSettings({
    String? language,
    String? currency,
    bool? pushNotificationsEnabled,
    int? hour,
    int? minute,
  }) async {
    _localStorageService.setUserSettingsData(
      currency: currency,
      language: language,
      hour: hour,
      minute: minute,
      pushNotificationsEnabled: pushNotificationsEnabled,
    );
    notifyListeners();
  }

  Future<void> saveUserSettingsData() async {
    await _localStorageService.saveUserSettingsData();
  }

  Future<void> deleteAllData() async {
    await _localStorageService.deleteAllData();
  }

  setPushNotificationEnabled(bool value) async {
    await _localStorageService.setUserSettingsData(
      pushNotificationsEnabled: value,
    );
  }

  Future<void> setPushNotificationTime(int hour, int minute) async {
    await _localStorageService.setUserSettingsData(
      hour: hour,
      minute: minute,
    );
  }
}
