import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../expense_detail_viewmodel.dart';

class DateComponent extends StatelessWidget {
  final ExpenseDetailViewModel viewModel;
  const DateComponent(this.viewModel, {super.key});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: viewModel.expenseDate,
      firstDate: DateTime(2000),
      //locale: Locale(locale.split("_").first, locale.split("_")[1]),
      lastDate:
          DateTime(DateTime.now().add(const Duration(days: 365 * 100)).year),
    );

    if (picked != null && picked != viewModel.expenseDate) {
      viewModel.setExpenseDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: GestureDetector(
          onTap: () => _selectDate(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat(
                  'dd MMM yyyy',
                ).format(viewModel.expenseDate),
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(width: 20),
              const Padding(
                padding: EdgeInsets.only(bottom: 4),
                child: Icon(
                  Icons.edit,
                  size: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
