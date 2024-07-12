import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/ui/views/expense/expense_viewmodel.dart';

import '../helpers/test_helpers.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  ExpenseViewModel getModel({required GlobalKey<NavigatorState> navigatorKey}) {
    final model = ExpenseViewModel(navigatorKey);
    model.initialize();
    return model;
  }

  group('ExpenseViewModelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    final navigatorKey = GlobalKey<NavigatorState>();

    test('Initial values for ExpenseViewModel', () {
      final expenseService = getAndRegisterExpenseService();
      when(expenseService.getAllExpenses).thenReturn([]);

      final model = getModel(navigatorKey: navigatorKey);
      expect(model.dailySummaries, []);
    });

    test('ExpenseViewModel generates daily summary correctly', () {
      final expenseService = getAndRegisterExpenseService();
      when(expenseService.getAllExpenses).thenReturn([
        ExpenseDataModel(
          id: '1',
          amount: 100,
          date: DateTime(2023, 1, 1),
          type: 'Food',
        ),
        ExpenseDataModel(
          id: '2',
          amount: 200,
          date: DateTime(2023, 1, 1),
          type: 'Transport',
        ),
        ExpenseDataModel(
          id: '3',
          amount: 150,
          date: DateTime(2023, 1, 2),
          type: 'Entertainment',
        ),
      ]);

      final model = getModel(navigatorKey: navigatorKey);

      final summaries = model.dailySummaries;
      expect(summaries.length, 2);
      expect(summaries[0].totalAmount, 150);
      expect(summaries[1].totalAmount, 300);
    });

    test('ExpenseViewModel sorts expenses by date', () {
      final expenseService = getAndRegisterExpenseService();
      when(expenseService.getAllExpenses).thenReturn([
        ExpenseDataModel(
          id: '1',
          amount: 100,
          date: DateTime(2023, 1, 2),
          type: 'Food',
        ),
        ExpenseDataModel(
          id: '2',
          amount: 200,
          date: DateTime(2023, 1, 1),
          type: 'Transport',
        ),
      ]);

      final model = getModel(navigatorKey: navigatorKey);
      model.sortExpensesByDate();

      final sortedExpenses =
          model.dailySummaries.expand((e) => e.expenses).toList();
      expect(sortedExpenses[0].date, DateTime(2023, 1, 2));
      expect(sortedExpenses[1].date, DateTime(2023, 1, 1));
    });

    test('ExpenseViewModel filters expenses by date', () {
      final expenseService = getAndRegisterExpenseService();
      when(expenseService.getAllExpenses).thenReturn([
        ExpenseDataModel(
          id: '1',
          amount: 100,
          date: DateTime(2023, 1, 2),
          type: 'Food',
        ),
        ExpenseDataModel(
          id: '2',
          amount: 200,
          date: DateTime(2023, 1, 1),
          type: 'Transport',
        ),
      ]);

      final model = getModel(navigatorKey: navigatorKey);
      model.filterExpensesByDate(DateTime(2023, 1, 2), DateTime(2023, 1, 2));

      final filteredExpenses =
          model.dailySummaries.expand((e) => e.expenses).toList();
      expect(filteredExpenses.length, 1);
      expect(filteredExpenses[0].date, DateTime(2023, 1, 2));
    });

    test('ExpenseViewModel clears filters', () {
      final expenseService = getAndRegisterExpenseService();
      when(expenseService.getAllExpenses).thenReturn([
        ExpenseDataModel(
          id: '1',
          amount: 100,
          date: DateTime(2023, 1, 2),
          type: 'Food',
        ),
        ExpenseDataModel(
          id: '2',
          amount: 200,
          date: DateTime(2023, 1, 1),
          type: 'Transport',
        ),
      ]);

      final model = getModel(navigatorKey: navigatorKey);
      model.filterExpensesByDate(DateTime(2023, 1, 2), DateTime(2023, 1, 2));
      model.clearFilters();

      final filteredExpenses =
          model.dailySummaries.expand((e) => e.expenses).toList();
      expect(filteredExpenses.length, 2);
    });
  });
}
