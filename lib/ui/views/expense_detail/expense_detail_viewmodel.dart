import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/expense_service.dart';
import 'package:stacked/stacked.dart';

class ExpenseDetailViewModel extends BaseViewModel {
  ExpenseDataModel? _expenseDataModel;

  final _expenseService = locator<ExpenseService>();

  ExpenseDetailViewModel({
    ExpenseDataModel? expenseDataModel,
  }) {
    _expenseDataModel = expenseDataModel;

    _allCategories = {
      "Groceries",
      "Entertainment",
      "Utilities",
      "Personal",
      "Housing",
      "Transport",
    };
    _expenseDate = DateTime.now();

    if (_expenseDataModel != null) {
      amount = _expenseDataModel!.amount;
      _amountController.text = amount.toString();
      _expenseDate = _expenseDataModel!.date;
      _selectedCategories = _expenseDataModel!.type!.toSet();
      _descriptionController.text = _expenseDataModel!.description ?? "";
    }
  }

  num? amount;
  final TextEditingController _amountController = TextEditingController();
  String? _amountInputValidationMessage;
  get amountController => _amountController;
  get amountInputValidationMessage => _amountInputValidationMessage;

  bool get isNewEntry => _expenseDataModel == null ? true : false;

  Future<void> addNewExpense() async {
    if (amount == null) {
      _amountInputValidationMessage = "Enter an amount";
      rebuildUi();
      return;
    }
    if (selectedCategories.isEmpty) {
      _categoryInputValidationMessage = "Enter atleast one category";
      rebuildUi();
      return;
    }

    _expenseDataModel = ExpenseDataModel(
      id: DateTime.now().toIso8601String(),
      amount: amount!.toDouble(),
      date: _expenseDate,
      type: selectedCategories.toList(),
      description: _descriptionController.text.trim(),
    );

    await _expenseService.saveExpenseData(_expenseDataModel!);
  }

  amountChanged(String value) {
    _amountInputValidationMessage = null;

    if (value.isNotEmpty) {
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
      } else if (amount! < 0 || amount! > 100000000000000) {
        _amountInputValidationMessage = "Amount range not supported";
      } else {}
    } else {
      _amountInputValidationMessage = "Enter an amount";
    }

    rebuildUi();
  }

  late DateTime _expenseDate;

  DateTime get expenseDate => _expenseDate;

  setExpenseDate(DateTime value) {
    _expenseDate = value;
    rebuildUi();
  }

  Set<String> _selectedCategories = {};
  final List<String> _recommendedCategories = [];
  Set<String> _allCategories = {};
  final TextEditingController _categoryController = TextEditingController();

  List<String> get recommendedCategories => _recommendedCategories;
  Set<String> get selectedCategories => _selectedCategories;
  Set<String> get allCategories => _allCategories;
  String? _categoryInputValidationMessage;
  TextEditingController get categoryController => _categoryController;
  String? get categoryInputValidationMessage => _categoryInputValidationMessage;

  removeCategory(String category) {
    _selectedCategories.remove(category);
    rebuildUi();
  }

  void onCategoryTextChanged(String value) {
    value = value.trim();
    updateRecommendedCategories(value);
    rebuildUi();
  }

  addCategory(String category) {
    _selectedCategories.add(category);
    _categoryController.clear();
    _recommendedCategories.clear();
    _categoryInputValidationMessage = null;
    rebuildUi();
  }

  addCategoryFromText() {
    if (_categoryController.text.isNotEmpty) {
      _selectedCategories.add(_categoryController.text.trim());

      _categoryController.clear();
      _recommendedCategories.clear();
      _categoryInputValidationMessage = null;
    } else {
      _categoryInputValidationMessage = "Enter a category";
    }
    rebuildUi();
  }

  void updateRecommendedCategories(String value) {
    if (value.isNotEmpty) {
      _recommendedCategories.clear();
      _recommendedCategories.addAll(_allCategories.where((element) {
        return element.toLowerCase().contains(value.toLowerCase());
      }));
    }
  }

  final TextEditingController _descriptionController = TextEditingController();
  TextEditingController get descriptionController => _descriptionController;

  void updateExpense() {}

  void deleteExpense() {}
}
