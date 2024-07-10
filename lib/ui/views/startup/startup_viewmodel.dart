import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.router.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _userSettingsService = locator<UserSettingsService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    if (_userSettingsService.userSettingsData == null) {
      _navigationService.replaceWithLanguageView();
    } else {
      _navigationService.replaceWithHomeView();
    }
  }
}
