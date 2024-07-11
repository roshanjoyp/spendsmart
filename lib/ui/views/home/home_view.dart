import 'package:flutter/material.dart';
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
          selectedItemColor: Colors.black,
          onTap: (value) async {
            viewModel.setIndex(value);
          },
          selectedFontSize: 16,
          unselectedFontSize: 16,
          items: const [
            BottomNavigationBarItem(
              label: 'Expenses',
              icon: Icon(Icons.local_offer_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Summary',
              icon: Icon(Icons.search_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Settings',
              icon: Icon(Icons.settings_outlined),
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
