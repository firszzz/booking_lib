// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Office _$OfficeFromJson(Map<String, dynamic> json) => Office(
      id: json['id'] as int,
      timeBegin: json['timeBegin'] as String,
      timeEnd: json['timeEnd'] as String,
      access: json['access'] as bool,
      city: json['city'] as String,
      numDay: json['numDay'] as int,
      address: json['address'] as String,
      timeZone: json['timeZone'] as String,
    );

Map<String, dynamic> _$OfficeToJson(Office instance) => <String, dynamic>{
      'id': instance.id,
      'timeBegin': instance.timeBegin,
      'timeEnd': instance.timeEnd,
      'access': instance.access,
      'city': instance.city,
      'numDay': instance.numDay,
      'address': instance.address,
      'timeZone': instance.timeZone,
    };
