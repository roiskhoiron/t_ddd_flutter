
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:t_ddd_flutter/domain/entities/user.dart';

import 'user_test.mocks.dart';


@GenerateMocks([User])
void main() {
  group('User', () {
    late MockUser user;

    setUp(() {
      // menyiapkan object data user
      user = MockUser();
      user.id = 1;
      user.username = 'test';
      user.password = 'password';
      user.email = 'test@example.com';
    });

    test('User should have the correct attributes', () {
      // arrange
      // menyiapkan object data user yang diharapkan
      final person = User(
        id: 1,
        username: 'test',
        password: 'password',
        email: 'test@example.com');

      // assert
      expect(person.id, 1);
      expect(person.username, 'test');
      expect(person.password, 'password');
      expect(person.email, 'test@example.com');
    });

    test('User transform to json', () {
      // arrange
      // menyiapkan data json untuk diharapkan sama dengan object user
      final jsonData = {
        'id': 1,
        'username': 'test',
        'password': 'password',
        'email': 'test@example.com',
      };

      // act
      // ketika toJson dipanggil, maka kembalikan jsonData
      when(user.toJson()).thenReturn(jsonData);

      // assert
      expect(user.toJson(), jsonData);
    });

    test('User transform from json', () {
      // arrange
      // menyiapkan data json untuk dibandingkan dengan object user
      final jsonData = {
        'id': 1,
        'username': 'test',
        'password': 'password',
        'email': 'test@example.com',
      };

      // menyiapkan object user yang diharapkan
      final expectedUser = User(
        id: 1,
        username: 'test',
        password: 'password',
        email: 'test@example.com',
      );

      // act
      final user = User.fromJson(jsonData);

      // assert
      expect(user.id, expectedUser.id);
      expect(user.username, expectedUser.username);
      expect(user.password, expectedUser.password);
      expect(user.email, expectedUser.email);
    });
  });
}