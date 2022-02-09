import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/models/state/name.dart';
import 'package:flutter_local_db/pages/name.dart';
import 'package:flutter_local_db/pages/transactions_list.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'package:flutter_local_db/services/localization/view_i18n.dart';
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
    final DashboardViewI18N i18n = DashboardViewI18N(context);

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
                        title: i18n.transfer,
                        icon: Icons.monetization_on,
                        onTap: () => Navigator.of(blocContext).push(
                          MaterialPageRoute(builder: (context) => TransferListContainer())
                        ),
                      ),

                      DashboardCard(
                        title: i18n.transactions,
                        icon: Icons.description,
                        onTap: () => Navigator.of(blocContext).push(
                          MaterialPageRoute(builder: (context) => TransactionsList())
                        ),
                      ),

                      DashboardCard(
                        title: i18n.change_name,
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

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String get transfer => localize(
    {
      'pt-br': 'Tranferir',
      'en': 'Transfer'
    }
  );

  String get transactions => localize(
    {
      'pt-br': 'Transações',
      'en': 'Transactions'
    }
  );

  String get change_name => localize(
    {
      'pt-br': 'Trocar nome',
      'en': 'Change name'
    }
  );
}
