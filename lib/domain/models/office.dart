import 'package:json_annotation/json_annotation.dart';
part 'office.g.dart';

@JsonSerializable(explicitToJson: true)
class Office {
  final int id;
  final String timeBegin;
  final String timeEnd;
  final bool access;
  final String city;
  final int numDay;
  final String address;
  final String timeZone;

  Office({
    required this.id,
    required this.timeBegin,
    required this.timeEnd,
    required this.access,
    required this.city,
    required this.numDay,
    required this.address,
    required this.timeZone,
  });

  factory Office.fromJson(Map<String, dynamic> json) =>
      _$OfficeFromJson(json);

  Map<String, dynamic> toJson() => _$OfficeToJson(this);
}
