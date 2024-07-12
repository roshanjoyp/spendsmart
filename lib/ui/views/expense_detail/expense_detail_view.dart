import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spendsmart/models/local/expense_data_model.dart';
import 'package:spendsmart/ui/common/app_colors.dart';
import 'package:spendsmart/ui/common/widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

import 'components/amount_component.dart';
import 'components/category_component.dart';
import 'components/date_component.dart';
import 'components/description_component.dart';
import 'expense_detail_viewmodel.dart';

class ExpenseDetailView extends StackedView<ExpenseDetailViewModel> {
  final ExpenseDataModel? _expenseDataModel;
  const ExpenseDetailView(
    this._expenseDataModel, {
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ExpenseDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Form(
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),
              AmountComponent(viewModel),
              DateComponent(viewModel),
              CategoryComponent(viewModel),
              DescriptionComponent(viewModel),
              //AddNewExpenseButton
              if (viewModel.isNewEntry)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomElevatedButton(
                      width: double.infinity,
                      text: AppLocalizations.of(context)!.addNewExpense,
                      onTap: () async {
                        bool result = await viewModel.addNewExpense();
                        if (result) {
                          Navigator.of(context).pop();
                        }
                      },
                      isLoading: viewModel.isBusy,
                      backgroundColor: kcPrimaryColor,
                      textColor: Colors.white),
                ),

              //UpdateButton
              if (!viewModel.isNewEntry)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomElevatedButton(
                      width: double.infinity,
                      text: AppLocalizations.of(context)!.updateExpense,
                      onTap: () async {
                        bool result = await viewModel.updateExpense();
                        if (result) {
                          Navigator.of(context).pop();
                        }
                      },
                      isLoading: viewModel.isBusy,
                      backgroundColor: kcPrimaryColor,
                      textColor: Colors.white),
                ),

              //DeleteButton
              if (!viewModel.isNewEntry)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CustomElevatedButton(
                      width: double.infinity,
                      text: AppLocalizations.of(context)!.deleteExpense,
                      onTap: () async {
                        bool result = await viewModel.deleteExpense();
                        if (result) {
                          Navigator.of(context).pop();
                        }
                      },
                      isLoading: viewModel.isBusy,
                      backgroundColor: kcDeleteColor,
                      textColor: Colors.white),
                ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  ExpenseDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ExpenseDetailViewModel(expenseDataModel: _expenseDataModel);
}
