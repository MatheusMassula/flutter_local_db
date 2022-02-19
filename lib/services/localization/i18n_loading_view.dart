import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/services/localization/i18n_loading_container.dart';
import 'package:flutter_local_db/services/localization/i18n_messages_cubit.dart';
import 'package:flutter_local_db/services/localization/i18n_messages_state.dart';
import 'package:flutter_local_db/services/localization/progress_view.dart';

class I18NLoadingView extends StatelessWidget {
  final I18NWigetCreator creator;
  const I18NLoadingView({ Key key, @required this.creator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (cubit, state) {
        if(state is InitContactListI18NMessages || state is I18NMessagesLoading) {
          return ProgressView();
        } else if(state is LoadedContactListI18NMessages) {
          return creator.call(state.messages);
        }
        return Center(child: Text('Some error happened'));
      },
    );
  }
}