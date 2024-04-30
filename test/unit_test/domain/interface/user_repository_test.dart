import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:t_ddd_flutter/domain/entities/user.dart';
import 'package:t_ddd_flutter/domain/interface/user_repository.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  group('Unit Test', () {
    late MockUserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();
    });

    test(
        'Register should return true when user data is successfully registered',
        () async {
      // arrange
      // Data pengguna sample untuk dimasukkan ke dalam database
      final user = User(
          id: 1,
          username: 'test',
          password: 'password',
          email: 'test@example.com');

      // act
      when(userRepository.register(user)).thenAnswer((_) async => true);
      // eksekusi metode register
      final result = await userRepository.register(user);

      // assert
      expect(result, true);

      verify(userRepository.register(user));
    });

    test('Login should return a user when valid credentials are provided',
        () async {
      // arrange
      // Data pengguna sample untuk dimasukkan ke dalam database
      final user = User(
          id: 1,
          username: 'test',
          password: 'password',
          email: 'test@example.com');

      // act
      when(userRepository.login('test', 'password'))
          .thenAnswer((_) async => user);
      final result = await userRepository.login('test', 'password');

      // eksekusi metode login

      // assert
      expect(result, user);

      verify(userRepository.login('test', 'password'));
    });
  });
}
