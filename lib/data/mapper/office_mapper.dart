
import 'package:atb_flutter_demo/data/api/model/api_office.dart';

import '../../domain/models/office.dart';

class OfficeMapper {
  static Office fromApi(ApiOffice apiOffice) {
    String separator(String string, String separator) {
      final pos = string.lastIndexOf(separator);
      return (pos != -1) ? string.substring(0, pos) : string;
    }
    return Office(
      id: apiOffice.id,
      timeBegin: separator(apiOffice.timeBegin, ':'),
      timeEnd: separator(apiOffice.timeEnd, ':'),
      access: apiOffice.access,
      city: apiOffice.city,
      numDay: apiOffice.numDay,
      address: apiOffice.address,
      timeZone: apiOffice.timeZone,
    );
  }
}