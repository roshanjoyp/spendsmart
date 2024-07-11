import 'package:flutter/material.dart';
import 'package:spendsmart/ui/common/widgets/custom_elevated_button.dart';

import '../expense_detail_viewmodel.dart';

class CategoryComponent extends StatelessWidget {
  final ExpenseDetailViewModel viewModel;
  const CategoryComponent(this.viewModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          //Selected Categories
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: viewModel.selectedType == null
                ? const Text("No category selected")
                : Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(.5),
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(viewModel.selectedType!),
                      trailing: IconButton(
                          onPressed: () =>
                              viewModel.removeCategory(viewModel.selectedType!),
                          icon: const Icon(Icons.close)),
                    ),
                  ),
          ),
          TextField(
            controller: viewModel.categoryController,
            decoration: InputDecoration(
              labelText: 'Category',
              border: const OutlineInputBorder(),
              errorText: viewModel.categoryInputValidationMessage,
              suffixIcon: const Icon(Icons.search),
            ),
            onChanged: viewModel.onCategoryTextChanged,
          ),
          viewModel.recommendedCategories.isEmpty
              ? Container()
              : Wrap(
                  children: viewModel.recommendedCategories
                      .take(5)
                      .map((category) => GestureDetector(
                            onTap: () {
                              viewModel.addCategory(category);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.pink.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(10)),
                              child: ListTile(
                                title: Text(category),
                                trailing: const Icon(Icons.add),
                              ),
                            ),
                          ))
                      .toList(),
                ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CustomElevatedButton(
                width: double.infinity,
                text: "Add  category",
                onTap: viewModel.addCategoryFromText,
                isLoading: false,
                backgroundColor: Colors.blue.withOpacity(.5),
                textColor: Colors.black),
          )
        ],
      ),
    );
  }
}
