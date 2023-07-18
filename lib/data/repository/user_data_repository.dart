import 'package:atb_flutter_demo/data/api/api_util.dart';
import 'package:atb_flutter_demo/domain/models/user.dart';
import 'package:atb_flutter_demo/domain/repository/user_repository.dart';

class UserDataRepository extends UserRepository {
  final ApiUtil _apiUtil;

  UserDataRepository(this._apiUtil);

  @override
  Future<User> getUser({required id}) {
    return _apiUtil.getUser(id: id);
  }

  @override
  Future<List<User>> getAllUsers() {
    return _apiUtil.getAllUsers();
  }
}