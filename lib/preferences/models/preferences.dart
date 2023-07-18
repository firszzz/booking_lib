import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'preferences.g.dart';

@JsonSerializable()
class Preferences {
  static const THEME_MODE_DEFAULT_VALUE = ThemeMode.system;

  // User
  static const bool TYPE_DEFAULT_VALUE = false;
  static const String CITY_DEFAULT_VALUE = 'Город не выбран';
  static const Map<String, dynamic> OFFICE_DEFAULT_VALUE = {
    "id": 1,
    "timeBegin": "08:00:00",
    "timeEnd": "22:00:00",
    "access": true,
    "city": "Город не выбран",
    "numDay": 10,
    "address": "Город не выбран",
    "timeZone": "UTC+10",
  };
  static const String SORT_BY_DEFAULT_VALUE = 'id';
  static const Map<String, dynamic> FLOOR_DEFAULT_VALUE = {
    "id": 1,
    "idOffice": 1,
    "floorNumber": 1,
    "mapImage": null,
  };

  // Admin
  static const String ADMIN_CITY_DEFAULT_VALUE = 'Город не выбран';
  static const bool ADMIN_TYPE_DEFAULT_VALUE = false;
  static const Map<String, dynamic> ADMIN_OFFICE_DEFAULT_VALUE = {
    "id": 1,
    "timeBegin": "08:00:00",
    "timeEnd": "22:00:00",
    "access": true,
    "city": "Город не выбран",
    "numDay": 10,
    "address": "Город не выбран",
    "timeZone": "UTC+10",
  };
  static const Map<String, dynamic> ADMIN_FLOOR_DEFAULT_VALUE = {
    "id": 0,
    "idOffice": 0,
    "floorNumber": 0,
    "mapImage": '',
  };

  @JsonKey(defaultValue: THEME_MODE_DEFAULT_VALUE)
  final ThemeMode themeMode;

  @JsonKey(defaultValue: TYPE_DEFAULT_VALUE)
  final bool type;
  @JsonKey(defaultValue: CITY_DEFAULT_VALUE)
  final String city;
  @JsonKey(defaultValue: OFFICE_DEFAULT_VALUE)
  final Map<String, dynamic> office;
  @JsonKey(defaultValue: SORT_BY_DEFAULT_VALUE)
  final String sortBy;
  @JsonKey(defaultValue: FLOOR_DEFAULT_VALUE)
  final Map<String, dynamic> floor;

  @JsonKey(defaultValue: ADMIN_CITY_DEFAULT_VALUE)
  final String adminCity;
  @JsonKey(defaultValue: ADMIN_TYPE_DEFAULT_VALUE)
  final bool adminType;
  @JsonKey(defaultValue: ADMIN_OFFICE_DEFAULT_VALUE)
  final Map<String, dynamic> adminOffice;
  @JsonKey(defaultValue: ADMIN_FLOOR_DEFAULT_VALUE)
  final Map<String, dynamic> adminFloor;

  Preferences(
      this.themeMode,
      this.type,
      this.city,
      this.office,
      this.sortBy,
      this.floor,
      this.adminCity,
      this.adminType,
      this.adminOffice,
      this.adminFloor,
      );

  factory Preferences.defaultValues() {
    return Preferences(
      THEME_MODE_DEFAULT_VALUE,
      TYPE_DEFAULT_VALUE,
      CITY_DEFAULT_VALUE,
      OFFICE_DEFAULT_VALUE,
      SORT_BY_DEFAULT_VALUE,
      FLOOR_DEFAULT_VALUE,
      ADMIN_CITY_DEFAULT_VALUE,
      ADMIN_TYPE_DEFAULT_VALUE,
      ADMIN_OFFICE_DEFAULT_VALUE,
      ADMIN_FLOOR_DEFAULT_VALUE,
    );
  }

  factory Preferences.fromJson(json) => _$PreferencesFromJson(Map<String, dynamic>.from(json));

  Map<String, dynamic> toJson() => _$PreferencesToJson(this);

  @override
  int get hashCode => themeMode.hashCode;

  Preferences copyWith({
    ThemeMode? themeMode,
    bool? type,
    String? city,
    Map<String, dynamic>? office,
    String? sortBy,
    Map<String, dynamic>? floor,
    String? adminCity,
    bool? adminType,
    Map<String, dynamic>? adminOffice,
    Map<String, dynamic>? adminFloor,
  }) {
    return Preferences(
      themeMode ?? this.themeMode,
      type ?? this.type,
      city ?? this.city,
      office ?? this.office,
      sortBy ?? this.sortBy,
      floor ?? this.floor,
      adminCity ?? this.adminCity,
      adminType ?? this.adminType,
      adminOffice ?? this.adminOffice,
      adminFloor ?? this.adminFloor,
    );
  }

  /*@override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Preferences && themeMode == other.themeMode);
  }*/

  @override
  String toString() {
    return 'Preferences( \n'
        'ThemeMode: $themeMode, \n'
        'type: $type, \n'
        'city: $city, \n'
        'office: $office, \n'
        'sortBy: $sortBy \n'
        'floor: $floor \n'
        'adminCity: $adminCity \n'
        'adminType: $adminType \n'
        'adminOffice: $adminOffice \n'
        'adminFloor: $adminFloor \n'
        ')';
  }

}