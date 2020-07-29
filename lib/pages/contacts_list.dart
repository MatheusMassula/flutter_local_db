import 'package:flutter/material.dart';
import 'package:flutter_local_db/pages/contact_form.dart';
import 'package:flutter_local_db/pages/widgets/contact_tile.dart';

class ContactList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => ContactForm(),
              ))
              .then(
                (value) => print(value),
              );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: ListView(
        children: List.generate(
          20,
          (index) => ContactTile(
            name: 'Name $index',
            account: index,
          ),
        ),
      ),
    );
  }
}
