import 'package:flutter/material.dart';
import 'package:spendsmart/ui/common/app_colors.dart';

import '../settings_viewmodel.dart';

class LanguageCurrencyTile extends StatelessWidget {
  final SettingsViewModel viewModel;

  const LanguageCurrencyTile({required this.viewModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          leading: const Icon(Icons.language, color: kcPrimaryColor),
          title: Text(viewModel.language),
          subtitle: Text(viewModel.currency),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: viewModel.onLanguageCurrencyTap,
        ),
      ),
    );
  }
}
