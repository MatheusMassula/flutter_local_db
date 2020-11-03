import 'package:flutter/material.dart';
import 'package:flutter_local_db/pages/transactions_list.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'package:flutter_local_db/services/database/dao/contact_dao.dart';

import 'widgets/dashboard_card.dart';

class Dashboard extends StatelessWidget {

  final ContactDao contactDao;

  const Dashboard({Key key, @required this.contactDao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints boxConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: boxConstraints.maxHeight
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/images/bytebank_logo.png'),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      DashboardCard(
                        title: 'Transfer',
                        icon: Icons.monetization_on,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TransferList(contactDao: contactDao))
                        ),
                      ),

                      DashboardCard(
                        title: 'Transactions',
                        icon: Icons.description,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TransactionsList())
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
