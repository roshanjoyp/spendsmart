import 'package:flutter/material.dart';

import '../settings_viewmodel.dart';

class GenerateMockDataTile extends StatelessWidget {
  final SettingsViewModel viewModel;

  const GenerateMockDataTile({required this.viewModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await viewModel.generatemockData();
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text("Generate mock data"),
          leading: Icon(
            Icons.generating_tokens,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
