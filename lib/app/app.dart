import 'package:spendsmart/services/local_storage_service.dart';
import 'package:spendsmart/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:spendsmart/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:spendsmart/ui/views/home/home_view.dart';
import 'package:spendsmart/ui/views/language/language_view.dart';
import 'package:spendsmart/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  logger: StackedLogger(),
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: LanguageView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: LocalStorageService),
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
