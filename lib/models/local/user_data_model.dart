import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_data_model.freezed.dart';
part 'user_data_model.g.dart';

@freezed
class UserDataModel with _$UserDataModel {
  @HiveType(typeId: 0, adapterName: 'UserDataModelAdapter')
  factory UserDataModel({
    @HiveField(0) required String id,
    @HiveField(1) required String language,
    @HiveField(2) required String currency,
    @HiveField(3) bool? pushNotificationsEnabled,
    @HiveField(4) DateTime? pushNotificationTime,
  }) = _UserDataModel;

  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      _$UserDataModelFromJson(json);
}
