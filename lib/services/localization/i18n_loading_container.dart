import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/services/http/webclients/i18n_web_client.dart';
import 'package:flutter_local_db/services/localization/i18n_loading_view.dart';
import 'package:flutter_local_db/services/localization/i18n_messages.dart';
import 'package:flutter_local_db/services/localization/i18n_messages_cubit.dart';

typedef Widget I18NWigetCreator(I18NMessages messages);

class I18NLoadingContainer extends StatelessWidget {
  final I18NWigetCreator creator;
  final String viewId;
  const I18NLoadingContainer({
    Key key,
    @required this.viewId,
    @required this.creator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) {
      final cubit = I18NMessagesCubit(viewId: this.viewId);
      cubit.reload(I18NWebClient(viewId: this.viewId));
      return cubit;
    },
    child: I18NLoadingView(creator: this.creator),
  );
}