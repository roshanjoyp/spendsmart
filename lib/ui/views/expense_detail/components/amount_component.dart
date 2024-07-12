import 'package:flutter/material.dart';
import 'package:spendsmart/ui/views/expense_detail/expense_detail_viewmodel.dart';

class AmountComponent extends StatelessWidget {
  final ExpenseDetailViewModel viewModel;
  const AmountComponent(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: viewModel.amountController,
      decoration: InputDecoration(
        labelText: 'Amount',
        border: const OutlineInputBorder(),
        errorText: viewModel.amountInputValidationMessage,
        prefixText: viewModel.curerencyText,
        prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            viewModel.amountController.clear();
            viewModel.amountChanged('');
          },
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold),
      onChanged: (value) => viewModel.amountChanged(value),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
