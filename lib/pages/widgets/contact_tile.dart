import 'package:flutter/material.dart';

class ContactTile extends StatelessWidget {
  final String name;
  final int account;

  ContactTile({
    @required this.name,
    @required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          '$name',
          style: TextStyle(fontSize: 24),
        ),
        subtitle: Text(
          '$account',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}