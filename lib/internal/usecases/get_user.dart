import 'package:atb_flutter_demo/domain/models/user.dart';
import 'package:atb_flutter_demo/internal/dependencies/repository_module.dart';
import 'package:atb_flutter_demo/internal/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class GetUser extends UseCase<User, UserParams> {
  final _userRepository = RepositoryModule.userRepository();

  @override
  Future<User> call(UserParams params) async {
    return await _userRepository.getUser(id: params.id);
  }
}

class UserParams extends Equatable{
  final String id;

  const UserParams({
    required this.id,
  });

  @override
  List<Object?> get props => [id];

}