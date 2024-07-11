import 'package:flutter/widgets.dart';
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

  navigateBack({required bool goBack}) async {
    switch (currentIndex) {
      case 0:
        {
          if (_expenseViewNavigationKey.currentState?.canPop() ?? false) {
            _expenseViewNavigationKey.currentState!.pop();
          }
          break;
        }
      default:
    }
  }
}
