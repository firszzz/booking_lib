import 'package:atb_flutter_demo/data/api/model/api_floor.dart';
import 'package:atb_flutter_demo/domain/models/floor.dart';

class FloorMapper {
  static Floor fromApi(ApiFloor apiFloor) {

    return Floor(
        id: apiFloor.id,
        officeId: apiFloor.officeId,
        floorNumber: apiFloor.floorNumber,
        mapImage: (apiFloor.mapImage == null) ? '' : apiFloor.mapImage,
    );
  }
}