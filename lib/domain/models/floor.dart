import 'package:json_annotation/json_annotation.dart';
part 'floor.g.dart';

@JsonSerializable(explicitToJson: true)
class Floor {
  final int id;
  final int officeId;
  final int floorNumber;
  final dynamic mapImage;

  Floor({
    required this.id,
    required this.officeId,
    required this.floorNumber,
    required this.mapImage,
  });

  factory Floor.fromJson(Map<String, dynamic> json) =>
      _$FloorFromJson(json);

  Map<String, dynamic> toJson() => _$FloorToJson(this);
}
