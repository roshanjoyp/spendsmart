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
  final List<ExpenseDataModel> _expenses = [];

  late BoxCollection _appDB;
  late CollectionBox _userSettingsDataBox;
  late CollectionBox _expenseDataBox;

  UserSettingsModel? get userSettingsData => _userSettingsData;
  List<ExpenseDataModel> get expenses => _expenses;

  final Completer<void> _initializationCompleter = Completer<void>();
  Future<void> get initializationCompleted => _initializationCompleter.future;

  late Directory _directory;

  LocalStorageService() {
    logger.i('LocalStorageService initialization starting');
    _initialise();
  }

  void _initialise() async {
    WidgetsFlutterBinding.ensureInitialized();
    if (kIsWeb) {
      await Hive.initFlutter();
      Hive.registerAdapter(UserSettingsModelAdapter());
      _appDB = await BoxCollection.open(
        userCollectionString, // Name of your database
        {
          userSettingsDataBoxString,
          expenseDataBoxString
        }, // Names of your boxes
      );
    } else {
      _directory = await getApplicationDocumentsDirectory();
      await _directory.create(recursive: true);
      var dbPath = '${_directory.path}/spendSmartDB';
      await Hive.initFlutter(dbPath);
      Hive.registerAdapter(UserSettingsModelAdapter());
      _appDB = await BoxCollection.open(
        userCollectionString, // Name of your database
        {
          userSettingsDataBoxString,
          expenseDataBoxString
        }, // Names of your boxes
        path: dbPath,
      );
    }

    _userSettingsDataBox =
        await _appDB.openBox<dynamic>(userSettingsDataBoxString);

    Map<String, dynamic> data = Map.from(
        (await _userSettingsDataBox.get("localUserSettingsData")) ?? {});

    try {
      _userSettingsData = data == {} ? null : UserSettingsModel.fromJson(data);
    } on TypeError {
      logger.i("Type Error");
    } catch (e) {
      logger.e(e);
    }

    if (_userSettingsData != null) {
      _expenseDataBox =
          await _appDB.openBox<ExpenseDataModel>(expenseDataBoxString);
      Map<String, dynamic> items = (await _expenseDataBox.getAllValues());
      items.forEach((key, value) {
        _expenses.add(ExpenseDataModel.fromJson(value));
      });
    }

    _initializationCompleter.complete();
  }
}
