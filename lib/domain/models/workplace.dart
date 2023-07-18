class Workplace {
  final int id;
  final bool type;
  final int seatsCount;
  final int floorLevel;
  final int officeId;
  final int floorId;
  final String info;
  final List<String> imageNames;

  Workplace({
    required this.id,
    required this.type,
    required this.seatsCount,
    required this.floorLevel,
    required this.officeId,
    required this.floorId,
    required this.info,
    required this.imageNames,
  });
}
