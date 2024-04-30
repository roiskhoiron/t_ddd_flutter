import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:t_ddd_flutter/domain/entities/login_response.dart';
import 'package:t_ddd_flutter/domain/entities/user.dart';

@GenerateMocks([LoginResponse])
void main() {
  group('Unit Test', () {
    test('LoginResponse should have the correct attributes', () {
      final loginResponse = LoginResponse(
          token: 'token',
          user: User(
              id: 1,
              username: 'test',
              password: 'password',
              email: 'test@example.com'));

      expect(loginResponse.token, 'token');
      expect(loginResponse.user.id, 1);
      expect(loginResponse.user.username, 'test');
      expect(loginResponse.user.password, 'password');
      expect(loginResponse.user.email, 'test@example.com');
    });
  });
}
