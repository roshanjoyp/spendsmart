import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/expense_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('ExpenseServiceTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    ExpenseService getModel() => ExpenseService();

    test('When getAllExpenses is called, should return list of expenses', () {
      final localStorageService = getAndRegisterLocalStorageService();
      when(localStorageService.expenses).thenReturn([
        ExpenseDataModel(
          id: '1',
          amount: 100,
          date: DateTime.now(),
          type: 'Food',
          description: 'Groceries',
        ),
      ]);

      final model = getModel();
      final expenses = model.getAllExpenses;

      expect(expenses.length, 1);
      expect(expenses.first.id, '1');
    });

    test('When saveExpenseData is called, should save the expense data',
        () async {
      final localStorageService = getAndRegisterLocalStorageService();
      final expense = ExpenseDataModel(
        id: '1',
        amount: 100,
        date: DateTime.now(),
        type: 'Food',
        description: 'Groceries',
      );

      final model = getModel();
      await model.saveExpenseData(expense);

      verify(localStorageService.saveExpenseData(expense)).called(1);
    });

    test('When deleteExpenseData is called, should delete the expense data',
        () async {
      final localStorageService = getAndRegisterLocalStorageService();
      final expense = ExpenseDataModel(
        id: '1',
        amount: 100,
        date: DateTime.now(),
        type: 'Food',
        description: 'Groceries',
      );

      final model = getModel();
      await model.deleteExpenseData(expense);

      verify(localStorageService.deleteExpenseData(expense.id)).called(1);
    });

    test('When getAllTypes is called, should return set of unique types', () {
      final localStorageService = getAndRegisterLocalStorageService();
      when(localStorageService.expenses).thenReturn([
        ExpenseDataModel(
          id: '1',
          amount: 100,
          date: DateTime.now(),
          type: 'Food',
          description: 'Groceries',
        ),
        ExpenseDataModel(
          id: '2',
          amount: 200,
          date: DateTime.now(),
          type: 'Transport',
          description: 'Bus fare',
        ),
        ExpenseDataModel(
          id: '3',
          amount: 150,
          date: DateTime.now(),
          type: 'Food',
          description: 'Dinner',
        ),
      ]);

      final model = getModel();
      final types = model.getAllTypes();

      expect(types.length, 2);
      expect(types.contains('Food'), isTrue);
      expect(types.contains('Transport'), isTrue);
    });
  });
}
