import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: viewModel.dailySummaries.isEmpty
            ? const Center(child: Text('No expenses found'))
            : ListView.builder(
                itemCount: viewModel.dailySummaries.length,
                itemBuilder: (context, index) {
                  final dailySummary = viewModel.dailySummaries[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Text(
                              dailySummary.date.day.toString(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                          title: Text(
                            DateFormat('EEEE, MMM, y')
                                .format(dailySummary.date),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${dailySummary.percentageChange.abs().toStringAsFixed(2)}% ${dailySummary.percentageChange >= 0 ? 'more' : 'less'} than previous day",
                            style: TextStyle(
                              color: dailySummary.percentageChange >= 0
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Text(
                            dailySummary.totalAmount.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      ...dailySummary.expenses.map((expense) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple[100],
                            child: Text(
                              expense.type[0].toUpperCase(),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                          title: Text(
                            expense.type,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text(
                            expense.description ?? 'No description',
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: Text(
                            expense.amount.toString(),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
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
