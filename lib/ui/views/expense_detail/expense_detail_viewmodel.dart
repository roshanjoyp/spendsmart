import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class ExpenseDetailViewModel extends BaseViewModel {
  final TextEditingController _amountController = TextEditingController();
  String? _amountInputValidationMessage;
  get amountController => _amountController;

  get amountInputValidationMessage => _amountInputValidationMessage;

  void addNewExpense() {}

  amountChanged(String value) {
    _amountInputValidationMessage = null;

    if (value.isNotEmpty) {
      num? amount;
      try {
        amount = NumberFormat.decimalPattern(
          "en",
        ).parse(value);
      } catch (e) {
        amount = null;
        _amountController.text = "";
      }

      if (amount == null) {
        _amountInputValidationMessage = "Invalid amount format";
      } else if (amount < 0 || amount > 100000000000000) {
        _amountInputValidationMessage = "Amount range not supported";
      } else {}
    } else {
      _amountInputValidationMessage = "Enter an amount";
    }

    rebuildUi();
  }
}
