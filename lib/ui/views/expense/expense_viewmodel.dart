import 'package:flutter/material.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/expense_service.dart';
import 'package:stacked/stacked.dart';

class ExpenseViewModel extends BaseViewModel {
  late final GlobalKey<NavigatorState> _navigatorKey;
  final _expenseService = locator<ExpenseService>();

  ExpenseViewModel(this._navigatorKey);

  List<ExpenseDataModel> get allExpenses => _expenseService.getAllExpenses;
  void addNewExpense() async {
    await _navigatorKey.currentState!.pushNamed("/expense-detail-view");
    rebuildUi();
  }

  // // Used as temporary fix to avoid called setstate during build
  // @override
  // void notifyListeners() {
  //   Future.microtask(() {
  //     super.notifyListeners();
  //   });
  // }
}
