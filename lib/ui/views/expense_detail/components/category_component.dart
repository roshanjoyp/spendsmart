import 'package:flutter/material.dart';
import 'package:spendsmart/ui/common/app_colors.dart';
import 'package:spendsmart/ui/common/widgets/custom_elevated_button.dart';

import '../expense_detail_viewmodel.dart';

// Secondary color to match primary color

class CategoryComponent extends StatelessWidget {
  final ExpenseDetailViewModel viewModel;
  const CategoryComponent(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected Category
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: viewModel.selectedType == null
                  ? const Text("No category selected")
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 12),
                      decoration: BoxDecoration(
                        color: kcPrimaryColor.withOpacity(.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(viewModel.selectedType!),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () => viewModel
                                .removeCategory(viewModel.selectedType!),
                            icon: const Icon(
                              Icons.delete,
                              color: kcDeleteColor,
                            ),
                            color: kcPrimaryColor,
                          )
                        ],
                      ),
                    )),
          // Category Input
          TextField(
            controller: viewModel.categoryController,
            decoration: InputDecoration(
              labelText: 'Category',
              border: const OutlineInputBorder(),
              errorText: viewModel.categoryInputValidationMessage,
              suffixIcon: const Icon(Icons.search, color: kcPrimaryColor),
            ),
            onChanged: viewModel.onCategoryTextChanged,
          ),
          const SizedBox(height: 16),
          // Recommended Categories
          viewModel.recommendedCategories.isEmpty
              ? Container()
              : Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: viewModel.recommendedCategories
                      .take(5)
                      .map((category) => GestureDetector(
                            onTap: () {
                              viewModel.addCategory(category);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: kcPrimaryColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(category),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.add, color: kcPrimaryColor),
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
          // Add Category Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomElevatedButton(
              width: double.infinity,
              text: "Add Category",
              onTap: viewModel.addCategoryFromText,
              isLoading: false,
              backgroundColor: kcSecondaryColor,
              textColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
