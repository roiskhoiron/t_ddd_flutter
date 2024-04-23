// buatkan saya pengetesan untuk class LoginRequest

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:t_ddd_flutter/domain/entities/login_request.dart';

import 'login_request_test.mocks.dart';

@GenerateMocks([LoginRequest])
void main() {
  group('LoginRequest', () {
    late MockLoginRequest loginRequest;

    setUp(() {
      loginRequest = MockLoginRequest();
    });

    test('LoginRequest should have the correct attributes', () {
      final loginRequest = LoginRequest(
        username: 'test@example.com',
        password: 'password',
      );

      expect(loginRequest.username, 'test@example.com');
      expect(loginRequest.password, 'password');
    });
  });
}
