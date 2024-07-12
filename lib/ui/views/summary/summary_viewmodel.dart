import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/models/app/monthly_summary.dart';
import 'package:spendsmart/models/app/type_summary.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/expense_service.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';

class SummaryViewModel extends BaseViewModel {
  final logger = getLogger('SummaryViewModel');

  final _expenseService = locator<ExpenseService>();
  final _userSettingsService = locator<UserSettingsService>();

  List<MonthlySummary> _monthlySummaries = [];
  List<MonthlySummary> get monthlySummaries => _monthlySummaries;

  String get getLocale => _userSettingsService.languageString ?? 'en';
  String get getCurrency => _userSettingsService.currencySymbol ?? '\$';

  SummaryViewModel() {
    initialize();
    logger.i('SummaryViewModel initialized');
  }

  void initialize() {
    logger.i('Initializing monthly summaries');
    try {
      _monthlySummaries =
          generateMonthlySummary(_expenseService.getAllExpenses);
      rebuildUi();
      logger.i('Monthly summaries generated successfully');
    } catch (e) {
      logger.e('Error generating monthly summaries: $e');
    }
  }

  List<MonthlySummary> generateMonthlySummary(List<ExpenseDataModel> expenses) {
    logger.i(expenses.length);
    // Sort expenses by date
    expenses.sort((a, b) => a.date.compareTo(b.date));

    // Group expenses by month
    Map<String, List<ExpenseDataModel>> expensesByMonth = {};
    for (var expense in expenses) {
      String monthKey =
          "${expense.date.year}-${expense.date.month.toString().padLeft(2, '0')}";
      expensesByMonth.putIfAbsent(monthKey, () => []).add(expense);
    }

    // Generate the monthly summary
    List<MonthlySummary> monthlySummaries = [];
    num? previousMonthTotal;

    for (var monthKey in expensesByMonth.keys) {
      List<ExpenseDataModel> monthlyExpenses = expensesByMonth[monthKey]!;
      DateTime monthDate = DateTime(
        int.parse(monthKey.split('-')[0]),
        int.parse(monthKey.split('-')[1]),
      );

      // Calculate total amount for the month
      num totalAmount =
          monthlyExpenses.fold(0, (sum, item) => sum + item.amount);

      // Calculate type summaries
      Map<String, TypeSummary> typeSummariesMap = {};
      for (var expense in monthlyExpenses) {
        if (!typeSummariesMap.containsKey(expense.type)) {
          typeSummariesMap[expense.type] = TypeSummary(
            type: expense.type,
            totalAmount: 0,
            percentage: 0,
            entryCount: 0,
          );
        }
        var typeSummary = typeSummariesMap[expense.type]!;
        typeSummariesMap[expense.type] = TypeSummary(
          type: typeSummary.type,
          totalAmount: typeSummary.totalAmount + expense.amount,
          percentage: 0, // This will be calculated later
          entryCount: typeSummary.entryCount + 1,
        );
      }

      // Calculate percentage contribution for each type
      List<TypeSummary> typeSummaries = [];
      for (var typeSummary in typeSummariesMap.values) {
        typeSummaries.add(TypeSummary(
          type: typeSummary.type,
          totalAmount: typeSummary.totalAmount,
          percentage: (typeSummary.totalAmount / totalAmount) * 100,
          entryCount: typeSummary.entryCount,
        ));
      }

      // Calculate percentage change from the previous month
      num percentageChange = 0;
      if (previousMonthTotal != null) {
        percentageChange =
            ((totalAmount - previousMonthTotal) / previousMonthTotal) * 100;
      }
      previousMonthTotal = totalAmount;

      // Add the monthly summary
      monthlySummaries.add(MonthlySummary(
        month: monthDate,
        totalAmount: totalAmount,
        percentageChange: percentageChange,
        typeSummaries: typeSummaries,
      ));
    }
    logger.i(monthlySummaries.length);
    return monthlySummaries.reversed.toList();
  }

  Future<void> refresh() async {
    logger.i('Refreshing monthly summaries');
    initialize();
  }
}
