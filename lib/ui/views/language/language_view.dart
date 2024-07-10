import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spendsmart/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';

import 'language_viewmodel.dart';

final List<String> languages = [
  "Arabic",
  "Bengali",
  "Chinese (Simplified)",
  "English",
  "French",
  "Hindi",
  "Portuguese",
  "Russian",
  "Spanish",
  "Urdu",
];

final List<String> currencies = [
  "USD",
  "EUR",
  "GBP",
  "INR",
  "JPY",
  "CNY",
  "CAD",
  "AUD",
  "CHF",
  "RUB",
];

class LanguageView extends StackedView<LanguageViewModel> {
  const LanguageView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    LanguageViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EFFF),
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
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Select Language",
                            style: TextStyle(
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
                          list: languages,
                          icon: Icons.language,
                          selectedValue: viewModel.selectedLanguageValue,
                          onSelected: (String value) {
                        viewModel.setSelectedLanguage(value);
                      }),
                      const SizedBox(height: 20),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Select Currency",
                            style: TextStyle(
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
                          list: currencies,
                          icon: Icons.currency_rupee_outlined,
                          selectedValue: viewModel.selectedCurrencyValue,
                          onSelected: (String value) {
                        viewModel.setSelectedCurrency(value);
                      }),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Handle continue button press
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("Continue"),
              ),
            ],
          ),
        ),
      ),
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
    required Function(String) onSelected,
  }) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            width: double.infinity,
            child: ListTile(
              leading: Icon(icon),
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              trailing: GestureDetector(
                onTap: onTap,
                child: AnimatedRotation(
                  turns: expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: const Icon(Icons.expand_more),
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
              color: Colors.white,
            ),
            clipBehavior: Clip.hardEdge,
            height: expanded ? 300 : 0,
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
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.check),
                            )
                          : null;
                      return GestureDetector(
                        onTap: () => onSelected(list[index]),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Text(
                                  list[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              trailing ?? Container(),
                            ],
                          ),
                        ).animate(target: expanded ? 1 : 0).fadeIn(
                            delay: Duration(
                                milliseconds: 200 *
                                    (expanded
                                        ? index
                                        : (list.length - index)))),
                      );
                    },
                    itemCount: list.length,
                  )
                : null,
          ),
        ],
      ),
    );
  }

  @override
  LanguageViewModel viewModelBuilder(BuildContext context) =>
      LanguageViewModel();
}
