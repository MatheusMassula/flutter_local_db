import 'package:flutter/material.dart';
import 'package:flutter_local_db/services/database/dao/contact_dao.dart';
import 'pages/dashboard.dart';

void main() {
  runApp(ByteBankApp(contactDao: ContactDao()));
}

class ByteBankApp extends StatelessWidget {
  final ContactDao contactDao;

  const ByteBankApp({Key key, @required this.contactDao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.green[900],
        accentColor: Colors.blueAccent[700],
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blueAccent[700],
          textTheme: ButtonTextTheme.primary,
        )
      ),
      home: Dashboard(contactDao: contactDao)
    );
  }
}