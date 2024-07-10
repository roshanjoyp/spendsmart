// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expense_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ExpenseDataModel _$ExpenseDataModelFromJson(Map<String, dynamic> json) {
  return _ExpenseDataModel.fromJson(json);
}

/// @nodoc
mixin _$ExpenseDataModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  double get amount => throw _privateConstructorUsedError;
  @HiveField(2)
  DateTime get date => throw _privateConstructorUsedError;
  @HiveField(3)
  List<String>? get type => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExpenseDataModelCopyWith<ExpenseDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExpenseDataModelCopyWith<$Res> {
  factory $ExpenseDataModelCopyWith(
          ExpenseDataModel value, $Res Function(ExpenseDataModel) then) =
      _$ExpenseDataModelCopyWithImpl<$Res, ExpenseDataModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) double amount,
      @HiveField(2) DateTime date,
      @HiveField(3) List<String>? type,
      @HiveField(4) String? description});
}

/// @nodoc
class _$ExpenseDataModelCopyWithImpl<$Res, $Val extends ExpenseDataModel>
    implements $ExpenseDataModelCopyWith<$Res> {
  _$ExpenseDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? date = null,
    Object? type = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExpenseDataModelImplCopyWith<$Res>
    implements $ExpenseDataModelCopyWith<$Res> {
  factory _$$ExpenseDataModelImplCopyWith(_$ExpenseDataModelImpl value,
          $Res Function(_$ExpenseDataModelImpl) then) =
      __$$ExpenseDataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) double amount,
      @HiveField(2) DateTime date,
      @HiveField(3) List<String>? type,
      @HiveField(4) String? description});
}

/// @nodoc
class __$$ExpenseDataModelImplCopyWithImpl<$Res>
    extends _$ExpenseDataModelCopyWithImpl<$Res, _$ExpenseDataModelImpl>
    implements _$$ExpenseDataModelImplCopyWith<$Res> {
  __$$ExpenseDataModelImplCopyWithImpl(_$ExpenseDataModelImpl _value,
      $Res Function(_$ExpenseDataModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = null,
    Object? date = null,
    Object? type = freezed,
    Object? description = freezed,
  }) {
    return _then(_$ExpenseDataModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: freezed == type
          ? _value._type
          : type // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 2, adapterName: "ExpenseDataModelAdapter")
class _$ExpenseDataModelImpl implements _ExpenseDataModel {
  _$ExpenseDataModelImpl(
      {@HiveField(0) required this.id,
      @HiveField(1) required this.amount,
      @HiveField(2) required this.date,
      @HiveField(3) final List<String>? type,
      @HiveField(4) this.description})
      : _type = type;

  factory _$ExpenseDataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExpenseDataModelImplFromJson(json);

  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final double amount;
  @override
  @HiveField(2)
  final DateTime date;
  final List<String>? _type;
  @override
  @HiveField(3)
  List<String>? get type {
    final value = _type;
    if (value == null) return null;
    if (_type is EqualUnmodifiableListView) return _type;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(4)
  final String? description;

  @override
  String toString() {
    return 'ExpenseDataModel(id: $id, amount: $amount, date: $date, type: $type, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExpenseDataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._type, _type) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount, date,
      const DeepCollectionEquality().hash(_type), description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExpenseDataModelImplCopyWith<_$ExpenseDataModelImpl> get copyWith =>
      __$$ExpenseDataModelImplCopyWithImpl<_$ExpenseDataModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExpenseDataModelImplToJson(
      this,
    );
  }
}

abstract class _ExpenseDataModel implements ExpenseDataModel {
  factory _ExpenseDataModel(
      {@HiveField(0) required final String id,
      @HiveField(1) required final double amount,
      @HiveField(2) required final DateTime date,
      @HiveField(3) final List<String>? type,
      @HiveField(4) final String? description}) = _$ExpenseDataModelImpl;

  factory _ExpenseDataModel.fromJson(Map<String, dynamic> json) =
      _$ExpenseDataModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  double get amount;
  @override
  @HiveField(2)
  DateTime get date;
  @override
  @HiveField(3)
  List<String>? get type;
  @override
  @HiveField(4)
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$ExpenseDataModelImplCopyWith<_$ExpenseDataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
