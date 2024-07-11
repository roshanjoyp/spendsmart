import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ExpenseViewModel extends BaseViewModel {
  late final GlobalKey<NavigatorState> _navigatorKey;

  ExpenseViewModel(this._navigatorKey);
  void addNewExpense() {
    print("here");
    _navigatorKey.currentState!.pushNamed("/expense-detail-view");
  }
}
