import 'package:flutter/material.dart';
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
          title: const Text("Daily Notification"),
          leading: const Icon(
            Icons.notifications,
            color: kcPrimaryColor,
          ),
          subtitle: const Text("We recommend turning on daily notification"),
          trailing: Switch(
            value: viewModel.isDailyNotificationOn,
            onChanged: viewModel.onDailyNotificationToggle,
          ),
        ),
      ),
    );
  }
}
