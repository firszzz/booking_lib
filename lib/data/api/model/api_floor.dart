class ApiFloor {
  final int id;
  final int officeId;
  final int floorNumber;
  final dynamic mapImage;

  ApiFloor.fromApi(Map<String, dynamic> map)
      : id = map['id'],
        officeId = map['idOffice'],
        floorNumber = map['floorNumber'],
        mapImage = map['mapImage'];
}
