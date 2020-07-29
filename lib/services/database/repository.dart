import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase() {
  getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'bytebank.db');
    openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('CREATE TABLE contact( id INTEGER PRIMARY KEY, name TEXT, account_number INTEGER)');
      },
    );
  });
}
