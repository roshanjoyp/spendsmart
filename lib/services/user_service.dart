import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/user_data_model.dart';
import 'package:spendsmart/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';

class UserService with ListenableServiceMixin {
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();
  UserDataModel? get userData => _localStorageService.userData;

  UserService() {
    listenToReactiveValues([_localStorageService.userData]);
  }

  String? get languageString => userData?.language;
}
