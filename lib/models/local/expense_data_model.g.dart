// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpenseDataModelAdapter extends TypeAdapter<_$ExpenseDataModelImpl> {
  @override
  final int typeId = 2;

  @override
  _$ExpenseDataModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$ExpenseDataModelImpl(
      id: fields[0] as String,
      amount: fields[1] as double,
      date: fields[2] as DateTime,
      type: (fields[3] as List?)?.cast<String>(),
      description: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _$ExpenseDataModelImpl obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExpenseDataModelImpl _$$ExpenseDataModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ExpenseDataModelImpl(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      date: DateTime.parse(json['date'] as String),
      type: (json['type'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$ExpenseDataModelImplToJson(
        _$ExpenseDataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'date': instance.date.toIso8601String(),
      'type': instance.type,
      'description': instance.description,
    };
