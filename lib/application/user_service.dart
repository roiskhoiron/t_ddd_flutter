import 'dart:convert';

import '../domain/entities/login_request.dart';
import '../domain/entities/login_response.dart';
import '../domain/entities/user.dart';
import '../domain/interface/user_repository.dart';
import '../domain/validator/exception.dart';

class UserService {
  final UserRepository _userRepository;

  UserService(this._userRepository);

  Future<LoginResponse> login(LoginRequest request) async {
    // Validasi input login
    if (request.username.isEmpty) {
      throw UsernameEmptyException();
    }

    if (request.password.isEmpty) {
      throw PasswordEmptyException();
    }

    // Panggil repository untuk login
    final user =
        await _userRepository.login(request.username, request.password);

    if (user == null) {
      throw InvalidCredentialsException();
    }
    // Buat response login
    final token = generateToken(user);
    final response = LoginResponse(token: token, user: user);

    return response;
  }

  String generateToken(User user) {
    final payload = {
      'userId': user.id,
      'username': user.username,
      'email': user.email,
      'exp': DateTime.now()
          .add(const Duration(days: 30))
          .millisecondsSinceEpoch // Token berlaku selama 30 hari
    };

    final token = base64UrlEncode(json.encode(payload).codeUnits);

    return token;
  }
}
