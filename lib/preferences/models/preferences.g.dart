// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Preferences _$PreferencesFromJson(Map<String, dynamic> json) => Preferences(
      $enumDecodeNullable(_$ThemeModeEnumMap, json['themeMode']) ??
          ThemeMode.system,
      json['type'] as bool? ?? false,
      json['city'] as String? ?? 'Город не выбран',
      json['office'] as Map<String, dynamic>? ??
          {
            'id': 1,
            'timeBegin': '08:00:00',
            'timeEnd': '22:00:00',
            'access': true,
            'city': 'Город не выбран',
            'numDay': 10,
            'address': 'Город не выбран',
            'timeZone': 'UTC+10'
          },
      json['sortBy'] as String? ?? 'id',
      json['floor'] as Map<String, dynamic>? ??
          {'id': 1, 'idOffice': 1, 'floorNumber': 1, 'mapImage': null},
      json['adminCity'] as String? ?? 'Город не выбран',
      json['adminType'] as bool? ?? false,
      json['adminOffice'] as Map<String, dynamic>? ??
          {
            'id': 1,
            'timeBegin': '08:00:00',
            'timeEnd': '22:00:00',
            'access': true,
            'city': 'Город не выбран',
            'numDay': 10,
            'address': 'Город не выбран',
            'timeZone': 'UTC+10'
          },
      json['adminFloor'] as Map<String, dynamic>? ??
          {'id': 0, 'idOffice': 0, 'floorNumber': 0, 'mapImage': ''},
    );

Map<String, dynamic> _$PreferencesToJson(Preferences instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'type': instance.type,
      'city': instance.city,
      'office': instance.office,
      'sortBy': instance.sortBy,
      'floor': instance.floor,
      'adminCity': instance.adminCity,
      'adminType': instance.adminType,
      'adminOffice': instance.adminOffice,
      'adminFloor': instance.adminFloor,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
