import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ExpenseNavigatorViewModel extends BaseViewModel {
  late final GlobalKey<NavigatorState> _navigatorKey;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  ExpenseNavigatorViewModel(this._navigatorKey);
}
