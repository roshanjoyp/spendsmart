import 'package:flutter/material.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/expense_service.dart';
import 'package:stacked/stacked.dart';

class ExpenseViewModel extends BaseViewModel {
  late final GlobalKey<NavigatorState> _navigatorKey;
  final _expenseService = locator<ExpenseService>();

  ExpenseViewModel(this._navigatorKey);

  List<ExpenseDataModel> _allExpenses = [];
  List<ExpenseDataModel> _filteredExpenses = [];

  List<ExpenseDataModel> get allExpenses => _filteredExpenses;

  void initialize() {
    _allExpenses = _expenseService.getAllExpenses;
    _filteredExpenses = List.from(_allExpenses);
    sortExpensesByDate();
    notifyListeners();
  }

  DateTime get firstDate => _allExpenses.isEmpty
      ? DateTime.now()
      : _allExpenses.reduce((a, b) => a.date.isBefore(b.date) ? a : b).date;

  DateTime get lastDate => _allExpenses.isEmpty
      ? DateTime.now()
      : _allExpenses.reduce((a, b) => a.date.isAfter(b.date) ? a : b).date;

  void sortExpensesByDate() {
    _filteredExpenses.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  void filterExpensesByDate(DateTime startDate, DateTime endDate) {
    _filteredExpenses = _allExpenses.where((expense) {
      return expense.date.isAfter(startDate) && expense.date.isBefore(endDate);
    }).toList();
    sortExpensesByDate(); // Ensure the filtered list is also sorted
    notifyListeners();
  }

  void clearFilters() {
    _filteredExpenses = List.from(_allExpenses);
    sortExpensesByDate();
    notifyListeners();
  }

  void addNewExpense() async {
    await _navigatorKey.currentState!.pushNamed("/expense-detail-view");
    initialize();
    rebuildUi();
  }

  Future<void> editExpense(ExpenseDataModel expense) async {
    await _navigatorKey.currentState!
        .pushNamed("/expense-detail-view", arguments: [expense]);
    initialize();
    rebuildUi();
  }
}
