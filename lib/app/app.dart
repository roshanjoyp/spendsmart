import 'package:spendsmart/services/expense_service.dart';
import 'package:spendsmart/services/local_storage_service.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:spendsmart/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:spendsmart/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:spendsmart/ui/views/expense/expense_view.dart';
import 'package:spendsmart/ui/views/expense_detail/expense_detail_view.dart';
import 'package:spendsmart/ui/views/expense_navigator/expense_navigator_view.dart';
import 'package:spendsmart/ui/views/home/home_view.dart';
import 'package:spendsmart/ui/views/language/language_view.dart';
import 'package:spendsmart/ui/views/settings/settings_view.dart';
import 'package:spendsmart/ui/views/startup/startup_view.dart';
import 'package:spendsmart/ui/views/summary/summary_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  logger: StackedLogger(),
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LanguageView),
    MaterialRoute(page: ExpenseView),
    MaterialRoute(page: SummaryView),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: ExpenseDetailView),
    MaterialRoute(page: ExpenseNavigatorView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LocalStorageService),
    LazySingleton(classType: ExpenseService),
    LazySingleton(classType: UserSettingsService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
