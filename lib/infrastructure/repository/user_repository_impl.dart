import 'package:mockito/annotations.dart';

import '../../domain/entities/user.dart';
import '../../domain/interface/user_repository.dart';
import '../../domain/validator/exception.dart';
import '../provider/database_helper.dart';

class UserRepositoryImpl implements UserRepository {
  // Gunakan database lokal atau API untuk menyimpan dan mengambil data pengguna
  // Contoh menggunakan SQLite
  @override
  Future<User?> login(String username, String password) async {
    const query = 'SELECT * FROM users WHERE username = ? AND password = ?';
    final args = [username, password];

    final db = await DatabaseHelper.instance.database;
    final result = await db.rawQuery(query, args);

    if (result.isEmpty) {
      throw InvalidCredentialsException();
    }

    final userMap = result.first;
    final user = User(
      id: userMap['id'] as int,
      username: userMap['username'] as String,
      password: userMap['password'] as String,
      email: userMap['email'] as String,
    );

    return user;
  }

  Future<User?> getUserById(int id) async {
    return DatabaseHelper.instance.get(table: 'users', id: id);
  }

  @override
  Future<bool> register(User data) {
    // Sisipkan data pengguna ke dalam database
    return DatabaseHelper.instance.database.then((db) {
      return db.insert('users', data.toJson()).then((value) => value == 1);
    });
  }
}
