import 'package:flutter/widgets.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:stacked/stacked.dart';

// class HomeViewModel extends BaseViewModel {
//   final _dialogService = locator<DialogService>();
//   final _bottomSheetService = locator<BottomSheetService>();

//   String get counterLabel => 'Counter is: $_counter';

//   int _counter = 0;

//   void incrementCounter() {
//     _counter++;
//     rebuildUi();
//   }

//   void showDialog() {
//     _dialogService.showCustomDialog(
//       variant: DialogType.infoAlert,
//       title: 'Stacked Rocks!',
//       description: 'Give stacked $_counter stars on Github',
//     );
//   }

//   void showBottomSheet() {
//     _bottomSheetService.showCustomSheet(
//       variant: BottomSheetType.notice,
//       title: ksHomeBottomSheetTitle,
//       description: ksHomeBottomSheetDescription,
//     );
//   }
// }

class HomeViewModel extends IndexTrackingViewModel {
  final logger = getLogger('HomeViewModel');

  final GlobalKey<NavigatorState> _expenseViewNavigationKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _summaryViewNavigationKey =
      GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _settingsViewNavigationKey =
      GlobalKey<NavigatorState>();
  final GlobalKey _bottomNavBarKey = GlobalKey();

  GlobalKey<NavigatorState> get expenseViewNavigationKey =>
      _expenseViewNavigationKey;
  GlobalKey<NavigatorState> get summaryViewNavigationKey =>
      _summaryViewNavigationKey;
  GlobalKey<NavigatorState> get settingsViewNavigationKey =>
      _settingsViewNavigationKey;
  GlobalKey get bottomNavBarKey => _bottomNavBarKey;

  Future<void> navigateBack({required bool goBack}) async {
    switch (currentIndex) {
      case 0:
        {
          if (_expenseViewNavigationKey.currentState?.canPop() ?? false) {
            _expenseViewNavigationKey.currentState!.pop();
            logger.i('Navigated back in expense view');
          } else {
            logger.i('No navigation stack in expense view to pop');
          }
          break;
        }
      case 1:
        {
          if (_summaryViewNavigationKey.currentState?.canPop() ?? false) {
            _summaryViewNavigationKey.currentState!.pop();
            logger.i('Navigated back in summary view');
          } else {
            logger.i('No navigation stack in summary view to pop');
          }
          break;
        }
      case 2:
        {
          if (_settingsViewNavigationKey.currentState?.canPop() ?? false) {
            _settingsViewNavigationKey.currentState!.pop();
            logger.i('Navigated back in settings view');
          } else {
            logger.i('No navigation stack in settings view to pop');
          }
          break;
        }
      default:
        logger.w('Invalid index for navigation');
    }
  }
}
