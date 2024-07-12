// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserSettingsModel {
  final String? language;
  final String? currency;
  final bool? pushNotificationsEnabled;
  final int? hour;
  final int? minute;
  const UserSettingsModel({
    this.language,
    this.currency,
    this.pushNotificationsEnabled,
    this.hour,
    this.minute,
  });

  UserSettingsModel copyWith({
    String? language,
    String? currency,
    bool? pushNotificationsEnabled,
    int? hour,
    int? minute,
  }) {
    return UserSettingsModel(
      language: language ?? this.language,
      currency: currency ?? this.currency,
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'language': language,
      'currency': currency,
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'hour': hour,
      'minute': minute,
    };
  }

  factory UserSettingsModel.fromMap(Map<String, dynamic> map) {
    return UserSettingsModel(
      language: map['language'] != null ? map["language"] ?? '' : null,
      currency: map['currency'] != null ? map["currency"] ?? '' : null,
      pushNotificationsEnabled: map['pushNotificationsEnabled'] != null
          ? map["pushNotificationsEnabled"] ?? false
          : null,
      hour: map['hour'] != null ? map["hour"] ?? 0 : null,
      minute: map['minute'] != null ? map["minute"] ?? 0 : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSettingsModel.fromJson(String source) =>
      UserSettingsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserSettingsModel(language: $language, currency: $currency, pushNotificationsEnabled: $pushNotificationsEnabled, hour: $hour, minute: $minute)';
  }

  @override
  bool operator ==(covariant UserSettingsModel other) {
    if (identical(this, other)) return true;

    return other.language == language &&
        other.currency == currency &&
        other.pushNotificationsEnabled == pushNotificationsEnabled &&
        other.hour == hour &&
        other.minute == minute;
  }

  @override
  int get hashCode {
    return language.hashCode ^
        currency.hashCode ^
        pushNotificationsEnabled.hashCode ^
        hour.hashCode ^
        minute.hashCode;
  }
}
