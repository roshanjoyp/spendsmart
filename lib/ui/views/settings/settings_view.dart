import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'components/daily_notification_tile.dart';
import 'components/delete_data_tile.dart';
import 'components/generate_mock_data_tile.dart';
import 'components/language_currency_tile.dart';
import 'components/notification_time_tile.dart';
import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          LanguageCurrencyTile(viewModel: viewModel),
          DailyNotificationTile(viewModel: viewModel),
          if (viewModel.isDailyNotificationOn)
            NotificationTimeTile(viewModel: viewModel),
          const SizedBox(height: 50),
          GenerateMockDataTile(viewModel: viewModel),
          DeleteDataTile(viewModel: viewModel),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(BuildContext context) =>
      SettingsViewModel();
}
