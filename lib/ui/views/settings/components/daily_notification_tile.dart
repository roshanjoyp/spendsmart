import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spendsmart/ui/common/app_colors.dart';

import '../settings_viewmodel.dart';

class DailyNotificationTile extends StatelessWidget {
  final SettingsViewModel viewModel;

  const DailyNotificationTile({required this.viewModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.dailyNotification),
          leading: const Icon(
            Icons.notifications,
            color: kcPrimaryColor,
          ),
          subtitle: Text(AppLocalizations.of(context)!
              .weRecommendTurningOnDailyNotification),
          trailing: Switch(
            value: viewModel.isDailyNotificationOn,
            onChanged: viewModel.onDailyNotificationToggle,
          ),
        ),
      ),
    );
  }
}
