import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

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
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
        children: [
          GestureDetector(
              onTap: () => viewModel.deleteAllData(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text("Delete All Data"),
                  leading: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              )),
          GestureDetector(
              onTap: () => viewModel.generatemockData(),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text("Generate mock data"),
                  leading: Icon(
                    Icons.generating_tokens,
                    color: Colors.green,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingsViewModel();
}
