import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;

  ContactTile({
    Key key,
    @required this.contact,
  }) : super(key: key);

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