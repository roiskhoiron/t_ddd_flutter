
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:t_ddd_flutter/domain/entities/login_request.dart';

@GenerateMocks([LoginRequest])
void main() {
  group('Unit Test', () {
    test('LoginRequest should have the correct attributes', () {
      final loginRequest = LoginRequest(
        username: 'test@example.com',
        password: 'password',
      );

      // when(loginRequest.username).thenReturn('test@example.com');
      // when(loginRequest.password).thenReturn('password');

      expect(loginRequest.username, 'test@example.com');
      expect(loginRequest.password, 'password');

      // verify(loginRequest.username);
      // verify(loginRequest.password);
    });
  });
}

