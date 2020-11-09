import 'package:fedi/app/chat/conversation/with_last_message/conversation_chat_with_last_message_model.dart';
import 'package:fedi/app/chat/conversation/with_last_message/list/cached/conversation_chat_with_last_message_cached_list_bloc.dart';
import 'package:fedi/pagination/cached/cached_pagination_bloc.dart';
import 'package:fedi/pagination/cached/cached_pagination_model.dart';
import 'package:fedi/pagination/cached/with_new_items/cached_pagination_list_with_new_items_bloc_impl.dart';
import 'package:flutter/widgets.dart';

class ConversationChatWithLastMessagePaginationListWithNewItemsBloc<
        TPage extends CachedPaginationPage<IConversationChatWithLastMessage>>
    extends CachedPaginationListWithNewItemsBloc<TPage,
        IConversationChatWithLastMessage> {
  final IConversationChatWithLastMessageCachedBloc cachedListBloc;

  ConversationChatWithLastMessagePaginationListWithNewItemsBloc(
      {@required
          bool mergeNewItemsImmediately,
      @required
          this.cachedListBloc,
      @required
          ICachedPaginationBloc<TPage, IConversationChatWithLastMessage>
              paginationBloc})
      : super(
            mergeNewItemsImmediately: mergeNewItemsImmediately,
            paginationBloc: paginationBloc);

  @override
  Stream<List<IConversationChatWithLastMessage>> watchItemsNewerThanItem(
          IConversationChatWithLastMessage item) =>
      cachedListBloc.watchLocalItemsNewerThanItem(item);

  @override
  int compareItemsToSort(
      IConversationChatWithLastMessage a, IConversationChatWithLastMessage b) {
    if (a?.chat?.updatedAt == null && b?.chat?.updatedAt == null) {
      return 0;
    }

    if (a?.chat?.updatedAt != null && b?.chat?.updatedAt == null) {
      return 1;
    }
    if (a?.chat?.updatedAt == null && b?.chat?.updatedAt != null) {
      return -1;
    }
    return a.chat.updatedAt.compareTo(b?.chat?.updatedAt);
  }

  @override
  bool isItemsEqual(IConversationChatWithLastMessage a,
          IConversationChatWithLastMessage b) =>
      a.chat.remoteId == b.chat.remoteId;
}
