
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
      user = MockUser();
      user.id = 1;
      user.username = 'test';
      user.password = 'password';
      user.email = 'test@example.com';
    });

    test('User should have the correct attributes', () {
      final person = User(
        id: 1,
        username: 'test',
        password: 'password',
        email: 'test@example.com');

      expect(person.id, 1);
      expect(person.username, 'test');
      expect(person.password, 'password');
      expect(person.email, 'test@example.com');
    });

    test('User transform to json', () {
      final jsonData = {
        'id': 1,
        'username': 'test',
        'password': 'password',
        'email': 'test@example.com',
      };

      when(user.toJson()).thenReturn(jsonData);

      expect(user.toJson(), jsonData);
    });

    test('User transform from json', () {
      final jsonData = {
        'id': 1,
        'username': 'test',
        'password': 'password',
        'email': 'test@example.com',
      };

      final user = User.fromJson(jsonData);

      final expectedUser = User(
        id: 1,
        username: 'test',
        password: 'password',
        email: 'test@example.com',
      );

      expect(user.id, expectedUser.id);
      expect(user.username, expectedUser.username);
      expect(user.password, expectedUser.password);
      expect(user.email, expectedUser.email);
    });
  });
}