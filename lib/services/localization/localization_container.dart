import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/services/http/webclients/i18n_web_client.dart';
import 'package:flutter_local_db/services/localization/localization_cubit.dart';

class LocalizationContainer extends StatelessWidget {
  final Widget child;
  const LocalizationContainer({ Key key, @required this.child }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider<CurrentLocaleCubit>(
    create: (context) => CurrentLocaleCubit(),
    child: this.child,
  );
}

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
      final cubit = I18NMessagesCubit();
      cubit.reload(I18NWebClient(viewId: this.viewId));
      return cubit;
    },
    child: I18NLoadingView(creator: this.creator),
  );
}

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

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  I18NMessagesCubit() : super(InitContactListI18NMessages());

  Future<void> reload(I18NWebClient i18NWebClient) async {
    try {
      emit(I18NMessagesLoading());

      final translations = await i18NWebClient.getTranlations();
      final I18NMessages messages = I18NMessages(translations);

      emit(LoadedContactListI18NMessages(messages));
    } catch (e) {
    }
  }
}

abstract class I18NMessagesState {
  const I18NMessagesState();
}

class I18NMessagesLoading extends I18NMessagesState {
  const I18NMessagesLoading();
}

class InitContactListI18NMessages extends I18NMessagesState {
  const InitContactListI18NMessages();
}

class LoadedContactListI18NMessages extends I18NMessagesState {
  final I18NMessages messages;

  const LoadedContactListI18NMessages(this.messages);
}

class ErrorContactListI18NMessages extends I18NMessagesState {
  const ErrorContactListI18NMessages();
}

class I18NMessages {
  final Map<String, dynamic> messages;
  I18NMessages(this.messages);

  String get(String key) {
    assert(key != null);
    assert(messages.containsKey(key));
    return messages[key];
  }
}

class ProgressView extends StatelessWidget {
  const ProgressView({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Text('Loading...')
        ],
      ),
    ),
  );
}