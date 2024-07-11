import 'dart:math';

import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.router.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/services/expense_service.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _userSettingsService = locator<UserSettingsService>();
  final _navigationService = locator<NavigationService>();
  final _expenseService = locator<ExpenseService>();

  Future<void> deleteAllData() async {
    await _userSettingsService.deleteAllData();
    _navigationService.clearStackAndShow(Routes.startupView);
  }

  generatemockData() async {
    List<ExpenseDataModel> mockExpenses = List.generate(100, (index) {
      final random = Random();
      final amount = (random.nextDouble() * 1000).roundToDouble();
      final date = DateTime.now().subtract(Duration(days: random.nextInt(365)));
      final types = ["Food", "Travel", "Entertainment", "Bills", "Other"];
      final type = types[random.nextInt(types.length)];
      final description = "Mock description ${index + 1}";
      return ExpenseDataModel(
        id: 'id_${index + 1}',
        amount: amount,
        date: date,
        type: type,
        description: description,
      );
    });
    for (var element in mockExpenses) {
      await _expenseService.saveExpenseData(element);
    }
  }
}
