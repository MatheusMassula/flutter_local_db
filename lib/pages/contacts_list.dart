import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter_local_db/pages/contact_form.dart';
import 'package:flutter_local_db/pages/widgets/contact_tile.dart';
import 'package:flutter_local_db/services/database/repository.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build contact list');
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addContact(context),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder(
        initialData: List(),
        future: getContactList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final List<Contact> contactList = snapshot.data;

              return ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  return ContactTile(contact: contactList[index],);
                }
              );
              break;

            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Loading...')
                  ],
                ),
              );
              break;

            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }

  void _addContact(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ContactForm(),
    )).then((contact) {
      if (contact != null) {
        insertContact(contact: contact);
      }
    });
  } 
}
