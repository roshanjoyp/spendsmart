import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'expense_detail_viewmodel.dart';

class ExpenseDetailView extends StackedView<ExpenseDetailViewModel> {
  const ExpenseDetailView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExpenseDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("Detail")),
      ),
    );
  }

  @override
  ExpenseDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExpenseDetailViewModel();
}
