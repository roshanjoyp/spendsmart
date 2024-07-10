// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingsModelAdapter extends TypeAdapter<_$UserSettingsModelImpl> {
  @override
  final int typeId = 1;

  @override
  _$UserSettingsModelImpl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$UserSettingsModelImpl(
      id: fields[0] as String,
      language: fields[1] as String,
      currency: fields[2] as String,
      pushNotificationsEnabled: fields[3] as bool?,
      pushNotificationTime: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, _$UserSettingsModelImpl obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.currency)
      ..writeByte(3)
      ..write(obj.pushNotificationsEnabled)
      ..writeByte(4)
      ..write(obj.pushNotificationTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSettingsModelImpl _$$UserSettingsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserSettingsModelImpl(
      id: json['id'] as String,
      language: json['language'] as String,
      currency: json['currency'] as String,
      pushNotificationsEnabled: json['pushNotificationsEnabled'] as bool?,
      pushNotificationTime: json['pushNotificationTime'] == null
          ? null
          : DateTime.parse(json['pushNotificationTime'] as String),
    );

Map<String, dynamic> _$$UserSettingsModelImplToJson(
        _$UserSettingsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language': instance.language,
      'currency': instance.currency,
      'pushNotificationsEnabled': instance.pushNotificationsEnabled,
      'pushNotificationTime': instance.pushNotificationTime?.toIso8601String(),
    };
