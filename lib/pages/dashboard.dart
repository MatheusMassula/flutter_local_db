import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/models/state/name.dart';
import 'package:flutter_local_db/pages/name.dart';
import 'package:flutter_local_db/pages/transactions_list.dart';
import 'package:flutter_local_db/pages/transfer_list.dart';
import 'package:flutter_local_db/services/localization/localization_container.dart';
import 'widgets/dashboard_card.dart';

class DashboardContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit('Massula'),
      child: I18NLoadingContainer(
        creator: (I18NMessages messages) => DashboardView(i18n: DashboardViewLazyI18N(messages: messages))
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N i18n;

  const DashboardView({Key key, this.i18n}) : super(key: key);
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
                        title: i18n.changeName,
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

// class DashboardViewI18N extends ViewI18N {
//   DashboardViewI18N(BuildContext context) : super(context);

//   String get transfer => localize(
//     {
//       'pt-br': 'Tranferir',
//       'en': 'Transfer'
//     }
//   );

//   String get transactions => localize(
//     {
//       'pt-br': 'Transações',
//       'en': 'Transactions'
//     }
//   );

//   String get changeName => localize(
//     {
//       'pt-br': 'Trocar nome',
//       'en': 'Change name'
//     }
//   );
// }

class DashboardViewLazyI18N {
  final I18NMessages messages;
  DashboardViewLazyI18N({@required this.messages});

  String get transfer => messages.get('transfer');

  String get transactions => messages.get('transactions');

  String get changeName => messages.get('changeName');
}