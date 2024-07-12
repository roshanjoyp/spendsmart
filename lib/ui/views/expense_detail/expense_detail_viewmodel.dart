import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/app/currency_model.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/expense_service.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';

class ExpenseDetailViewModel extends BaseViewModel {
  ExpenseDataModel? _expenseDataModel;

  final _expenseService = locator<ExpenseService>();
  final _userService = locator<UserSettingsService>();

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
      _selectedType = _expenseDataModel!.type;
      _descriptionController.text = _expenseDataModel!.description ?? "";
    }
  }

  num? amount;
  final TextEditingController _amountController = TextEditingController();
  String? _amountInputValidationMessage;
  get amountController => _amountController;
  get amountInputValidationMessage => _amountInputValidationMessage;

  bool get isNewEntry => _expenseDataModel == null ? true : false;

  String get curerencyText {
    String symbol = _userService.currencySymbol!;
    return currencies
        .firstWhere(
          (element) => element.currencySymbol == symbol,
        )
        .currency;
  }

  Future<bool> addNewExpense() async {
    if (!validate()) {
      return false;
    }
    _expenseDataModel = constructModel();

    await _expenseService.saveExpenseData(_expenseDataModel!);
    return true;
  }

  ExpenseDataModel constructModel() {
    return ExpenseDataModel(
      id: DateTime.now().toIso8601String(),
      amount: amount!.toDouble(),
      date: _expenseDate,
      type: selectedType!,
      description: _descriptionController.text.trim(),
    );
  }

  bool validate() {
    if (amount == null) {
      _amountInputValidationMessage = "Enter an amount";
      rebuildUi();
      return false;
    }
    if (selectedType == null) {
      _categoryInputValidationMessage = "Enter atleast one category";
      rebuildUi();
      return false;
    }
    return true;
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

  String? _selectedType;
  final List<String> _recommendedCategories = [];
  Set<String> _allCategories = {};
  final TextEditingController _categoryController = TextEditingController();

  List<String> get recommendedCategories => _recommendedCategories;
  String? get selectedType => _selectedType;
  Set<String> get allCategories => _allCategories;
  String? _categoryInputValidationMessage;
  TextEditingController get categoryController => _categoryController;
  String? get categoryInputValidationMessage => _categoryInputValidationMessage;

  removeCategory(String category) {
    _selectedType = null;
    rebuildUi();
  }

  void onCategoryTextChanged(String value) {
    value = value.trim();
    updateRecommendedCategories(value);
    rebuildUi();
  }

  addCategory(String category) {
    _selectedType = category;
    _categoryController.clear();
    _recommendedCategories.clear();
    _categoryInputValidationMessage = null;
    rebuildUi();
  }

  addCategoryFromText() {
    if (_categoryController.text.isNotEmpty) {
      _selectedType = _categoryController.text.trim();

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

  Future<bool> updateExpense() async {
    if (!validate()) {
      return false;
    }
    var model = constructModel();
    model = model.copyWith(id: _expenseDataModel!.id);

    if (model == _expenseDataModel) {
      return false;
    } else {
      await _expenseService.saveExpenseData(model);
      return true;
    }
  }

  Future<bool> deleteExpense() async {
    await _expenseService.deleteExpenseData(_expenseDataModel!);
    return true;
  }
}
