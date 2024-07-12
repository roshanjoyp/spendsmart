import 'package:flutter/material.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
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
      appBar: AppBar(
        title: const Text('Expenses'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () async {
              final DateTimeRange? picked = await showDateRangePicker(
                context: context,
                firstDate: viewModel.firstDate,
                lastDate: viewModel.lastDate,
              );
              if (picked != null) {
                viewModel.filterExpensesByDate(picked.start, picked.end);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: viewModel.clearFilters,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        child: ListView.builder(
          itemBuilder: (context, index) {
            ExpenseDataModel expense = viewModel.allExpenses[index];
            return GestureDetector(
              onTap: () => viewModel.editExpense(expense),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      expense.type,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${expense.date.toLocal()}'.split(' ')[0],
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Text(
                      expense.amount.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: viewModel.allExpenses.length,
        ),
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
  ) {
    final viewModel = ExpenseViewModel(navigatorKey);
    viewModel.initialize();
    return viewModel;
  }
}
