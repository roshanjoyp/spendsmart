import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/models/app/currency_model.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/expense_service.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';

class ExpenseDetailViewModel extends BaseViewModel {
  final logger = getLogger('ExpenseDetailViewModel');

  ExpenseDataModel? _expenseDataModel;
  late AppLocalizations _appLocalizations;

  final _expenseService = locator<ExpenseService>();
  final _userService = locator<UserSettingsService>();

  num? amount;
  late DateTime _expenseDate;
  String? _selectedType;
  final List<String> _recommendedCategories = [];
  Set<String> _allCategories = {};

  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String? _amountInputValidationMessage;
  String? _categoryInputValidationMessage;

  TextEditingController get amountController => _amountController;
  String? get amountInputValidationMessage => _amountInputValidationMessage;
  bool get isNewEntry => _expenseDataModel == null;
  DateTime get expenseDate => _expenseDate;
  List<String> get recommendedCategories => _recommendedCategories;
  String? get selectedType => _selectedType;
  Set<String> get allCategories => _allCategories;
  TextEditingController get categoryController => _categoryController;
  String? get categoryInputValidationMessage => _categoryInputValidationMessage;
  TextEditingController get descriptionController => _descriptionController;

  set appLocalizations(AppLocalizations appLocalizations) {
    _appLocalizations = appLocalizations;
  }

  ExpenseDetailViewModel({
    ExpenseDataModel? expenseDataModel,
  }) {
    _expenseDataModel = expenseDataModel;
    Set<String> userList = _expenseService.getAllTypes();

    _appLocalizations =
        lookupAppLocalizations(Locale(_userService.languageString ?? 'en'));

    _allCategories = {
      _appLocalizations.groceries,
      _appLocalizations.entertainment,
      _appLocalizations.utilities,
      _appLocalizations.personal,
      _appLocalizations.miscellaneous,
      _appLocalizations.transport,
    };
    _allCategories.addAll(userList);

    _expenseDate = DateTime.now();

    if (_expenseDataModel != null) {
      amount = _expenseDataModel!.amount;
      _amountController.text = amount.toString();
      _expenseDate = _expenseDataModel!.date;
      _selectedType = _expenseDataModel!.type;
      _descriptionController.text = _expenseDataModel!.description ?? "";
    }
    logger.i('ExpenseDetailViewModel initialized');
  }

  String get curerencyText {
    String symbol = _userService.currencySymbol ?? '\$';
    return currencies
        .firstWhere((element) => element.currencySymbol == symbol)
        .currency;
  }

  Future<bool> addNewExpense() async {
    if (!validate()) {
      return false;
    }
    _expenseDataModel = constructModel();
    try {
      await _expenseService.saveExpenseData(_expenseDataModel!);
      logger.i('New expense added');
      return true;
    } catch (e) {
      logger.e('Error adding new expense: $e');
      return false;
    }
  }

  Future<bool> updateExpense() async {
    if (!validate()) {
      return false;
    }
    var model = constructModel();
    model = model.copyWith(id: _expenseDataModel!.id);

    if (model == _expenseDataModel) {
      return false;
    } else {
      try {
        await _expenseService.saveExpenseData(model);
        logger.i('Expense updated');
        return true;
      } catch (e) {
        logger.e('Error updating expense: $e');
        return false;
      }
    }
  }

  Future<bool> deleteExpense() async {
    try {
      await _expenseService.deleteExpenseData(_expenseDataModel!);
      logger.i('Expense deleted');
      return true;
    } catch (e) {
      logger.e('Error deleting expense: $e');
      return false;
    }
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
      _amountInputValidationMessage = _appLocalizations.enterAnAmount;
      rebuildUi();
      logger.w('Validation failed: amount is null');
      return false;
    }
    if (selectedType == null) {
      _categoryInputValidationMessage = _appLocalizations.enterACategory;
      rebuildUi();
      logger.w('Validation failed: selectedType is null');
      return false;
    }
    return true;
  }

  void amountChanged(String value) {
    _amountInputValidationMessage = null;

    if (value.isNotEmpty) {
      try {
        amount = NumberFormat.decimalPattern("en").parse(value);
      } catch (e) {
        amount = null;
        _amountController.text = "";
        logger.e('Error parsing amount: $e');
      }

      if (amount == null) {
        _amountInputValidationMessage = _appLocalizations.invalidAmountFormat;
      } else if (amount! < 0 || amount! > 100000000000000) {
        _amountInputValidationMessage =
            _appLocalizations.amountRangeNotSupporterd;
      }
    } else {
      _amountInputValidationMessage = _appLocalizations.enterAnAmount;
    }

    rebuildUi();
  }

  void setExpenseDate(DateTime value) {
    _expenseDate = value;
    rebuildUi();
  }

  void removeCategory(String category) {
    _selectedType = null;
    rebuildUi();
  }

  void onCategoryTextChanged(String value) {
    value = value.trim();
    updateRecommendedCategories(value);
    rebuildUi();
  }

  void addCategory(String category) {
    _selectedType = category;
    _categoryController.clear();
    _recommendedCategories.clear();
    _categoryInputValidationMessage = null;
    rebuildUi();
  }

  void addCategoryFromText() {
    if (_categoryController.text.isNotEmpty) {
      _selectedType = _categoryController.text.trim();
      _categoryController.clear();
      _recommendedCategories.clear();
      _categoryInputValidationMessage = null;
    } else {
      _categoryInputValidationMessage = _appLocalizations.enterACategory;
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
}
