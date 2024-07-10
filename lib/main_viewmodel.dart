import 'dart:ui';

import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/services/user_service.dart';
import 'package:stacked/stacked.dart';

class MainViewModel extends ReactiveViewModel {
  final _userService = locator<UserService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_userService];

  Locale get currentLocale => _userService.locale;
}
