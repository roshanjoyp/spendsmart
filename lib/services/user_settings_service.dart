import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/user_settings_model.dart';
import 'package:spendsmart/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';

class UserSettingsService with ListenableServiceMixin {
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  UserSettingsModel? get userData => _localStorageService.userData;

  UserSettingsService() {
    listenToReactiveValues([_localStorageService.userData]);
  }

  String? get languageString => userData?.language;
}
