import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'summary_viewmodel.dart';

class SummaryView extends StackedView<SummaryViewModel> {
  const SummaryView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SummaryViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Monthly Summary'),
      ),
      body: RefreshIndicator(
        onRefresh: viewModel.refresh,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView.builder(
            itemCount: viewModel.monthlySummaries.length,
            itemBuilder: (context, index) {
              final monthlySummary = viewModel.monthlySummaries[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: Card(
                  child: ExpansionTile(
                    title: Text(
                      "${monthlySummary.month.month}/${monthlySummary.month.year}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Total: ${monthlySummary.totalAmount}"),
                        Text(
                            "Change: ${monthlySummary.percentageChange.toStringAsFixed(2)}%"),
                      ],
                    ),
                    children: monthlySummary.typeSummaries.map((typeSummary) {
                      return ListTile(
                        title: Text(typeSummary.type),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Amount: ${typeSummary.totalAmount}"),
                            Text(
                                "Percentage: ${typeSummary.percentage.toStringAsFixed(2)}%"),
                            Text("Entries: ${typeSummary.entryCount}"),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  SummaryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SummaryViewModel();
}
