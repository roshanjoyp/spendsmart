import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spendsmart/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import '../expense_navigator/expense_navigator_view.dart';
import '../settings/settings_view.dart';
import '../summary/summary_view.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            IndexedStack(
              index: viewModel.currentIndex,
              children: [
                ExpenseNavigatorView(
                  navigatorKey: viewModel.expenseViewNavigationKey,
                ),
                const SummaryView(),
                const SettingsView(),
              ],
            )
          ],
        ),
      ),
      extendBody: false,
      bottomNavigationBar: ClipRRect(
        child: BottomNavigationBar(
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: viewModel.currentIndex,
          backgroundColor: Colors.white,
          selectedItemColor: kcPrimaryColor,
          onTap: (value) async {
            if (viewModel.currentIndex == value) {
              await viewModel.navigateBack(goBack: false);
            } else {
              viewModel.setIndex(value);
            }
          },
          selectedFontSize: 16,
          unselectedFontSize: 16,
          items: [
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.expenses,
              icon: const Icon(Icons.local_offer_outlined),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.summary,
              icon: const Icon(Icons.search_outlined),
            ),
            BottomNavigationBarItem(
              label: AppLocalizations.of(context)!.settings,
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
