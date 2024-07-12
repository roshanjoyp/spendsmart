import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/models/local/user_settings_model.dart';
import 'package:spendsmart/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';

class UserSettingsService with ListenableServiceMixin {
  final logger = getLogger('UserSettingsService');
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
    try {
      await _localStorageService.setUserSettingsData(
        currency: currency,
        language: language,
        hour: hour,
        minute: minute,
        pushNotificationsEnabled: pushNotificationsEnabled,
      );
      notifyListeners();
      logger.i('User settings updated');
    } catch (e) {
      logger.e('Error updating user settings: $e');
    }
  }

  Future<void> saveUserSettingsData() async {
    try {
      await _localStorageService.saveUserSettingsData();
      logger.i('User settings saved');
    } catch (e) {
      logger.e('Error saving user settings: $e');
    }
  }

  Future<void> deleteAllData() async {
    try {
      await _localStorageService.deleteAllData();
      logger.i('All user data deleted');
    } catch (e) {
      logger.e('Error deleting all user data: $e');
    }
  }

  Future<void> setPushNotificationEnabled(bool value) async {
    try {
      await _localStorageService.setUserSettingsData(
          pushNotificationsEnabled: value);
      logger.i('Push notifications enabled set to $value');
    } catch (e) {
      logger.e('Error setting push notifications enabled: $e');
    }
  }

  Future<void> setPushNotificationTime(int hour, int minute) async {
    try {
      await _localStorageService.setUserSettingsData(
          hour: hour, minute: minute);
      logger.i('Push notification time set to $hour:$minute');
    } catch (e) {
      logger.e('Error setting push notification time: $e');
    }
  }
}
