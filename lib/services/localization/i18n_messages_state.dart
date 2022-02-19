import 'package:flutter_local_db/services/localization/i18n_messages.dart';

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