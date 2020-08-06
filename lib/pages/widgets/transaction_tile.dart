import 'package:flutter/material.dart';
import 'package:flutter_local_db/models/transaction.dart';

class TransactionTile extends StatelessWidget {
  const TransactionTile({
    Key key,
    @required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(
          transaction.value.toString(),
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${transaction.contact.accountNumber}',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}