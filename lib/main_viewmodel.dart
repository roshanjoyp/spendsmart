import 'dart:ui';

import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/services/user_service.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends ReactiveViewModel {
  final logger = getLogger('MainViewModel');
  final _userService = locator<UserService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  Locale get currentLocale => Locale(_userService.languageString ?? "es");

  MainViewModel() {
    logger.i('MainViewModel initialized');
  }
}
