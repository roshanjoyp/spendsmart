import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/local_storage_service.dart';

class ExpenseService {
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  Future<void> saveExpenseData(ExpenseDataModel expenseDataModel) async {
    await _localStorageService.saveExpenseData(expenseDataModel);
  }

  List<ExpenseDataModel> get getAllExpenses => _localStorageService.expenses;

  Future<void> deleteExpenseData(ExpenseDataModel expenseDataModel) async {
    await _localStorageService.deleteExpenseData(expenseDataModel.id);
  }

  Set<String> getAllTypes() {
    Set<String> types = {};
    for (var expense in _localStorageService.expenses) {
      types.add(expense.type);
    }
    return types;
  }
}
