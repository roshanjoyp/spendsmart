import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        child: Center(child: Text(AppLocalizations.of(context)!.langugaeView)),
      ),
    );
  }

  @override
  LanguageViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      LanguageViewModel();
}
