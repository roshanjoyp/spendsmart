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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
      ),
    );
  }

  @override
  SummaryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SummaryViewModel();
}
