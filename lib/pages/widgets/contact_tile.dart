import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;

  ContactTile({
    @required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          '${contact.name}',
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          '${contact.account}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}