import 'dart:async';

import 'package:flutter_local_db/pages/widgets/response_dialog.dart';
import 'package:flutter_local_db/pages/widgets/transaction_auth_dialog.dart';
import 'package:flutter_local_db/services/http/webclients/transaction_web_client.dart';
import 'package:flutter_local_db/models/transaction.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionForm extends StatefulWidget {
  final Contact contact;

  const TransactionForm({
    Key key,
    @required this.contact
  }) : super(key: key);
  
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _valueController = TextEditingController();
  final TransactionWebClient _transactionWebClient = TransactionWebClient();
  final String transactionId = Uuid().v4();

  @override
  Widget build(BuildContext context) {
    print('contact to transfer: ${widget.contact.toJson()}');
    print('transactionId: $transactionId');

    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.contact.name,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${widget.contact.accountNumber}',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _valueController,
                  decoration: InputDecoration(
                    labelText: 'Value',
                    hintText: 'R\$ XX,XX'
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.maxFinite,
                  child: RaisedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => TransactionAuthDialog(
                          onTapConfirm: (String password) {
                            print(password);
                            _sendTransaction(password);
                          },
                        )
                      );
                    },
                    child: Text('Transfer'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _sendTransaction(String password) async {
    final double value = double.tryParse(_valueController.text);
    final Transaction transactionRequested = Transaction(
      transactionId,
      value,
      widget.contact
    );
    Transaction transactionResponse = await _send(transactionRequested, password);

    await _showSuccessfulMessage(transactionResponse);
  }

  Future _showSuccessfulMessage(Transaction transactionResponse) async {
    if(transactionResponse != null) {
      await showDialog(
        context: context,
        builder: (dialogContext) => SuccessDialog('Successfull transaction')
      );
    
      Navigator.of(context).pop();
    }
  }

  Future<Transaction> _send(Transaction transactionRequested, String password) async {
    final Transaction transactionResponse = await _transactionWebClient.sendTransaction(
      transaction: transactionRequested,
      password: password
    )
    .catchError(
      (onError) => _showFailureMessage(context, message: onError.message),
      test: (error) => error is HttpException
    )
    .catchError(
      (onError) => _showFailureMessage(context, message: 'We could not reach the server'),
      test: (error) => error is TimeoutException,
    )
    .catchError(
      (onError) => _showFailureMessage(context),
      test: (error) => error is Exception,
    );
    return transactionResponse;
  }

  void _showFailureMessage(BuildContext context, {String message = 'Unknown error'}) {
    showDialog(
      context: context,
      builder: (dialogContext) => FailureDialog(message: message)
    );
  }
}