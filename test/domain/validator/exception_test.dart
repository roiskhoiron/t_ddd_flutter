import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:t_ddd_flutter/domain/validator/exception.dart';

import '../../application/user_service_test.mocks.dart';
import '../entities/login_request_test.mocks.dart';
import '../entities/user_test.mocks.dart';

void main() {
  group('Exception', () {
    late MockUserService userService;
    late MockUser user;
    late MockLoginRequest loginRequest;

    setUp(() {
      userService = MockUserService();

      user = MockUser();
      user.id = 1;
      user.username = 'test';
      user.password = 'password';
      user.email = 'test@example.com';

      loginRequest = MockLoginRequest();
      loginRequest.username = '';
      loginRequest.password = '';
    });

    test('UsernameEmptyException should return correct message', () {
      expect(UsernameEmptyException().toString(), 'Username cannot be empty');
    });

    test('PasswordEmptyException should return correct message', () {
      expect(PasswordEmptyException().toString(), 'Password cannot be empty');
    });

    test('InvalidCredentialsException should return correct message', () {
      expect(InvalidCredentialsException().toString(),
          'Invalid username or password');
    });

    test('UserNotFoundException should return correct message', () {
      expect(UserNotFoundException().toString(), 'User not found');
    });

    test('Login with empty username should throw UsernameEmptyException', () {

      when(userService.login(loginRequest)).thenThrow(UsernameEmptyException());

      expect(() => userService.login(loginRequest),
          throwsA(TypeMatcher<UsernameEmptyException>()));
    });

    test('Login with empty password should throw PasswordEmptyException', () {

      when(userService.login(loginRequest)).thenThrow(PasswordEmptyException());

      expect(() => userService.login(loginRequest),
          throwsA(TypeMatcher<PasswordEmptyException>()));
    });

    test('Login with invalid credentials should throw InvalidCredentialsException', () {

      loginRequest.username = 'testing';
      loginRequest.password = 'password';
      when(userService.login(loginRequest)).thenThrow(InvalidCredentialsException());

      expect(() => userService.login(loginRequest),
          throwsA(TypeMatcher<InvalidCredentialsException>()));
    });
  });

}
