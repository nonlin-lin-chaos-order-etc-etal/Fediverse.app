import 'package:fedi/app/chat/pleroma/accounts/pleroma_chat_accounts_page.dart';
import 'package:fedi/app/chat/pleroma/avatar/pleroma_chat_avatar_widget.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_bloc.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_bloc_impl.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_model.dart';
import 'package:fedi/app/chat/pleroma/pleroma_chat_widget.dart';
import 'package:fedi/app/chat/pleroma/current/pleroma_chat_current_bloc.dart';
import 'package:fedi/app/chat/pleroma/post/pleroma_chat_post_message_bloc_impl.dart';
import 'package:fedi/app/chat/pleroma/title/pleroma_chat_title_widget.dart';
import 'package:fedi/app/ui/button/icon/fedi_back_icon_button.dart';
import 'package:fedi/app/ui/page/fedi_sub_page_custom_app_bar.dart';
import 'package:fedi/app/ui/spacer/fedi_big_horizontal_spacer.dart';
import 'package:fedi/app/ui/status_bar/fedi_dark_status_bar_style_area.dart';
import 'package:fedi/app/ui/theme/fedi_ui_theme_model.dart';
import 'package:fedi/disposable/disposable.dart';
import 'package:fedi/disposable/disposable_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PleromaChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var chatBloc = IPleromaChatBloc.of(context, listen: false);

    return FediDarkStatusBarStyleArea(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              FediSubPageCustomAppBar(
                leading: FediBackIconButton(),
                child: buildChatAccountsWidget(context, chatBloc),
              ),
              Expanded(child: PleromaChatWidget())
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChatAccountsWidget(BuildContext context, IPleromaChatBloc chatBloc) {
    return InkWell(
      onTap: () {
        goToPleromaChatAccountsPage(context, chatBloc.chat);
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const PleromaChatAvatarWidget(baseAvatarSize: 36),
          const FediBigHorizontalSpacer(),
          PleromaChatTitleWidget(
            textStyle: IFediUiTextTheme.of(context).bigShortBoldDarkGrey,
          ),
        ],
      ),
    );
  }
}

void goToPleromaChatPage(BuildContext context, {@required IPleromaChat chat}) {
  Navigator.push(
    context,
    createPleromaChatPageRoute(chat),
  );
}

MaterialPageRoute createPleromaChatPageRoute(IPleromaChat chat) {
  return MaterialPageRoute(
      builder: (context) => DisposableProvider<IPleromaChatBloc>(
          create: (context) {
            var chatBloc = PleromaChatBloc.createFromContext(context,
                chat: chat, lastChatMessage: null);

            // we don't need to await
            chatBloc.markAsRead();

            var currentChatBloc = IPleromaChatCurrentBloc.of(context, listen: false);

            currentChatBloc.onChatOpened(chat);

            chatBloc.addDisposable(disposable: CustomDisposable(() async {
              currentChatBloc.onChatClosed(chat);
            }));

            return chatBloc;
          },
          child: PleromaChatPostMessageBloc.provideToContext(
            context,
            chatRemoteId: chat.remoteId,
            child: PleromaChatPage(),
          )));
}
