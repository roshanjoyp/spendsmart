import 'package:flutter/material.dart';
import 'package:spendsmart/ui/common/widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

import 'expense_viewmodel.dart';

class ExpenseView extends StackedView<ExpenseViewModel> {
  final GlobalKey<NavigatorState> navigatorKey;
  const ExpenseView({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExpenseViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: const Center(child: Text("Expense view")),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomElevatedButton(
          width: MediaQuery.of(context).size.width,
          text: "Add new Expense",
          onTap: () {
            viewModel.addNewExpense();
          },
          isLoading: viewModel.isBusy,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  ExpenseViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExpenseViewModel(navigatorKey);
}
