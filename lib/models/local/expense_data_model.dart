// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ExpenseDataModel {
  final String id;
  final num amount;
  final DateTime date;
  final String type;
  final String? description;

  const ExpenseDataModel({
    required this.id,
    required this.amount,
    required this.date,
    required this.type,
    this.description,
  });

  ExpenseDataModel copyWith({
    String? id,
    num? amount,
    DateTime? date,
    String? type,
    String? description,
  }) {
    return ExpenseDataModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'type': type,
      'description': description,
    };
  }

  factory ExpenseDataModel.fromMap(Map<String, dynamic> map) {
    return ExpenseDataModel(
      id: (map["id"] ?? '') as String,
      amount: (map["amount"] ?? 0) as num,
      date: DateTime.fromMillisecondsSinceEpoch((map["date"] ?? 0) as int),
      type: (map["type"] ?? '') as String,
      description: map['description'] != null ? map["description"] ?? '' : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseDataModel.fromJson(String source) =>
      ExpenseDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExpenseDataModel(id: $id, amount: $amount, date: $date, type: $type, description: $description)';
  }

  @override
  bool operator ==(covariant ExpenseDataModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.date == date &&
        other.type == type &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        type.hashCode ^
        description.hashCode;
  }
}
