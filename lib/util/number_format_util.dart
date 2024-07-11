import 'package:intl/intl.dart';

class NumberFormatUtil {
  static String formatAmountUsingNumberFormat({
    required double amount,
    required String locale,
    required String currency,
  }) {
    String formattedAmount;

    formattedAmount = NumberFormat.currency(
      locale: locale,
      symbol: currency,
    ).format(amount);

    return formattedAmount;
  }

  static String formatAmountUsingNumberFormatCompact({
    required double amount,
    required String locale,
    required String currency,
  }) {
    String formattedAmount;

    formattedAmount = NumberFormat.compactCurrency(
      locale: locale,
      symbol: currency,
    ).format(amount);

    return formattedAmount;
  }
}
