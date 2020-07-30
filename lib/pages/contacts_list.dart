import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter_local_db/pages/contact_form.dart';
import 'package:flutter_local_db/pages/widgets/contact_tile.dart';
import 'package:flutter_local_db/services/database/repository.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {

  final contactList = List<Contact>();

  @override
  Widget build(BuildContext context) {
    print('build contact list');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addContact(),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView.builder(
        itemCount: contactList.length,
        itemBuilder: (context, index) {
          return ContactTile(contact: contactList[index],);
        }
      ),
    );
  }

  void _addContact() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContactForm(),
    )).then((contact) {
      if (contact != null) {
        insertContact(contact: contact);
      }
    });
  }
}
