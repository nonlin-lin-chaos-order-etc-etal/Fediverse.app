import 'package:fedi/disposable/disposable.dart';
import 'package:fedi/pleroma/chat/pleroma_chat_model.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IPleromaChatNewMessagesHandlerBloc extends IDisposable {
  Future handleNewMessage(IPleromaChatMessage chatMessage);
  Future handleChatUpdate(PleromaChat chat);
  static IPleromaChatNewMessagesHandlerBloc of(BuildContext context, {bool listen = true}) =>
      Provider.of<IPleromaChatNewMessagesHandlerBloc>(context, listen: listen);

}