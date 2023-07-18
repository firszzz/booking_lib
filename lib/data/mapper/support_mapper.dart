import 'package:atb_flutter_demo/data/api/model/api_support.dart';
import 'package:atb_flutter_demo/domain/models/support_message.dart';

class SupportMapper {
  static SupportMessage fromApi(ApiSupport supports) {
    return SupportMessage(
        id: supports.id,
        topic: supports.topic,
        textMessage: supports.textMessage,
        statusMessage: supports.statusMessage,
        employeeId: supports.employeeId
    );
  }
}