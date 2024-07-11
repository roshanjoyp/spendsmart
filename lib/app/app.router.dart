// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/foundation.dart' as _i11;
import 'package:flutter/material.dart' as _i10;
import 'package:flutter/material.dart';
import 'package:spendsmart/models/local/expense_data_model.dart' as _i12;
import 'package:spendsmart/ui/views/expense/expense_view.dart' as _i5;
import 'package:spendsmart/ui/views/expense_detail/expense_detail_view.dart'
    as _i8;
import 'package:spendsmart/ui/views/expense_navigator/expense_navigator_view.dart'
    as _i9;
import 'package:spendsmart/ui/views/home/home_view.dart' as _i2;
import 'package:spendsmart/ui/views/language/language_view.dart' as _i4;
import 'package:spendsmart/ui/views/settings/settings_view.dart' as _i7;
import 'package:spendsmart/ui/views/startup/startup_view.dart' as _i3;
import 'package:spendsmart/ui/views/summary/summary_view.dart' as _i6;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i13;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const languageView = '/language-view';

  static const expenseView = '/expense-view';

  static const summaryView = '/summary-view';

  static const settingsView = '/settings-view';

  static const expenseDetailView = '/expense-detail-view';

  static const expenseNavigatorView = '/expense-navigator-view';

  static const all = <String>{
    homeView,
    startupView,
    languageView,
    expenseView,
    summaryView,
    settingsView,
    expenseDetailView,
    expenseNavigatorView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.languageView,
      page: _i4.LanguageView,
    ),
    _i1.RouteDef(
      Routes.expenseView,
      page: _i5.ExpenseView,
    ),
    _i1.RouteDef(
      Routes.summaryView,
      page: _i6.SummaryView,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i7.SettingsView,
    ),
    _i1.RouteDef(
      Routes.expenseDetailView,
      page: _i8.ExpenseDetailView,
    ),
    _i1.RouteDef(
      Routes.expenseNavigatorView,
      page: _i9.ExpenseNavigatorView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.LanguageView: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.LanguageView(),
        settings: data,
      );
    },
    _i5.ExpenseView: (data) {
      final args = data.getArgs<ExpenseViewArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i5.ExpenseView(key: args.key, navigatorKey: args.navigatorKey),
        settings: data,
      );
    },
    _i6.SummaryView: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.SummaryView(),
        settings: data,
      );
    },
    _i7.SettingsView: (data) {
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.SettingsView(),
        settings: data,
      );
    },
    _i8.ExpenseDetailView: (data) {
      final args = data.getArgs<ExpenseDetailViewArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) =>
            _i8.ExpenseDetailView(args.expenseDataModel, key: args.key),
        settings: data,
      );
    },
    _i9.ExpenseNavigatorView: (data) {
      final args = data.getArgs<ExpenseNavigatorViewArguments>(nullOk: false);
      return _i10.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.ExpenseNavigatorView(
            key: args.key, navigatorKey: args.navigatorKey),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class ExpenseViewArguments {
  const ExpenseViewArguments({
    this.key,
    required this.navigatorKey,
  });

  final _i11.Key? key;

  final _i10.GlobalKey<_i10.NavigatorState> navigatorKey;

  @override
  String toString() {
    return '{"key": "$key", "navigatorKey": "$navigatorKey"}';
  }

  @override
  bool operator ==(covariant ExpenseViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.navigatorKey == navigatorKey;
  }

  @override
  int get hashCode {
    return key.hashCode ^ navigatorKey.hashCode;
  }
}

class ExpenseDetailViewArguments {
  const ExpenseDetailViewArguments({
    required this.expenseDataModel,
    this.key,
  });

  final _i12.ExpenseDataModel? expenseDataModel;

  final _i11.Key? key;

  @override
  String toString() {
    return '{"expenseDataModel": "$expenseDataModel", "key": "$key"}';
  }

  @override
  bool operator ==(covariant ExpenseDetailViewArguments other) {
    if (identical(this, other)) return true;
    return other.expenseDataModel == expenseDataModel && other.key == key;
  }

  @override
  int get hashCode {
    return expenseDataModel.hashCode ^ key.hashCode;
  }
}

class ExpenseNavigatorViewArguments {
  const ExpenseNavigatorViewArguments({
    this.key,
    required this.navigatorKey,
  });

  final _i11.Key? key;

  final _i10.GlobalKey<_i10.NavigatorState> navigatorKey;

  @override
  String toString() {
    return '{"key": "$key", "navigatorKey": "$navigatorKey"}';
  }

  @override
  bool operator ==(covariant ExpenseNavigatorViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.navigatorKey == navigatorKey;
  }

  @override
  int get hashCode {
    return key.hashCode ^ navigatorKey.hashCode;
  }
}

extension NavigatorStateExtension on _i13.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLanguageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.languageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExpenseView({
    _i11.Key? key,
    required _i10.GlobalKey<_i10.NavigatorState> navigatorKey,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.expenseView,
        arguments: ExpenseViewArguments(key: key, navigatorKey: navigatorKey),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSummaryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.summaryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExpenseDetailView({
    required _i12.ExpenseDataModel? expenseDataModel,
    _i11.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.expenseDetailView,
        arguments: ExpenseDetailViewArguments(
            expenseDataModel: expenseDataModel, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExpenseNavigatorView({
    _i11.Key? key,
    required _i10.GlobalKey<_i10.NavigatorState> navigatorKey,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.expenseNavigatorView,
        arguments:
            ExpenseNavigatorViewArguments(key: key, navigatorKey: navigatorKey),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLanguageView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.languageView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExpenseView({
    _i11.Key? key,
    required _i10.GlobalKey<_i10.NavigatorState> navigatorKey,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.expenseView,
        arguments: ExpenseViewArguments(key: key, navigatorKey: navigatorKey),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSummaryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.summaryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExpenseDetailView({
    required _i12.ExpenseDataModel? expenseDataModel,
    _i11.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.expenseDetailView,
        arguments: ExpenseDetailViewArguments(
            expenseDataModel: expenseDataModel, key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExpenseNavigatorView({
    _i11.Key? key,
    required _i10.GlobalKey<_i10.NavigatorState> navigatorKey,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.expenseNavigatorView,
        arguments:
            ExpenseNavigatorViewArguments(key: key, navigatorKey: navigatorKey),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
