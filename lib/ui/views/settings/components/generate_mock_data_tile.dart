import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings_viewmodel.dart';

class GenerateMockDataTile extends StatelessWidget {
  final SettingsViewModel viewModel;

  const GenerateMockDataTile({required this.viewModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await viewModel.generateMockData();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text(AppLocalizations.of(context)!.genereateMockData),
          leading: const Icon(
            Icons.generating_tokens,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
