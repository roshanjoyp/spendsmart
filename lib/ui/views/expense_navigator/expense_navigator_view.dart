import 'package:flutter/material.dart';
import 'package:spendsmart/ui/common/widgets/custom_page_route.dart';
import 'package:spendsmart/ui/views/expense/expense_view.dart';
import 'package:spendsmart/ui/views/expense_detail/expense_detail_view.dart';
import 'package:stacked/stacked.dart';

import 'expense_navigator_viewmodel.dart';

class ExpenseNavigatorView extends StackedView<ExpenseNavigatorViewModel> {
  final GlobalKey<NavigatorState> navigatorKey;
  const ExpenseNavigatorView({
    Key? key,
    required this.navigatorKey,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExpenseNavigatorViewModel viewModel,
    Widget? child,
  ) {
    return Navigator(
      key: viewModel.navigatorKey,
      onGenerateRoute: (settings) {
        if (settings.name == "/") {
          return MyRoute(
            builder: (context) {
              return ExpenseView(
                navigatorKey: viewModel.navigatorKey,
              );
            },
          );
        } else if (settings.name == "/expense-detail-view") {
          // var data = settings.arguments as List<Object>;

          return MyRoute(
            builder: (context) {
              return const ExpenseDetailView();
            },
          );
        } else {
          return MyRoute(
            builder: (context) {
              return Container();
            },
          );
        }
      },
    );
  }

  @override
  ExpenseNavigatorViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExpenseNavigatorViewModel(navigatorKey);
}
