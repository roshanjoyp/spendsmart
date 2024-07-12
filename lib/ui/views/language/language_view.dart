import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:spendsmart/models/app/currency_model.dart';
import 'package:spendsmart/models/app/language_model.dart';
import 'package:spendsmart/ui/common/app_colors.dart';
import 'package:spendsmart/ui/common/ui_helpers.dart';
import 'package:spendsmart/ui/common/widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

import 'language_viewmodel.dart';

class LanguageView extends StackedView<LanguageViewModel> {
  final bool fromSettings;
  const LanguageView({Key? key, this.fromSettings = false}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LanguageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight(context) * .8,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.selectLanguage,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      _buildDropdownTile(context, viewModel,
                          title: viewModel.selectedLanguageValue,
                          expanded: viewModel.isLanguageSheetExpanded,
                          onTap: viewModel.expandLanguageSheetTapped,
                          list: languages
                              .map((e) => e.englishLanguageName)
                              .toList(),
                          icon: Icons.language,
                          selectedValue: viewModel.selectedLanguageValue,
                          onSelected: (int value) {
                        viewModel.setSelectedLanguage(value);
                      }),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.selectCurrency,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      _buildDropdownTile(context, viewModel,
                          title: viewModel.selectedCurrencyValue,
                          expanded: viewModel.isCurrencySheetExpanded,
                          onTap: viewModel.expandCurrencySheetTapped,
                          list: currencies.map((e) => e.currency).toList(),
                          icon: Icons.currency_rupee_outlined,
                          selectedValue: viewModel.selectedCurrencyValue,
                          isCurrency: true,
                          currency: viewModel.selectedCurrencySymbol,
                          currencies: currencies
                              .map((e) => e.currencySymbol)
                              .toList(), onSelected: (int value) {
                        viewModel.setSelectedCurrency(value);
                      }),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomElevatedButton(
          width: MediaQuery.of(context).size.width,
          text: AppLocalizations.of(context)!.saveAndContinue,
          onTap: () {
            viewModel.saveAndContinue();
          },
          isLoading: viewModel.isBusy,
          backgroundColor: kcPrimaryColor,
          textColor: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildDropdownTile(
    BuildContext context,
    LanguageViewModel viewModel, {
    required String title,
    required bool expanded,
    required VoidCallback onTap,
    required List<String> list,
    required String selectedValue,
    required IconData icon,
    required Function(int) onSelected,
    bool isCurrency = false,
    String? currency,
    List<String>? currencies,
  }) {
    double dropdownHeight = (list.length * 50.0) + 16;
    if (dropdownHeight > 300) dropdownHeight = 300;
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(.05),
            ),
            width: double.infinity,
            child: GestureDetector(
              onTap: onTap,
              child: ListTile(
                leading: isCurrency
                    ? FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          currency!,
                          style: const TextStyle(
                              fontSize: 20, color: kcPrimaryColor),
                        ))
                    : Icon(
                        icon,
                        color: kcPrimaryColor,
                      ),
                title: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: kcPrimaryColor,
                  ),
                ),
                trailing: AnimatedRotation(
                  turns: expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(
                    Icons.expand_more,
                    color: kcPrimaryColor,
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black.withOpacity(.05),
            ),
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge,
            height: expanded ? dropdownHeight : 0,
            child: Center(
              child: expanded
                  ? ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          height: .25,
                          color: Colors.black.withOpacity(.05),
                        );
                      },
                      itemBuilder: (context, index) {
                        Widget? trailing = selectedValue == list[index]
                            ? const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16),
                                child: Icon(
                                  Icons.check_circle_outlined,
                                  color: kcPrimaryColor,
                                ),
                              )
                            : null;
                        return GestureDetector(
                          onTap: () => onSelected(index),
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ListTile(
                              leading: isCurrency
                                  ? FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(
                                        currencies![index],
                                        style: const TextStyle(fontSize: 22),
                                      ))
                                  : null,
                              title: Text(
                                list[index],
                              ),
                              trailing: trailing,
                            ),
                          ).animate(target: expanded ? 1 : 0).fadeIn(),
                        );
                      },
                      itemCount: list.length,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  @override
  LanguageViewModel viewModelBuilder(BuildContext context) =>
      LanguageViewModel(fromSettings);
}
