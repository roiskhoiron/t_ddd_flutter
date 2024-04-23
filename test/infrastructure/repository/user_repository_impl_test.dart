import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:t_ddd_flutter/domain/entities/user.dart';
import 'package:t_ddd_flutter/infrastructure/repository/user_repository_impl.dart';

import '../provider/database_helper_test.mocks.dart';
import 'user_repository_impl_test.mocks.dart';

@GenerateMocks([UserRepositoryImpl])
void main() {
  group('UserRepositoryImpl', () {
    late MockUserRepositoryImpl userRepository;
    late MockDatabaseHelper mockDatabaseHelper;

    setUp(() async {
      mockDatabaseHelper = MockDatabaseHelper();
      userRepository = MockUserRepositoryImpl();
    });

    test('getUserById should return a user if found', () async {
      // Data pengguna sample untuk dimasukkan ke dalam database
      final data = User(
          id: 1,
          username: 'John Doe',
          email: 'johndoe@example.com',
          password: 'password');

      // Sisipkan data ke dalam database

      when(mockDatabaseHelper.insert(table: 'users', data: data.toJson()))
          .thenAnswer((_) async => 1);

      // Data pengguna sample untuk diambil dan dibandingkan
      final user = User(
          id: 1,
          username: 'John Doe',
          email: 'johndoe@example.com',
          password: 'password');

      // Siapkan database tiruan untuk mengembalikan data pengguna
      when(userRepository.getUserById(1)).thenAnswer((_) async => user);

      // Dapatkan pengguna dari repositori
      final retrievedUser = await userRepository.getUserById(user.id);

      // Verifikasi bahwa pengguna yang diambil sesuai dengan data pengguna sample
      expect(retrievedUser!.id, user.id);

      // Memverifikasi bahwa metode get dipanggil dengan argumen 1
      verify(await userRepository.getUserById(user.id));
    });

    test('getUserById should return null if user not found', () async {
      // Siapkan database tiruan untuk mengembalikan null
      when(userRepository.getUserById(2))
          .thenAnswer((realInvocation) async => null);

      // Dapatkan pengguna dari repositori
      final retrievedUser = await userRepository.getUserById(2);

      // Verifikasi bahwa null dikembalikan jika pengguna tidak ditemukan
      expect(retrievedUser, null);

      // Memverifikasi bahwa metode get dipanggil dengan argumen 2
      verify(await userRepository.getUserById(2));
    });
  });
}
