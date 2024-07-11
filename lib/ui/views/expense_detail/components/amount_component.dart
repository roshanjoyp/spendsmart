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
      ),
      onChanged: (value) => viewModel.amountChanged(value),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
    );
  }
}
