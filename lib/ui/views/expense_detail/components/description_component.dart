import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spendsmart/ui/views/expense_detail/expense_detail_viewmodel.dart';

class DescriptionComponent extends StatelessWidget {
  final ExpenseDetailViewModel viewModel;
  const DescriptionComponent(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: viewModel.descriptionController,
      minLines: 3,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context)!.aShortDescription,
        border: const OutlineInputBorder(),
      ),
    );
  }
}
