import 'user.dart';

class LoginResponse {
  String token;
  User user;

  LoginResponse({
    required this.token,
    required this.user,
  });
}