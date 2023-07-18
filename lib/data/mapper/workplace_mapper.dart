import 'package:atb_flutter_demo/data/api/model/api_workplace.dart';
import 'package:atb_flutter_demo/domain/models/workplace.dart';
import 'package:atb_flutter_demo/resources/env.dart';

class WorkplaceMapper {
  static Workplace fromApi(ApiWorkplace apiWorkplace) {
    final list = (apiWorkplace.imageNames).map((item) => item as String).toList();
    for (var i = 0; i < list.length; i++) {
      list[i] = '${AppUrls.baseUrl}/images/${list[i]}';
    }
    return Workplace(
      id: apiWorkplace.id,
      type: apiWorkplace.type,
      seatsCount: apiWorkplace.seatsCount,
      floorLevel: apiWorkplace.floorLevel,
      officeId: apiWorkplace.officeId,
      floorId: apiWorkplace.floorId,
      info: apiWorkplace.info,
      imageNames: list,
    );
  }
}