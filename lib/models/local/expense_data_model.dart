import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'expense_data_model.freezed.dart';
part 'expense_data_model.g.dart';

@freezed
class ExpenseDataModel with _$ExpenseDataModel {
  @HiveType(typeId: 2, adapterName: "ExpenseDataModelAdapter")
  factory ExpenseDataModel({
    @HiveField(0) required String id,
    @HiveField(1) required double amount,
    @HiveField(2) required DateTime date,
    @HiveField(3) List<String>? type,
    @HiveField(4) String? description,
  }) = _ExpenseDataModel;

  factory ExpenseDataModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseDataModelFromJson(json);
}
