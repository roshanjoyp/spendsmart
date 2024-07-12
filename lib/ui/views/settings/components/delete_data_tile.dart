import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spendsmart/ui/common/app_colors.dart';

import '../settings_viewmodel.dart';

class DeleteDataTile extends StatelessWidget {
  final SettingsViewModel viewModel;

  const DeleteDataTile({required this.viewModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewModel.deleteAllData,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.deleteAllData),
          leading: const Icon(
            Icons.delete,
            color: kcDeleteColor,
          ),
        ),
      ),
    );
  }
}
