import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendsmart/ui/common/app_colors.dart';
import 'package:spendsmart/ui/common/widgets/custom_elevated_button.dart';
import 'package:spendsmart/util/number_format_util.dart';
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
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: viewModel.refresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              title: const Text('Expenses'),
              backgroundColor: Colors.white,
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
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              sliver: viewModel.dailySummaries.isEmpty
                  ? const SliverFillRemaining(
                      child: Center(child: Text('No Expenses Found')),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final dailySummary = viewModel.dailySummaries[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Material(
                                  elevation: 10,
                                  borderRadius: BorderRadius.circular(8),
                                  child: Container(
                                    //margin: const EdgeInsets.symmetric(vertical: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: ListTile(
                                      leading: const SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Center(
                                          child: Icon(
                                            Icons.calendar_today,
                                            color: kcPrimaryColor,
                                          ),
                                        ),
                                      ),
                                      title: Text(
                                        DateFormat('d EEEE MMM, y')
                                            .format(dailySummary.date),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        "${dailySummary.percentageChange.abs().toStringAsFixed(2)}% ${dailySummary.percentageChange >= 0 ? 'more' : 'less'} than previous day",
                                        style: TextStyle(
                                          color:
                                              dailySummary.percentageChange >= 0
                                                  ? Colors.red
                                                  : Colors.green,
                                          fontSize: 14,
                                        ),
                                      ),
                                      trailing: Text(
                                        NumberFormatUtil
                                                .formatAmountUsingNumberFormatCompact(
                                                    amount: dailySummary
                                                        .totalAmount
                                                        .toDouble(),
                                                    locale: viewModel.getLocale,
                                                    currency:
                                                        viewModel.getCurrency)
                                            .toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ...dailySummary.expenses.map((expense) {
                                return GestureDetector(
                                  onTap: () {
                                    viewModel.editExpense(expense);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Material(
                                      elevation: 10,
                                      borderRadius: BorderRadius.circular(8),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.02),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        //margin: const EdgeInsets.only(bottom: 8),
                                        child: ListTile(
                                          leading: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              color: kcPrimaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: Text(
                                                expense.type[0].toUpperCase(),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          title: Text(
                                            expense.type,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                            expense.description ??
                                                'No description',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                          trailing: Text(
                                            NumberFormatUtil
                                                .formatAmountUsingNumberFormatCompact(
                                                    amount: expense.amount
                                                        .toDouble(),
                                                    locale: viewModel.getLocale,
                                                    currency:
                                                        viewModel.getCurrency),
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        },
                        childCount: viewModel.dailySummaries.length,
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: CustomElevatedButton(
          width: MediaQuery.of(context).size.width,
          text: "Add New Expense",
          onTap: () {
            viewModel.addNewExpense();
          },
          isLoading: viewModel.isBusy,
          backgroundColor: kcPrimaryColor,
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
