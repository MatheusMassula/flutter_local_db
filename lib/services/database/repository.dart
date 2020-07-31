import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  String databasePath = await getDatabasesPath();
  
  return openDatabase(
    join(databasePath, 'bytebank.db'),
    version: 1,
    onCreate: (db, version) {
      db.execute('CREATE TABLE contact(id INTEGER PRIMARY KEY, name TEXT, account INTEGER)');
    },
    onDowngrade: onDatabaseDowngradeDelete
  );
}


Future<int> insertContact({@required Contact contact}) {
  return getDatabase().then((db) {
    return db.insert('contact', contact.toJsonWithoutId());
  });
}

Future<List<Contact>> getContactList() {
  return getDatabase().then((db) {
    return db.query('contact').then(
      (contactList) {
        List<Contact> result = List();

        for (var contact in contactList) {
          result.add(Contact.fromJson(contact));
        }

        return result;
      }
    );
  });
}