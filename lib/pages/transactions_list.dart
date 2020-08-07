import 'package:flutter_local_db/services/http/webclients/transaction_web_client.dart';
import 'package:flutter_local_db/models/transaction.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'widgets/progress_indicator_widget.dart';
import 'widgets/empty_list_placeholder.dart';
import 'widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _transactionWebClient = TransactionWebClient();
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
        future: _transactionWebClient.getAllTransactions(),
        builder: (context, snapshot) {
          if(!snapshot.hasError) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                final List<Transaction> transactionList = snapshot.data;

                if(transactionList.isEmpty) {
                  return EmptyListPlaceHolder(
                    icon: Icons.list,
                    message: 'No data available'
                  );
                }
                else {
                  return _buildTransactionList(transactionList);
                }
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
                return EmptyListPlaceHolder(
                  icon: Icons.error_outline,
                  message: 'Something went wrong'
                );
                break;
            }
          }
          else {
            return EmptyListPlaceHolder(
              icon: Icons.error_outline,
              message: 'Something went worng'
            );
          }
        }
      )
    );
  }

  ListView _buildTransactionList(List<Transaction> transactionList) {
    return ListView.builder(
      itemCount: transactionList.length,
      itemBuilder: (context, index) {
        return TransactionTile(transaction: transactionList[index]);
      },
    );
  }
}