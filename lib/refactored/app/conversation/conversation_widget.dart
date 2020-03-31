import 'package:fedi/refactored/app/auth/instance/current/current_instance_bloc.dart';
import 'package:fedi/refactored/app/conversation/conversation_bloc.dart';
import 'package:fedi/refactored/app/conversation/status/context_api/conversation_status_list_bloc_context_api_impl.dart';
import 'package:fedi/refactored/app/conversation/status/conversation_api/conversation_status_list_bloc_conversation_api_impl.dart';
import 'package:fedi/refactored/app/conversation/status/conversation_status_list_widget.dart';
import 'package:fedi/refactored/app/conversation/status/post/conversation_post_status_widget.dart';
import 'package:fedi/refactored/app/status/list/cached/status_cached_list_service.dart';
import 'package:fedi/refactored/app/status/pagination/cached/status_cached_pagination_bloc_impl.dart';
import 'package:fedi/refactored/app/status/pagination/list/status_pagination_list_bloc.dart';
import 'package:fedi/refactored/app/status/pagination/list/status_pagination_list_bloc_impl.dart';
import 'package:fedi/refactored/app/status/repository/status_repository.dart';
import 'package:fedi/refactored/app/status/status_model.dart';
import 'package:fedi/refactored/app/timeline/local_preferences/timeline_local_preferences_bloc.dart';
import 'package:fedi/refactored/async/loading/init/async_init_loading_widget.dart';
import 'package:fedi/refactored/disposable/disposable_provider.dart';
import 'package:fedi/refactored/pagination/pagination_bloc.dart';
import 'package:fedi/refactored/pagination/pagination_model.dart';
import 'package:fedi/refactored/pleroma/conversation/pleroma_conversation_service.dart';
import 'package:fedi/refactored/pleroma/status/pleroma_status_service.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ConversationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var conversationBloc = IConversationBloc.of(context, listen: true);
    return AsyncInitLoadingWidget(
        asyncInitLoadingBloc: conversationBloc,
        loadingFinishedBuilder: (context) {
          return Column(
            children: <Widget>[
              Expanded(
                  child: Provider<IStatusCachedListService>(
                create: (context) {
                  var currentInstanceBloc =
                      ICurrentInstanceBloc.of(context, listen: false);

                  if (currentInstanceBloc.currentInstance.isPleromaInstance) {
                    // pleroma instances support loading by conversation id
                    return ConversationStatusListConversationApiService
                        .createFromContext(context,
                            conversation: conversationBloc.conversation);
                  } else {
                    // mastodon instances support conversation
                    // only by status context
                    return ConversationStatusListContextApiService
                        .createFromContext(context,
                            conversation: conversationBloc.conversation,
                            statusToFetchContext: conversationBloc.lastStatus);
                  }
                },
                child: DisposableProvider<
                    IPaginationBloc<PaginationPage<IStatus>, IStatus>>(
                  create: (context) => StatusCachedPaginationBloc.createFromContext(context),
                  child: DisposableProvider<IStatusPaginationListBloc>(
                    create: (context) => StatusPaginationListBloc.createFromContext(context),
                    child: ConversationStatusListWidget(
                      key: PageStorageKey(
                          "${conversationBloc.conversation.remoteId}"),
                    ),
                  ),
                ),
              )),
              ConversationPostStatusWidget()
            ],
          );
        });
  }
}
