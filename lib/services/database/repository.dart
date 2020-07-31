import 'package:flutter_local_db/services/database/dao/contact_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    dbPath,
    version: 1,
    onCreate: (db, version) {
      db.execute(ContactDao.TABLE_SQL);
    },
  );
}