import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../repository.dart';

class ContactDao {
  static const TABLE_SQL = 'CREATE TABLE $_TABLE_NAME($_ID INTEGER PRIMARY KEY, $_NAME TEXT, $_ACCOUNT INTEGER)';
  static const _TABLE_NAME = 'contact';
  static const _ID = 'id';
  static const _NAME = 'name';
  static const _ACCOUNT = 'account';

  Future<int> insert({@required Contact contact}) async {
    final Database db = await getDatabase();
    return db.insert('$_TABLE_NAME', contact.toJsonWithoutId());
  }

  Future<List<Contact>> getAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> contactList = await db.query('$_TABLE_NAME');

    List<Contact> result = List();
    for (var contact in contactList) {
      result.add(Contact.fromJson(contact));
    }
    return result;
  }

  Future<int> update(Contact contact) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> contactMap = contact.toJson();
    return db.update(
      _TABLE_NAME,
      contactMap,
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _TABLE_NAME,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}