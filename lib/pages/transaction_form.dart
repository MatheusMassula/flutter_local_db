import 'package:flutter_local_db/services/http/webclients/transaction_web_client.dart';
import 'package:flutter_local_db/models/transaction.dart';
import 'package:flutter_local_db/models/contact.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    print('contact to transfer: ${widget.contact.toJson()}');

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
                      final double value = double.tryParse(_valueController.text);
                      final transactionRequested = Transaction(value, widget.contact);
                      _transactionWebClient.sendTransaction(transaction: transactionRequested)
                      .then((transactionResponse) => {
                        if(transactionResponse != null) {
                          Navigator.of(context).pop()
                        }
                      });
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
}