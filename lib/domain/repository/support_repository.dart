import 'package:atb_flutter_demo/domain/models/support_message.dart';

abstract class SupportRepository {
  Future<List<SupportMessage>> getSupports({
    required String status
  });

  Future<void> changeStatusSupport({
    required String status,
    required String id,
  });

  Future<void> sendSupportMessage({
    required String topic,
    required String textMessage
  });
}
