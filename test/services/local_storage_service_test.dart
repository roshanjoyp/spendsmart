import 'package:flutter_test/flutter_test.dart';
import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/models/local/user_settings_model.dart';
import 'package:spendsmart/services/local_storage_service.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('LocalStorageServiceTest -', () {
    late LocalStorageService localStorageService;

    setUp(() async {
      registerServices();
      localStorageService = LocalStorageService();
      await localStorageService.initializationCompleted;
    });

    tearDown(() => locator.reset());

    test('should initialize LocalStorageService', () async {
      await localStorageService.initializationCompleted;
      expect(localStorageService.userSettingsData, isNull);
      expect(localStorageService.expenses, isEmpty);
    });

    test('should save and load user settings data', () async {
      const userSettings = UserSettingsModel(
        language: 'en',
        currency: 'USD',
        pushNotificationsEnabled: true,
        hour: 9,
        minute: 30,
      );

      await localStorageService.setUserSettingsData(
        language: userSettings.language,
        currency: userSettings.currency,
        pushNotificationsEnabled: userSettings.pushNotificationsEnabled,
        hour: userSettings.hour,
        minute: userSettings.minute,
      );

      await localStorageService.saveUserSettingsData();

      expect(localStorageService.userSettingsData, isNotNull);
      expect(localStorageService.userSettingsData!.language, 'en');
      expect(localStorageService.userSettingsData!.currency, 'USD');
      expect(
          localStorageService.userSettingsData!.pushNotificationsEnabled, true);
      expect(localStorageService.userSettingsData!.hour, 9);
      expect(localStorageService.userSettingsData!.minute, 30);
    });

    // test('should save and load expense data', () async {
    //   final expense = ExpenseDataModel(
    //     id: '1',
    //     amount: 50.0,
    //     date: DateTime.now(),
    //     type: 'Food',
    //     description: 'Groceries',
    //   );

    //   await localStorageService.saveExpenseData(expense);

    //   expect(localStorageService.expenses, isNotEmpty);
    //   expect(localStorageService.expenses.length, 1);
    //   expect(localStorageService.expenses.first.type, 'Food');
    //   expect(localStorageService.expenses.first.description, 'Groceries');
    // });

    test('should delete expense data', () async {
      final expense = ExpenseDataModel(
        id: '1',
        amount: 50.0,
        date: DateTime.now(),
        type: 'Food',
        description: 'Groceries',
      );

      await localStorageService.saveExpenseData(expense);
      await localStorageService.deleteExpenseData(expense.id);

      expect(localStorageService.expenses, isEmpty);
    });

    // test('should delete all data', () async {
    //   const userSettings = UserSettingsModel(
    //     language: 'en',
    //     currency: 'USD',
    //     pushNotificationsEnabled: true,
    //     hour: 9,
    //     minute: 30,
    //   );

    //   await localStorageService.setUserSettingsData(
    //     language: userSettings.language,
    //     currency: userSettings.currency,
    //     pushNotificationsEnabled: userSettings.pushNotificationsEnabled,
    //     hour: userSettings.hour,
    //     minute: userSettings.minute,
    //   );

    //   final expense = ExpenseDataModel(
    //     id: '1',
    //     amount: 50.0,
    //     date: DateTime.now(),
    //     type: 'Food',
    //     description: 'Groceries',
    //   );

    //   await localStorageService.saveExpenseData(expense);
    //   await localStorageService.deleteAllData();

    //   expect(localStorageService.userSettingsData, isNull);
    //   expect(localStorageService.expenses, isEmpty);
    // });
  });
}
