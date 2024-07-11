// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserSettingsModel {
  final String? language;
  final String? currency;
  final bool? pushNotificationsEnabled;
  final DateTime? pushNotificationTime;
  const UserSettingsModel({
    this.language,
    this.currency,
    this.pushNotificationsEnabled,
    this.pushNotificationTime,
  });

  UserSettingsModel copyWith({
    String? language,
    String? currency,
    bool? pushNotificationsEnabled,
    DateTime? pushNotificationTime,
  }) {
    return UserSettingsModel(
      language: language ?? this.language,
      currency: currency ?? this.currency,
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      pushNotificationTime: pushNotificationTime ?? this.pushNotificationTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language,
      'currency': currency,
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'pushNotificationTime': pushNotificationTime?.millisecondsSinceEpoch,
    };
  }

  factory UserSettingsModel.fromMap(Map<String, dynamic> map) {
    return UserSettingsModel(
      language: map['language'] != null ? map["language"] ?? '' : null,
      currency: map['currency'] != null ? map["currency"] ?? '' : null,
      pushNotificationsEnabled: map['pushNotificationsEnabled'] != null
          ? map["pushNotificationsEnabled"] ?? false
          : null,
      pushNotificationTime: map['pushNotificationTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              (map["pushNotificationTime"] ?? 0) ?? 0)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSettingsModel.fromJson(String source) =>
      UserSettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserSettingsModel(language: $language, currency: $currency, pushNotificationsEnabled: $pushNotificationsEnabled, pushNotificationTime: $pushNotificationTime)';
  }

  @override
  bool operator ==(covariant UserSettingsModel other) {
    if (identical(this, other)) return true;

    return other.language == language &&
        other.currency == currency &&
        other.pushNotificationsEnabled == pushNotificationsEnabled &&
        other.pushNotificationTime == pushNotificationTime;
  }

  @override
  int get hashCode {
    return language.hashCode ^
        currency.hashCode ^
        pushNotificationsEnabled.hashCode ^
        pushNotificationTime.hashCode;
  }
}
