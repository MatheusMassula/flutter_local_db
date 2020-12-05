import 'package:flutter/material.dart';
import 'package:flutter_local_db/services/database/dao/contact_dao.dart';
import 'package:flutter_local_db/services/http/webclients/transaction_web_client.dart';
import 'package:flutter_local_db/widgets/app_dependencies.dart';
import 'package:flutter_local_db/widgets/theme.dart';
import 'pages/counter.dart';
import 'pages/dashboard.dart';

void main() {
  runApp(ByteBankApp(
    contactDao: ContactDao(),
    transactionWebClient: TransactionWebClient()
  ));
}

class ByteBankApp extends StatelessWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  const ByteBankApp({
    Key key,
    @required this.contactDao,
    @required this.transactionWebClient
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppDependencies(
      contactDao: contactDao,
      transactionWebClient: transactionWebClient,
      child: MaterialApp(
        theme: byteBankTheme,
        home: CounterContainer()
        //Dashboard()
      ),
    );
  }
}