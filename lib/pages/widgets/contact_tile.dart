import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/contact.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  final Function onTap;

  ContactTile({
    Key key,
    @required this.contact,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => onTap(),
        title: Text(
          '${contact.name}',
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          '${contact.accountNumber}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}