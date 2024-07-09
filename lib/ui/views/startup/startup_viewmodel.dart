import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.router.dart';
import 'package:spendsmart/services/local_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _localStorageService = locator<LocalStorageService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    await _localStorageService.initializationCompleted;

    if (_localStorageService.userData == null) {
      _navigationService.replaceWithLanguageView();
    } else {
      _navigationService.replaceWithHomeView();
    }
  }
}
