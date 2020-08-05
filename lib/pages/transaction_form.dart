import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New transaction'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _valueController,
                decoration: InputDecoration(
                  labelText: 'Value',
                  hintText: 'R\$ XX,XX'
                ),
                keyboardType: TextInputType.number,
                style: TextStyle(fontSize: 24),
              )
            ],
          ),
        )
      ),
    );
  }
}