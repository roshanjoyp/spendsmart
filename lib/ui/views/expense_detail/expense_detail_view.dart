import 'package:flutter/material.dart';
import 'package:spendsmart/ui/common/widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

import 'components/amount_component.dart';
import 'components/category_component.dart';
import 'components/date_component.dart';
import 'components/description_component.dart';
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
              DateComponent(viewModel),
              CategoryComponent(viewModel),
              DescriptionComponent(viewModel),
              //AddNewExpenseButton
              if (viewModel.isNewEntry)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomElevatedButton(
                      width: double.infinity,
                      text: "Add new expense",
                      onTap: () async {
                        await viewModel.addNewExpense();
                        Navigator.of(context).pop();
                      },
                      isLoading: viewModel.isBusy,
                      backgroundColor: Colors.deepPurple,
                      textColor: Colors.white),
                ),

              //UpdateButton
              if (!viewModel.isNewEntry)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomElevatedButton(
                      width: double.infinity,
                      text: "Update expense",
                      onTap: viewModel.updateExpense,
                      isLoading: viewModel.isBusy,
                      backgroundColor: Colors.deepPurple,
                      textColor: Colors.white),
                ),

              //DeleteButton
              if (!viewModel.isNewEntry)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomElevatedButton(
                      width: double.infinity,
                      text: "Delete expense",
                      onTap: viewModel.deleteExpense,
                      isLoading: viewModel.isBusy,
                      backgroundColor: Colors.red,
                      textColor: Colors.white),
                ),
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
