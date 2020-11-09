import 'package:flutter/material.dart';

const Key transactionAuthDialogPasswordTextFieldKey = Key('transactionAuthDialogPasswordTextField');

class TransactionAuthDialog extends StatefulWidget {
  final Function(String password) onTapConfirm;

  const TransactionAuthDialog({
    Key key,
    @required this.onTapConfirm
  }) : super(key: key);

  @override
  _TransactionAuthDialogState createState() => _TransactionAuthDialogState();
}

class _TransactionAuthDialogState extends State<TransactionAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Authenticate'),
      content: TextField(
        key: transactionAuthDialogPasswordTextFieldKey,
        controller: _passwordController,
        obscureText: true,
        maxLength: 4,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        style: TextStyle(
          letterSpacing: 32,
          fontSize: 32
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel')
        ),
        FlatButton(
          onPressed: () {
            widget.onTapConfirm(_passwordController.text);
            Navigator.of(context).pop();
          },
          child: Text('Accept')
        )
      ],
    );
  }
}