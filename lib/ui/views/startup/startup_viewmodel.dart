import 'package:spendsmart/app/app.locator.dart';
import 'package:spendsmart/app/app.logger.dart';
import 'package:spendsmart/app/app.router.dart';
import 'package:spendsmart/services/user_settings_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class StartupViewModel extends BaseViewModel {
  final logger = getLogger('StartupViewModel');
  final NavigationService _navigationService = locator<NavigationService>();
  final UserSettingsService _userSettingsService =
      locator<UserSettingsService>();

  // Place anything here that needs to happen before we get into the application
  Future<void> runStartupLogic() async {
    logger.i('Running startup logic');
    await Future.delayed(const Duration(seconds: 1));

    if (_userSettingsService.userSettingsData == null) {
      logger.i('No user settings data found, navigating to LanguageView');
      _navigationService.replaceWithLanguageView();
    } else {
      logger.i('User settings data found, navigating to HomeView');
      _navigationService.replaceWithHomeView();
    }
  }
}
