import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String dbPath = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    dbPath,
    version: 1,
    onCreate: (db, version) {
      db.execute('CREATE TABLE contact(id INTEGER PRIMARY KEY, name TEXT, account INTEGER)');
    },
    onDowngrade: onDatabaseDowngradeDelete
  );
}

Future<int> insertContact({@required Contact contact}) async {
  final Database db = await getDatabase();
  return db.insert('contact', contact.toJsonWithoutId());
}

Future<List<Contact>> getContactList() async {
  final Database db = await getDatabase();
  final List<Map<String, dynamic>> contactList = await db.query('contact');

  List<Contact> result = List();
  for (var contact in contactList) {
    result.add(Contact.fromJson(contact));
  }
  return result;
}