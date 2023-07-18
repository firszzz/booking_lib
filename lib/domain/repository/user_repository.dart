import '../models/user.dart';

abstract class UserRepository {
  Future<User> getUser({
    required String id,
  });

  Future<List<User>> getAllUsers();
}