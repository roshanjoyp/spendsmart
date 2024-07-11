import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_settings_model.freezed.dart';
part 'user_settings_model.g.dart';

@freezed
class UserSettingsModel with _$UserSettingsModel {
  @HiveType(typeId: 1, adapterName: "UserSettingsModelAdapter")
  factory UserSettingsModel({
    @HiveField(1) String? language,
    @HiveField(2) String? currency,
    @HiveField(3) bool? pushNotificationsEnabled,
    @HiveField(4) DateTime? pushNotificationTime,
  }) = _UserSettingsModel;

  factory UserSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$UserSettingsModelFromJson(json);
}
