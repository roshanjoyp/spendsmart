import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/ui/views/expense_detail/expense_detail_viewmodel.dart';

import '../helpers/test_helpers.dart';

class MockAppLocalizations extends Mock implements AppLocalizations {
  @override
  String get enterAnAmount => 'Enter an amount';

  @override
  String get enterACategory => 'Enter a category';

  @override
  String get invalidAmountFormat => 'Invalid amount format';

  @override
  String get amountRangeNotSupported => 'Amount range not supported';

  @override
  String get groceries => 'Groceries';

  @override
  String get entertainment => 'Entertainment';

  @override
  String get utilities => 'Utilities';

  @override
  String get personal => 'Personal';

  @override
  String get miscellaneous => 'Miscellaneous';

  @override
  String get transport => 'Transport';
}

void main() {
  ExpenseDetailViewModel getModel({ExpenseDataModel? expenseDataModel}) {
    final model = ExpenseDetailViewModel(expenseDataModel: expenseDataModel);
    model.appLocalizations = MockAppLocalizations();
    return model;
  }

  group('ExpenseDetailViewModelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    test('Initial values for a new entry', () {
      final model = getModel();
      expect(model.isNewEntry, true);
      expect(model.amount, null);
      expect(model.selectedType, null);
    });

    test('Initial values for an existing entry', () {
      final expenseDataModel = ExpenseDataModel(
        id: '1',
        amount: 100,
        date: DateTime.now(),
        type: 'Food',
        description: 'Groceries',
      );

      final model = getModel(expenseDataModel: expenseDataModel);
      expect(model.isNewEntry, false);
      expect(model.amount, 100);
      expect(model.selectedType, 'Food');
    });

    test('Add new expense with valid data', () async {
      final expenseService = getAndRegisterExpenseService();
      final model = getModel();

      model.amount = 50;
      model.addCategory('Food');
      model.setExpenseDate(DateTime.now());

      final result = await model.addNewExpense();
      expect(result, true);
      verify(expenseService.saveExpenseData(any)).called(1);
    });

    test('Add new expense with invalid data', () async {
      final model = getModel();
      final result = await model.addNewExpense();
      expect(result, false);
    });

    test('Update expense with valid data', () async {
      final expenseService = getAndRegisterExpenseService();
      final expenseDataModel = ExpenseDataModel(
        id: '1',
        amount: 100,
        date: DateTime.now(),
        type: 'Food',
        description: 'Groceries',
      );

      final model = getModel(expenseDataModel: expenseDataModel);
      model.amount = 200;

      final result = await model.updateExpense();
      expect(result, true);
      verify(expenseService.saveExpenseData(any)).called(1);
    });

    test('Update expense with invalid data', () async {
      final expenseDataModel = ExpenseDataModel(
        id: '1',
        amount: 100,
        date: DateTime.now(),
        type: 'Food',
        description: 'Groceries',
      );

      final model = getModel(expenseDataModel: expenseDataModel);
      model.amount = null;

      final result = await model.updateExpense();
      expect(result, false);
    });

    test('Delete expense', () async {
      final expenseService = getAndRegisterExpenseService();
      final expenseDataModel = ExpenseDataModel(
        id: '1',
        amount: 100,
        date: DateTime.now(),
        type: 'Food',
        description: 'Groceries',
      );

      final model = getModel(expenseDataModel: expenseDataModel);
      final result = await model.deleteExpense();
      expect(result, true);
      verify(expenseService.deleteExpenseData(any)).called(1);
    });

    test('Validation fails if amount is null', () {
      final model = getModel();

      final result = model.validate();
      expect(result, false);
      expect(model.amountInputValidationMessage, 'Enter an amount');
    });

    test('Validation fails if selectedType is null', () {
      final model = getModel();

      model.amount = 100;
      final result = model.validate();
      expect(result, false);
      expect(model.categoryInputValidationMessage, 'Enter a category');
    });

    test('Validation passes with valid data', () {
      final model = getModel();

      model.amount = 100;
      model.addCategory('Food');
      final result = model.validate();
      expect(result, true);
    });

    test('amountChanged updates amount and validation message', () {
      final model = getModel();

      model.amountChanged('100');

      expect(model.amount, 100);
      expect(model.amountInputValidationMessage, null);
    });

    test('amountChanged sets validation message for invalid amount', () {
      final model = getModel();

      model.amountChanged('invalid');

      expect(model.amount, null);
      expect(model.amountInputValidationMessage, 'Invalid amount format');
    });

    test('setExpenseDate updates expense date', () {
      final model = getModel();
      final newDate = DateTime.now().subtract(const Duration(days: 1));
      model.setExpenseDate(newDate);

      expect(model.expenseDate, newDate);
    });

    test('removeCategory sets selectedType to null', () {
      final model = getModel();
      model.addCategory('Food');
      model.removeCategory('Food');

      expect(model.selectedType, null);
    });

    test('onCategoryTextChanged updates recommended categories', () {
      final model = getModel();
      model.onCategoryTextChanged('foo');

      expect(model.recommendedCategories, []);
    });

    test('addCategory sets selectedType', () {
      final model = getModel();
      model.addCategory('Food');

      expect(model.selectedType, 'Food');
    });

    test('addCategoryFromText sets selectedType', () {
      final model = getModel();

      model.categoryController.text = 'Food';
      model.addCategoryFromText();

      expect(model.selectedType, 'Food');
      expect(model.categoryInputValidationMessage, null);
    });

    test('addCategoryFromText sets validation message for empty text', () {
      final model = getModel();

      model.categoryController.text = '';
      model.addCategoryFromText();

      expect(model.selectedType, null);
      expect(model.categoryInputValidationMessage, 'Enter a category');
    });

    // test('updateRecommendedCategories updates recommended categories', () {
    //   final model = getModel();
    //   model._allCategories = {'Food', 'Transport'};
    //   model.updateRecommendedCategories('foo');

    //   expect(model.recommendedCategories, []);
    // });
  });
}
