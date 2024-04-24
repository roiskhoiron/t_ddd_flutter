import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../../../lib/infrastructure/provider/database_helper.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  group('DatabaseHelper', () {
    late DatabaseHelper databaseHelper;
    late Database db;

    setUp(() async {
      // Dapatkan instance DatabaseHelper
      databaseHelper = DatabaseHelper.instance;
      db = await databaseHelper.database;
    });

    test('DatabaseHelper.instance should initialize the db version to version 1 ', () async {
      // var db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      expect(await db.getVersion(),  1);
      await db.close();
    });

    test('DatabaseHelper.insert() should insert a new record into the database', () async {
      // Buat data untuk dimasukkan
      final data = {'id': 2, 'username': 'John Doe', 'email': 'johndoe@example.com', 'password': 'password'};

      // Sisipkan data ke dalam database
      final insertedId = await db.insert('users', data);

      // Verifikasi bahwa data telah dimasukkan dengan benar
      expect(insertedId, 2);

      // Ambil data yang dimasukkan
      final retrievedData = await db.query('users', where: 'id = ?', whereArgs: [2]);

      // Verifikasi bahwa data yang diambil sesuai dengan data yang dimasukkan
      expect(retrievedData.first, data);
    });

  });
}