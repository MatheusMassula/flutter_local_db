import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/pages/name.dart';
import 'package:flutter_local_db/pages/transactions_list.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'widgets/dashboard_card.dart';

class DashboardContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Massula'),
      child: DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final name = context.watch<NameCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $name'),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (BuildContext blocContext, BoxConstraints boxConstraints) => SingleChildScrollView(
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
                        onTap: () => Navigator.of(blocContext).push(
                          MaterialPageRoute(builder: (context) => TransferList())
                        ),
                      ),

                      DashboardCard(
                        title: 'Transactions',
                        icon: Icons.description,
                        onTap: () => Navigator.of(blocContext).push(
                          MaterialPageRoute(builder: (context) => TransactionsList())
                        ),
                      ),

                      DashboardCard(
                        title: 'Change name',
                        icon: Icons.person_outline,
                        onTap: () => Navigator.of(blocContext).push(
                          MaterialPageRoute(builder: (context) => BlocProvider.value(
                            value: BlocProvider.of<NameCubit>(blocContext),
                            child: NameContainer(),
                          ))
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
