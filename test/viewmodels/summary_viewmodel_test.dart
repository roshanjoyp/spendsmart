import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/ui/views/summary/summary_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  SummaryViewModel getModel() {
    return SummaryViewModel();
  }

  group('SummaryViewModelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());

    final mockExpenseService = getAndRegisterExpenseService();
    final mockUserSettingsService = getAndRegisterUserSettingsService();

    test('generateMonthlySummary generates correct type summaries', () {
      when(mockExpenseService.getAllExpenses).thenReturn([
        ExpenseDataModel(
          id: '1',
          amount: 100,
          date: DateTime(2023, 1, 1),
          type: 'Food',
        ),
        ExpenseDataModel(
          id: '2',
          amount: 200,
          date: DateTime(2023, 1, 2),
          type: 'Transport',
        ),
        ExpenseDataModel(
          id: '3',
          amount: 100,
          date: DateTime(2023, 1, 3),
          type: 'Food',
        ),
      ]);

      final model = getModel();
      final monthlySummaries =
          model.generateMonthlySummary(mockExpenseService.getAllExpenses);

      expect(monthlySummaries.length, 1);
      expect(monthlySummaries[0].typeSummaries.length, 2);

      final foodSummary = monthlySummaries[0]
          .typeSummaries
          .firstWhere((summary) => summary.type == 'Food');
      expect(foodSummary.totalAmount, 200);
      expect(foodSummary.percentage, 50.0);
      expect(foodSummary.entryCount, 2);

      final transportSummary = monthlySummaries[0]
          .typeSummaries
          .firstWhere((summary) => summary.type == 'Transport');
      expect(transportSummary.totalAmount, 200);
      expect(transportSummary.percentage, 50.0);
      expect(transportSummary.entryCount, 1);
    });

    test('getLocale returns correct locale from user settings', () {
      when(mockUserSettingsService.languageString).thenReturn('en');

      final model = getModel();

      expect(model.getLocale, 'en');
    });

    test('getCurrency returns correct currency from user settings', () {
      when(mockUserSettingsService.currencySymbol).thenReturn('\$');

      final model = getModel();

      expect(model.getCurrency, '\$');
    });
  });
}
