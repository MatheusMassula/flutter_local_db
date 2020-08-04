import 'package:flutter_local_db/models/transaction.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_db/services/http/web_client.dart';

import 'widgets/progress_indicator_widget.dart';
import 'widgets/transaction_tile.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions = List();

  @override
  Widget build(BuildContext context) {
    transactions.add(
      Transaction(
        100.0,
        Contact(
          0,
          'Alex',
          1000
        )
      )
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: getAllTransactions(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return TransactionTile(transaction: snapshot.data[index]);
                },
              );
              break;

            case ConnectionState.none:
              return Container();
              break;

            case ConnectionState.waiting:
              return ProgressIndicatorWidget();
              break;

            case ConnectionState.active:
              return Container();
              break;
            
            default:
              return Container();
              break;
          }
        }
      )
    );
  }
}