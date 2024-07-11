import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'components/amount_component.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          child: ListView(
            children: [
              AmountComponent(viewModel),
              //DateComponenet
              //CategoryComponent
              //DescriptionComponent
              //AddNewExpenseButton
              //UpdateButton
              //DeleteButton
            ],
          ),
        ),
      ),
    );
  }

  @override
  ExpenseDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExpenseDetailViewModel();
}
