

import 'package:atb_flutter_demo/domain/models/support_message.dart';
import 'package:atb_flutter_demo/domain/repository/support_repository.dart';

import '../api/api_util.dart';

class SupportDataRepository extends SupportRepository {
  final ApiUtil _apiUtil;

  SupportDataRepository(this._apiUtil);

  @override
  Future<List<SupportMessage>> getSupports({required String status}) {
    return _apiUtil.getSupports(status: status);
  }

  @override
  Future<void> changeStatusSupport({required String status, required String id}) {
    return _apiUtil.changeStatusSupport(id: id, status: status);
  }

  @override
  Future<void> sendSupportMessage({
    required String topic,
    required String textMessage
  }) {
    return _apiUtil.sendSupportMessage(topic: topic, textMessage: textMessage);
  }
}