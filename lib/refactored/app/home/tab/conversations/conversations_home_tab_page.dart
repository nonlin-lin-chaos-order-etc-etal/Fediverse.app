import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/refactored/app/account/my/settings/my_account_settings_bloc.dart';
import 'package:fedi/refactored/app/conversation/conversations_list_bloc.dart';
import 'package:fedi/refactored/app/conversation/conversations_list_bloc_impl.dart';
import 'package:fedi/refactored/app/conversation/conversations_list_widget.dart';
import 'package:fedi/refactored/app/conversation/start/start_conversation_page.dart';
import 'package:fedi/refactored/app/search/search_page.dart';
import 'package:fedi/refactored/app/ui/button/icon/fedi_icon_in_circle_transparent_button.dart';
import 'package:fedi/refactored/app/ui/button/text/fedi_transparent_text_button.dart';
import 'package:fedi/refactored/app/ui/fedi_icons.dart';
import 'package:fedi/refactored/app/ui/header/fedi_header_text.dart';
import 'package:fedi/refactored/app/ui/home/fedi_home_tab_container_widget.dart';
import 'package:fedi/refactored/disposable/disposable_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

var _logger = Logger("conversations_home_tab_page.dart");

final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

class ConversationsHomeTabPage extends StatelessWidget {
  const ConversationsHomeTabPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _logger.finest(() => "build");

    return Scaffold(
      key: _drawerKey,
      body: FediHomeTabContainer(
        topHeaderHeightInSafeArea: 104.0,
        topBar: buildTopBar(context),
        body: DisposableProvider<IConversationsListBloc>(
            create: (context) =>
                ConversationsListBloc.createFromContext(context),
            child: ConversationsListWidget(key: key)),
      ),
    );
  }

  Widget buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: FediHeaderText(AppLocalizations.of(context)
              .tr("app.home.tab.conversations.title")),
        ),
        Row(
          children: <Widget>[
            FediTransparentTextButton(
                AppLocalizations.of(context)
                    .tr("app.home.tab.conversations.action.switch_to_chats"),
                onPressed: () {
              IMyAccountSettingsBloc.of(context, listen: false)
                  .changeIsNewChatsEnabled(true);
            }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: buildSearchActionButton(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: buildPenActionButton(context),
            )
          ],
        )
      ],
    );
  }

  Widget buildPenActionButton(BuildContext context) =>
      FediIconInCircleTransparentButton(
        FediIcons.pen,
        onPressed: () {
          goToStartConversationPage(context);
        },
      );

  Widget buildSearchActionButton(BuildContext context) =>
      FediIconInCircleTransparentButton(
        FediIcons.search,
        onPressed: () {
          goToSearchPage(context);
        },
      );
}
