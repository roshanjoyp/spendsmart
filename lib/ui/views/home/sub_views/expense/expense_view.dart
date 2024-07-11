import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'expense_viewmodel.dart';

class ExpenseView extends StackedView<ExpenseViewModel> {
  const ExpenseView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExpenseViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Text("Expense view"),
      ),
    );
  }

  @override
  ExpenseViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExpenseViewModel();
}
