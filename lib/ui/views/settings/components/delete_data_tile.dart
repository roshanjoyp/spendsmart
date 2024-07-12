import 'package:flutter/material.dart';
import 'package:spendsmart/ui/common/app_colors.dart';

import '../settings_viewmodel.dart';

class DeleteDataTile extends StatelessWidget {
  final SettingsViewModel viewModel;

  const DeleteDataTile({required this.viewModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: viewModel.deleteAllData,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text("Delete All Data"),
          leading: Icon(
            Icons.delete,
            color: kcDeleteColor,
          ),
        ),
      ),
    );
  }
}
