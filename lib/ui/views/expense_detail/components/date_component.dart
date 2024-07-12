import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendsmart/ui/common/app_colors.dart';

import '../expense_detail_viewmodel.dart';

class DateComponent extends StatelessWidget {
  final ExpenseDetailViewModel viewModel;
  const DateComponent(this.viewModel, {super.key});

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: viewModel.expenseDate,
      firstDate: DateTime(2000),
      lastDate:
          DateTime(DateTime.now().add(const Duration(days: 365 * 100)).year),
    );

    if (picked != null && picked != viewModel.expenseDate) {
      viewModel.setExpenseDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              4,
            ),
            border: Border.all(color: kcPrimaryColor, width: 2)),
        child: ListTile(
          leading: const Icon(
            Icons.calendar_today,
            color: kcPrimaryColor,
          ),
          title: Text(
            DateFormat('dd MMMM yyyy').format(viewModel.expenseDate),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          trailing: const Icon(
            Icons.edit,
            color: kcPrimaryColor,
          ),
        ),
      ),
    );
  }
}
