import 'package:atb_flutter_demo/data/api/model/api_user.dart';
import '../../../domain/models/user.dart';

class UserMapper {
  static User fromApi(ApiUser user) {
    return User(
      id: user.id,
      name: user.firstName,
      surname: user.lastName,
      role: user.middleName,
      position: user.position,
      login: user.login,
      email: user.email,
      phone: user.phone,
    );
  }
}
