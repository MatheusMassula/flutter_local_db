import 'package:flutter/material.dart';
import 'package:flutter_local_db/pages/transactions_list.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';

import 'widgets/dashboard_card.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Column(
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
                    MaterialPageRoute(builder: (context) => TransferList())
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
    );
  }
}
