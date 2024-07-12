import 'type_summary.dart';

class MonthlySummary {
  final DateTime month;
  final num totalAmount;
  final num percentageChange;
  final List<TypeSummary> typeSummaries;

  MonthlySummary({
    required this.month,
    required this.totalAmount,
    required this.percentageChange,
    required this.typeSummaries,
  });
}
