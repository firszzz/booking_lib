class ApiWorkplace {
  final int id;
  final bool type;
  final int seatsCount;
  final int floorLevel;
  final int officeId;
  final int floorId;
  final String info;
  final List<dynamic> imageNames;

  ApiWorkplace.fromApi(Map<String, dynamic> map)
    : id = map['id'],
      type = map['type'],
      seatsCount = map['seatsCount'],
      floorLevel = map['floorLevel'],
      officeId = map['officeId'],
      floorId = map['floorId'],
      info = map['info'],
      imageNames = map['imageNames'];
}