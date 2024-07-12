import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/models/local/user_settings_model.dart';
import 'package:stacked/stacked.dart';

const String userCollectionString = 'userCollection';
const String userSettingsDataBoxString = 'userSettingsDataBox';
const String expenseDataBoxString = 'expenseDataBox';

class LocalStorageService with ListenableServiceMixin {
  final logger = getLogger('LocalStorageService');

  UserSettingsModel? _userSettingsData;
  late List<ExpenseDataModel> _expenses;
  late BoxCollection _appDB;
  late CollectionBox _userSettingsDataBox;
  late CollectionBox _expenseDataBox;
  late Directory _directory;

  final Completer<void> _initializationCompleter = Completer<void>();
  Future<void> get initializationCompleted => _initializationCompleter.future;

  UserSettingsModel? get userSettingsData => _userSettingsData;
  List<ExpenseDataModel> get expenses => _expenses;

  LocalStorageService() {
    _expenses = [];
    logger.i('LocalStorageService initialization starting');
    _initialise();
  }

  void _initialise() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      if (kIsWeb) {
        await Hive.initFlutter();

        _appDB = await BoxCollection.open(
          userCollectionString,
          {
            userSettingsDataBoxString,
            expenseDataBoxString,
          },
        );
      } else {
        _directory = await getApplicationDocumentsDirectory();
        await _directory.create(recursive: true);
        var dbPath = '${_directory.path}/spendSmartDB';
        await Hive.initFlutter(dbPath);

        _appDB = await BoxCollection.open(
          userCollectionString,
          {
            userSettingsDataBoxString,
            expenseDataBoxString,
          },
          path: dbPath,
        );
      }

      _userSettingsDataBox =
          await _appDB.openBox<dynamic>(userSettingsDataBoxString);
      _expenseDataBox = await _appDB.openBox<dynamic>(expenseDataBoxString);

      await _loadUserSettings();
      await _loadExpenses();
      notifyListeners();
    } catch (e) {
      logger.e('Error during initialization: $e');
    } finally {
      _initializationCompleter.complete();
      logger.i('LocalStorageService initialization completed');
    }
  }

  Future<void> _loadUserSettings() async {
    try {
      Map<String, dynamic> data = Map.from(
          (await _userSettingsDataBox.get("localUserSettingsData")) ?? {});
      _userSettingsData = data.isEmpty ? null : UserSettingsModel.fromMap(data);
    } catch (e) {
      logger.e('Error loading user settings: $e');
    }
  }

  Future<void> _loadExpenses() async {
    if (_userSettingsData != null) {
      try {
        Map<String, dynamic> items = (await _expenseDataBox.getAllValues());
        items.forEach((key, value) {
          _expenses.add(ExpenseDataModel.fromJson(value));
        });
      } catch (e) {
        logger.e('Error loading expenses: $e');
      }
    }
  }

  Future<void> setUserSettingsData({
    String? language,
    String? currency,
    bool? pushNotificationsEnabled,
    int? hour,
    int? minute,
  }) async {
    _userSettingsData = UserSettingsModel(
      language: language ?? _userSettingsData?.language,
      currency: currency ?? _userSettingsData?.currency,
      pushNotificationsEnabled: pushNotificationsEnabled ??
          _userSettingsData?.pushNotificationsEnabled,
      hour: hour ?? _userSettingsData?.hour,
      minute: minute ?? _userSettingsData?.minute,
    );
    notifyListeners();
  }

  Future<void> saveUserSettingsData() async {
    try {
      if (_userSettingsData != null) {
        await _userSettingsDataBox.put(
            "localUserSettingsData", _userSettingsData!.toMap());
        logger.i('User settings saved successfully');
      }
    } catch (e) {
      logger.e('Error saving user settings: $e');
    }
  }

  Future<void> saveExpenseData(ExpenseDataModel expenseDataModel) async {
    try {
      await _expenseDataBox.put(expenseDataModel.id, expenseDataModel.toJson());
      int index =
          _expenses.indexWhere((element) => element.id == expenseDataModel.id);
      if (index == -1) {
        _expenses.add(expenseDataModel);
      } else {
        _expenses[index] = expenseDataModel;
      }
      notifyListeners();
      logger.i('Expense data saved successfully');
    } catch (e) {
      logger.e('Error saving expense data: $e');
    }
  }

  Future<void> deleteAllData() async {
    try {
      await _userSettingsDataBox.clear();
      await _expenseDataBox.clear();
      _userSettingsData = null;
      _expenses.clear();
      notifyListeners();
      logger.i('All data deleted successfully');
    } catch (e) {
      logger.e('Error deleting all data: $e');
    }
  }

  Future<void> deleteExpenseData(String id) async {
    try {
      await _expenseDataBox.delete(id);
      _expenses.removeWhere((element) => element.id == id);
      notifyListeners();
      logger.i('Expense data deleted successfully');
    } catch (e) {
      logger.e('Error deleting expense data: $e');
    }
  }
}
