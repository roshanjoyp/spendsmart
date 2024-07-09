import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'language_viewmodel.dart';

class LanguageView extends StackedView<LanguageViewModel> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LanguageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("Language View")),
      ),
    );
  }

  @override
  LanguageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LanguageViewModel();
}
