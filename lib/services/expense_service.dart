import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/local_storage_service.dart';

class ExpenseService {
  final logger = getLogger('ExpenseService');
  final LocalStorageService _localStorageService =
      locator<LocalStorageService>();

  List<ExpenseDataModel> get getAllExpenses => _localStorageService.expenses;

  Future<void> deleteExpenseData(ExpenseDataModel expenseDataModel) async {
    try {
      await _localStorageService.deleteExpenseData(expenseDataModel.id);
      logger.i('Deleted expense data: ${expenseDataModel.id}');
    } catch (e) {
      logger.e('Error deleting expense data: $e');
    }
  }

  Future<void> saveExpenseData(ExpenseDataModel expenseDataModel) async {
    try {
      await _localStorageService.saveExpenseData(expenseDataModel);
      logger.i('Saved expense data: ${expenseDataModel.id}');
    } catch (e) {
      logger.e('Error saving expense data: $e');
    }
  }

  Set<String> getAllTypes() {
    Set<String> types = {};
    try {
      for (var expense in _localStorageService.expenses) {
        types.add(expense.type);
      }
      logger.i('Fetched all expense types');
    } catch (e) {
      logger.e('Error fetching expense types: $e');
    }
    return types;
  }
}
