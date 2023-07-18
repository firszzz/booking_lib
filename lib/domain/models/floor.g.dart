// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Floor _$FloorFromJson(Map<String, dynamic> json) => Floor(
      id: json['id'] as int,
      officeId: json['officeId'] as int,
      floorNumber: json['floorNumber'] as int,
      mapImage: json['mapImage'],
    );

Map<String, dynamic> _$FloorToJson(Floor instance) => <String, dynamic>{
      'id': instance.id,
      'officeId': instance.officeId,
      'floorNumber': instance.floorNumber,
      'mapImage': instance.mapImage,
    };
