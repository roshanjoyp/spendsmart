import '../local/expense_data_model.dart';

class DailySummary {
  final DateTime date;
  final num totalAmount;
  final num percentageChange;
  final List<ExpenseDataModel> expenses;

  DailySummary({
    required this.date,
    required this.totalAmount,
    required this.percentageChange,
    required this.expenses,
  });
}
