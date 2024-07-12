import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:spendsmart/ui/common/app_colors.dart';

import '../settings_viewmodel.dart';

class NotificationTimeTile extends StatelessWidget {
  final SettingsViewModel viewModel;

  const NotificationTimeTile({required this.viewModel, Key? key})
      : super(key: key);

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: viewModel.notificationTime,
    );
    if (picked != null && picked != viewModel.notificationTime) {
      viewModel.updateNotificationTime(picked);
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // "jm" is for "8:00 PM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.notificationTime),
          leading: const Icon(
            Icons.punch_clock,
            color: kcPrimaryColor,
          ),
          subtitle: Text(_formatTimeOfDay(viewModel.notificationTime)),
          onTap: () => _selectTime(context),
        ),
      ),
    );
  }
}
