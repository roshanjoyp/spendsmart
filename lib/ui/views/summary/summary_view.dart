import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:spendsmart/ui/common/app_colors.dart';
import 'package:spendsmart/util/number_format_util.dart';
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
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: viewModel.refresh,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              title: Text(AppLocalizations.of(context)!.monthlySummary),
              backgroundColor: Colors.white,
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final monthlySummary = viewModel.monthlySummaries[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Material(
                              elevation: 20,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kcPrimaryColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // margin: const EdgeInsets.symmetric(
                                //     horizontal: 8, vertical: 4),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.calendar_today,
                                    color: Colors.white,
                                  ),
                                  title: Text(
                                    DateFormat('MMMM yyyy', viewModel.getLocale)
                                        .format(monthlySummary.month),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  subtitle: Text(
                                    "${monthlySummary.percentageChange.abs().toStringAsFixed(2)}% ${monthlySummary.percentageChange >= 0 ? AppLocalizations.of(context)!.more : AppLocalizations.of(context)!.less} ${AppLocalizations.of(context)!.thanPreviousMonth}",
                                    style: TextStyle(
                                      color:
                                          monthlySummary.percentageChange >= 0
                                              ? Colors.red
                                              : const Color.fromARGB(
                                                  255, 75, 233, 80),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: Text(
                                    NumberFormatUtil.formatAmountUsingNumberFormatCompact(
                                        amount: monthlySummary.totalAmount
                                            .toDouble(),
                                        locale: viewModel.getLocale,
                                        currency: viewModel.getCurrency),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ...monthlySummary.typeSummaries.map((typeSummary) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: kcPrimaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      typeSummary.type[0].toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  typeSummary.type,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  "${typeSummary.percentage.toStringAsFixed(2)}% ${AppLocalizations.of(context)!.ofTotalMonthSpend}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                trailing: Text(
                                  NumberFormatUtil
                                      .formatAmountUsingNumberFormatCompact(
                                          amount: typeSummary.totalAmount
                                              .toDouble(),
                                          locale: viewModel.getLocale,
                                          currency: viewModel.getCurrency),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }).toList(),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: viewModel.monthlySummaries.length,
                ),
              ),
            ),
          ],
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
