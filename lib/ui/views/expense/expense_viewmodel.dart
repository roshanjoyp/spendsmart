import 'package:flutter/material.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/models/app/daily_summary.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/expense_service.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';

class ExpenseViewModel extends BaseViewModel {
  final logger = getLogger('ExpenseViewModel');

  final _expenseService = locator<ExpenseService>();
  final _userSettingsService = locator<UserSettingsService>();
  late final GlobalKey<NavigatorState> _navigatorKey;

  List<ExpenseDataModel> _allExpenses = [];
  List<ExpenseDataModel> _filteredExpenses = [];

  ExpenseViewModel(this._navigatorKey);

  List<DailySummary> get dailySummaries =>
      generateDailySummary(_filteredExpenses);

  String get getLocale => _userSettingsService.languageString ?? 'en';

  String get getCurrency => _userSettingsService.currencySymbol ?? '\$';

  DateTime get firstDate => _allExpenses.isEmpty
      ? DateTime.now()
      : _allExpenses.reduce((a, b) => a.date.isBefore(b.date) ? a : b).date;

  DateTime get lastDate => _allExpenses.isEmpty
      ? DateTime.now()
      : _allExpenses.reduce((a, b) => a.date.isAfter(b.date) ? a : b).date;

  void initialize() {
    logger.i('Initializing ExpenseViewModel');
    _allExpenses = _expenseService.getAllExpenses;
    _filteredExpenses = List.from(_allExpenses);
    sortExpensesByDate();
  }

  void sortExpensesByDate() {
    _filteredExpenses.sort((a, b) => b.date.compareTo(a.date));
    rebuildUi();
    logger.i('Expenses sorted by date');
  }

  void filterExpensesByDate(DateTime startDate, DateTime endDate) {
    _filteredExpenses = _allExpenses.where((expense) {
      return (expense.date.isAtSameMomentAs(startDate) ||
              expense.date.isAfter(startDate)) &&
          (expense.date.isAtSameMomentAs(endDate) ||
              expense.date.isBefore(endDate));
    }).toList();
    sortExpensesByDate();
    logger.i('Expenses filtered by date: $startDate to $endDate');
  }

  void clearFilters() {
    _filteredExpenses = List.from(_allExpenses);
    sortExpensesByDate();
    logger.i('Filters cleared');
  }

  void addNewExpense() async {
    try {
      await _navigatorKey.currentState!.pushNamed("/expense-detail-view");
      initialize();
    } catch (e) {
      logger.e('Error adding new expense: $e');
    }
  }

  Future<void> editExpense(ExpenseDataModel expense) async {
    try {
      await _navigatorKey.currentState!
          .pushNamed("/expense-detail-view", arguments: [expense]);
      initialize();
    } catch (e) {
      logger.e('Error editing expense: $e');
    }
  }

  List<DailySummary> generateDailySummary(List<ExpenseDataModel> expenses) {
    logger.i('Generating daily summary');

    // Sort expenses by date
    expenses.sort((a, b) => a.date.compareTo(b.date));

    // Group expenses by day
    Map<String, List<ExpenseDataModel>> expensesByDay = {};
    for (var expense in expenses) {
      String dayKey =
          "${expense.date.year}-${expense.date.month.toString().padLeft(2, '0')}-${expense.date.day.toString().padLeft(2, '0')}";
      expensesByDay.putIfAbsent(dayKey, () => []).add(expense);
    }

    // Generate the daily summary
    List<DailySummary> dailySummaries = [];
    num? previousDayTotal;

    for (var dayKey in expensesByDay.keys) {
      List<ExpenseDataModel> dailyExpenses = expensesByDay[dayKey]!;
      DateTime dayDate = DateTime(
        int.parse(dayKey.split('-')[0]),
        int.parse(dayKey.split('-')[1]),
        int.parse(dayKey.split('-')[2]),
      );

      // Calculate total amount for the day
      num totalAmount = dailyExpenses.fold(0, (sum, item) => sum + item.amount);

      // Calculate percentage change from the previous day
      num percentageChange = 0;
      if (previousDayTotal != null) {
        percentageChange =
            ((totalAmount - previousDayTotal) / previousDayTotal) * 100;
      }
      previousDayTotal = totalAmount;

      // Add the daily summary
      dailySummaries.add(DailySummary(
        date: dayDate,
        totalAmount: totalAmount,
        percentageChange: percentageChange,
        expenses: dailyExpenses,
      ));
    }

    return dailySummaries.reversed.toList();
  }

  Future<void> refresh() async {
    logger.i('Refreshing data');
    initialize();
  }
}
