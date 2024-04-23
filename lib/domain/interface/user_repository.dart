import '../entities/user.dart';

abstract class UserRepository {
  Future<User?> login(String username, String password);

  Future  register(User data);
}
