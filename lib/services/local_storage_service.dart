import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/models/local/user_data_model.dart';
import 'package:stacked/stacked.dart';

class LocalStorageService with ListenableServiceMixin {
  final logger = getLogger('LocalStorageService');
  UserDataModel? _userData;

  late BoxCollection _appDB;
  late CollectionBox _userDataBox;

  UserDataModel? get userData => _userData;

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
      Hive.registerAdapter(UserDataModelAdapter());
      _appDB = await BoxCollection.open(
        'userCollection', // Name of your database
        {
          'userData',
        }, // Names of your boxes
      );
    } else {
      _directory = await getApplicationDocumentsDirectory();
      await _directory.create(recursive: true);
      var dbPath = '${_directory.path}/spendSmartDB';
      await Hive.initFlutter(dbPath);
      Hive.registerAdapter(UserDataModelAdapter());
      _appDB = await BoxCollection.open(
        'userCollection', // Name of your database
        {
          'userData',
        }, // Names of your boxes
        path: dbPath,
      );
    }

    _userDataBox = await _appDB.openBox<dynamic>('userData');

    Map<String, dynamic> data =
        Map.from((await _userDataBox.get("localUserData")) ?? {});

    try {
      _userData = data == {} ? null : UserDataModel.fromJson(data);
    } on TypeError {
      logger.i("Type Error");
    } catch (e) {
      logger.e(e);
    }

    if (_userData != null) {}

    _initializationCompleter.complete();
  }
}
