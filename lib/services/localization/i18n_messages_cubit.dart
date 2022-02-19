import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_db/services/http/webclients/i18n_web_client.dart';
import 'package:flutter_local_db/services/localization/i18n_messages.dart';
import 'package:flutter_local_db/services/localization/i18n_messages_state.dart';
import 'package:localstorage/localstorage.dart';

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  final LocalStorage storage = LocalStorage('local_unsecure_version_1.json');
  final String viewId;
  I18NMessagesCubit({@required this.viewId}) : super(InitContactListI18NMessages());

  Future<void> reload(I18NWebClient i18NWebClient) async {
    try {
      emit(I18NMessagesLoading());

      await storage.ready;
      I18NMessages messages;
      if (storage.getItem(this.viewId) != null) {
        messages = I18NMessages(storage.getItem(this.viewId));
      } else {
        final translations = await i18NWebClient.getTranlations();
        storage.setItem(this.viewId, translations);
        messages = I18NMessages(translations);
      }

      emit(LoadedContactListI18NMessages(messages));
    } catch (e) {
    }
  }
}