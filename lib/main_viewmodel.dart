import 'dart:ui';

import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/constants/app_defaults.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends ReactiveViewModel {
  final logger = getLogger('MainViewModel');
  final _userSettingsService = locator<UserSettingsService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userSettingsService];

  Locale get currentLocale =>
      Locale(_userSettingsService.languageString ?? appDefaultLanguage);

  MainViewModel() {
    logger.i('MainViewModel initialized');
  }

  // Used as temporary fix to avoid called setstate during build
  @override
  void notifyListeners() {
    Future.microtask(() {
      super.notifyListeners();
    });
  }
}
