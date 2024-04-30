import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:t_ddd_flutter/application/user_service.dart';
import 'package:t_ddd_flutter/domain/entities/login_request.dart';
import 'package:t_ddd_flutter/domain/entities/user.dart';
import 'package:t_ddd_flutter/domain/validator/exception.dart';

import '../domain/interface/user_repository_test.mocks.dart';

@GenerateMocks([UserService])
void main() {
  group('UserService', () {
    late UserService userService;
    late MockUserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
      userService = UserService(userRepository);
    });

    test('login should throw UsernameEmptyException if username is empty', () {
      // Arrange
      final request = LoginRequest(username: '', password: 'password');

      // Act & Assert
      expect(() => userService.login(request),
          throwsA(const TypeMatcher<UsernameEmptyException>()));
    });

    test('login should throw PasswordEmptyException if password is empty', () {
      // Arrange
      final request = LoginRequest(username: 'username', password: '');

      // Act & Assert
      expect(() => userService.login(request),
          throwsA(const TypeMatcher<PasswordEmptyException>()));
    });

    test('login should throw InvalidCredentialsException if user is not found',
        () async {
      // Arrange
      final request = LoginRequest(username: 'username', password: 'password');
      when(userRepository.login('username', 'password'))
          .thenAnswer((_) async => null);

      // Act & Assert
      expect(() => userService.login(request),
          throwsA(const TypeMatcher<InvalidCredentialsException>()));
    });

    test('login should return LoginResponse if user is found', () async {
      // Arrange
      final user = User(
          id: 1,
          username: 'username',
          password: 'password',
          email: 'user@example.com');
      final request = LoginRequest(username: 'username', password: 'password');
      when(userRepository.login('username', 'password'))
          .thenAnswer((_) async => user);

      // Act
      final response = await userService.login(request);

      // Assert
      expect(response.token, isNotNull);
      expect(response.user, equals(user));
    });

    test('generateToken should return a valid token', () {
      // Arrange
      final user = User(
          id: 1,
          username: 'username',
          password: 'password',
          email: 'user@example.com');

      // Act
      final token = userService.generateToken(user);

      // Assert
      expect(token, isNotEmpty);
    });
  });
}
