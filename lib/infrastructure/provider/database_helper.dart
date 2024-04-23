import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../domain/entities/user.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  Database? _database;

  DatabaseHelper._init() {
    // Initialize sqflite FFI
    sqfliteFfiInit();
  }

  Future<Database> get database async {
    var database =  await _openDatabase();
    return database;
  }

  Future<Database> _openDatabase() async {

    // Implementasi untuk membuka database SQLite
    // Contoh menggunakan sqflite package
    // final dbPath = await getDatabasesPath();
    // final path = '$dbPath/your_database.db';
    var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath, options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) async {
        // Query untuk membuat tabel database
        await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        username TEXT NOT NULL,
        email TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');
      },
    ));

    // await _initTables();
    return db;
  }

  Future<User?> get(int id) async {
    // Dapatkan database instance
    final db = await database;

    // Buat query SQL untuk mengambil data pengguna berdasarkan ID
    final query = 'SELECT * FROM users WHERE id = ?';

    // Jalankan query dengan argumen ID pengguna
    final result = await db.rawQuery(query, [id]);

    // Periksa apakah data pengguna ditemukan
    if (result.isNotEmpty) {
      // Kembalikan data pengguna pertama sebagai Map
      return User.fromJson(result.first);
    } else {
      // Kembalikan null jika pengguna tidak ditemukan
      return null;
    }
  }

}
