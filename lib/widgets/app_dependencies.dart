import 'package:flutter/material.dart';
import 'package:flutter_local_db/services/database/dao/contact_dao.dart';
import 'package:flutter_local_db/services/http/webclients/transaction_web_client.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;

  AppDependencies({
    Key key,
    Widget child,
    @required this.contactDao,
    @required this.transactionWebClient,
  }) : super(key: key, child: child);

  static AppDependencies of(BuildContext context) => 
    context.dependOnInheritedWidgetOfExactType<AppDependencies>();

  @override
  bool updateShouldNotify(AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao 
      || transactionWebClient != oldWidget.transactionWebClient;
  }
  
}