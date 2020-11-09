import 'package:fedi/app/account/account_bloc.dart';
import 'package:fedi/app/account/account_bloc_impl.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/account_widget.dart';
import 'package:fedi/app/account/details/account_details_bloc.dart';
import 'package:fedi/app/account/details/account_details_bloc_impl.dart';
import 'package:fedi/app/account/display_name/account_display_name_and_acct_widget.dart';
import 'package:fedi/app/account/header/account_header_background_widget.dart';
import 'package:fedi/app/account/statuses/account_statuses_media_widget.dart';
import 'package:fedi/app/account/statuses/account_statuses_tab_indicator_item_widget.dart';
import 'package:fedi/app/account/statuses/account_statuses_tab_model.dart';
import 'package:fedi/app/account/statuses/account_statuses_timeline_widget.dart';
import 'package:fedi/app/account/statuses/media_only/account_statuses_media_only_cached_list_bloc_impl.dart';
import 'package:fedi/app/account/statuses/pinned_only/account_statuses_pinned_only_network_only_list_bloc_impl.dart';
import 'package:fedi/app/account/statuses/with_replies/account_statuses_with_replies_cached_list_bloc_impl.dart';
import 'package:fedi/app/account/statuses/without_replies/account_statuses_without_replies_cached_list_bloc_impl.dart';
import 'package:fedi/app/status/list/status_list_tap_to_load_overlay_widget.dart';
import 'package:fedi/app/status/pagination/cached/status_cached_pagination_bloc_impl.dart';
import 'package:fedi/app/status/pagination/list/status_cached_pagination_list_with_new_items_bloc_impl.dart';
import 'package:fedi/app/status/pagination/network_only/status_network_only_pagination_bloc_impl.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/ui/button/icon/fedi_back_icon_button.dart';
import 'package:fedi/app/ui/fedi_border_radius.dart';
import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:fedi/app/ui/list/fedi_list_tile.dart';
import 'package:fedi/app/ui/page/fedi_sub_page_custom_app_bar.dart';
import 'package:fedi/app/ui/scroll/fedi_nested_scroll_view_bloc.dart';
import 'package:fedi/app/ui/scroll/fedi_nested_scroll_view_with_nested_scrollable_tabs_bloc.dart';
import 'package:fedi/app/ui/scroll/fedi_nested_scroll_view_with_nested_scrollable_tabs_bloc_impl.dart';
import 'package:fedi/app/ui/scroll/fedi_nested_scroll_view_with_nested_scrollable_tabs_widget.dart';
import 'package:fedi/app/ui/status_bar/fedi_dark_status_bar_style_area.dart';
import 'package:fedi/app/ui/theme/fedi_ui_theme_model.dart';
import 'package:fedi/collapsible/collapsible_owner_widget.dart';
import 'package:fedi/disposable/disposable_provider.dart';
import 'package:fedi/pagination/list/pagination_list_bloc.dart';
import 'package:fedi/pagination/list/pagination_list_bloc_impl.dart';
import 'package:fedi/pagination/pagination_bloc.dart';
import 'package:fedi/pagination/pagination_model.dart';
import 'package:fedi/provider/tab_controller_provider.dart';
import 'package:fedi/ui/scroll/scroll_controller_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var _headerBackgroundHeight = 200.0;

const _tabs = [
  AccountStatusesTab.withoutReplies,
  AccountStatusesTab.pinned,
  AccountStatusesTab.media,
  AccountStatusesTab.withReplies,
];

class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => TabControllerProvider(
        tabControllerCreator: (context, tickerProvider) => TabController(
          vsync: tickerProvider,
          length: _tabs.length,
        ),
        child: const AccountDetailsPageBody(),
      );
}

class AccountDetailsPageBody extends StatelessWidget {
  const AccountDetailsPageBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IFediUiColorTheme.of(context).white,
      appBar: FediSubPageCustomAppBar(
        leading: const FediBackIconButton(),
        child: const AccountDisplayNameAndAcctWidget(),
      ),
      body: Stack(
        children: [
          Container(
            height: _headerBackgroundHeight,
            child: const AccountHeaderBackgroundWidget(),
          ),
          const _AccountDetailsPageBodyContent(),
        ],
      ),
    );
  }
}

class _AccountDetailsPageBodyContent extends StatelessWidget {
  const _AccountDetailsPageBodyContent();

  @override
  Widget build(BuildContext context) {
    var tabController = Provider.of<TabController>(context);
    var accountDetailsBloc = IAccountDetailsBloc.of(context, listen: false);
    return DisposableProvider<
        IFediNestedScrollViewWithNestedScrollableTabsBloc>(
      create: (context) => FediNestedScrollViewWithNestedScrollableTabsBloc(
        nestedScrollControllerBloc:
            accountDetailsBloc.nestedScrollControllerBloc,
        tabController: tabController,
      ),
      child: ProxyProvider<IFediNestedScrollViewWithNestedScrollableTabsBloc,
          IFediNestedScrollViewBloc>(
        update: (context, value, previous) => value,
        child: ProxyProvider<IFediNestedScrollViewWithNestedScrollableTabsBloc,
            IScrollControllerBloc>(
          update: (context, value, previous) =>
              value.nestedScrollControllerBloc,
          child: FediNestedScrollViewWithNestedScrollableTabsWidget(
            onLongScrollUpTopOverlayWidget: null,
            topSliverScrollOffsetToShowWhiteStatusBar: 100,
            topSliverWidgets: [
              const _AccountDetailsNestedScrollViewHeader(),
            ],
            tabKeyPrefix: "AccountDetailsPage",
            tabBodyProviderBuilder:
                (BuildContext context, int index, Widget child) =>
                    buildBodyProvider(
              context: context,
              tab: _tabs[index],
              child: child,
            ),
            tabBodyContentBuilder: (BuildContext context, int index) =>
                buildTabBodyContent(
              context,
              _tabs[index],
            ),
            tabBodyOverlayBuilder: (BuildContext context, int index) =>
                buildTabBodyOverlay(
              _tabs[index],
            ),
            tabBarViewContainerBuilder: null,
          ),
        ),
      ),
    );
  }

  Widget buildBodyProvider({
    @required BuildContext context,
    @required AccountStatusesTab tab,
    @required Widget child,
  }) {
    return Builder(
      builder: (context) {
        switch (tab) {
          case AccountStatusesTab.withReplies:
            return _AccountDetailsPageBodyTabWithRepliesProvider(
              child: child,
            );

          case AccountStatusesTab.withoutReplies:
            return _AccountDetailsPageBodyTabWithoutRepliesProvider(
              child: child,
            );

            break;
          case AccountStatusesTab.media:
            return _AccountDetailsPageBodyTabMediaProvider(
              child: child,
            );
            break;
          case AccountStatusesTab.pinned:
            return _AccountDetailsPageBodyTabPinnedProvider(
              child: child,
            );

            break;
          default:
            throw "Invalid tab $tab";
        }
      },
    );
  }

  Widget buildTabBodyContent(
    BuildContext context,
    AccountStatusesTab tab,
  ) {
    var fediUiColorTheme = IFediUiColorTheme.of(context);

    switch (tab) {
      case AccountStatusesTab.withReplies:
      case AccountStatusesTab.withoutReplies:
      case AccountStatusesTab.pinned:
        return Container(
          color: fediUiColorTheme.white,
          child: const CollapsibleOwnerWidget(
            child: AccountStatusesTimelineWidget(),
          ),
        );
        break;
      case AccountStatusesTab.media:
        return Container(
          color: fediUiColorTheme.white,
          child: const AccountStatusesMediaWidget(),
        );
        break;
      default:
        throw "Invalid tab $tab";
    }
  }

  Widget buildTabBodyOverlay(AccountStatusesTab tab) {
    switch (tab) {
      case AccountStatusesTab.withReplies:
      case AccountStatusesTab.withoutReplies:
      case AccountStatusesTab.media:
        return const StatusListTapToLoadOverlayWidget();
        break;
      case AccountStatusesTab.pinned:
        return const SizedBox.shrink();
        break;
      default:
        throw "Invalid tab $tab";
    }
  }
}

class _AccountDetailsPageBodyTabWithRepliesProvider extends StatelessWidget {
  final Widget child;

  const _AccountDetailsPageBodyTabWithRepliesProvider({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);
    return AccountStatusesWithRepliesCachedListBloc.provideToContext(
      context,
      account: accountBloc.account,
      child: StatusCachedPaginationBloc.provideToContext(
        context,
        child: StatusCachedPaginationListWithNewItemsBloc.provideToContext(
          context,
          mergeNewItemsImmediately: true,
          child: child,
          mergeOwnStatusesImmediately: false,
        ),
      ),
    );
  }
}

class _AccountDetailsPageBodyTabWithoutRepliesProvider extends StatelessWidget {
  final Widget child;

  const _AccountDetailsPageBodyTabWithoutRepliesProvider({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);
    return AccountStatusesWithoutRepliesListBloc.provideToContext(
      context,
      account: accountBloc.account,
      child: StatusCachedPaginationBloc.provideToContext(
        context,
        child: StatusCachedPaginationListWithNewItemsBloc.provideToContext(
          context,
          mergeNewItemsImmediately: true,
          child: child,
          mergeOwnStatusesImmediately: false,
        ),
      ),
    );
  }
}

class _AccountDetailsPageBodyTabMediaProvider extends StatelessWidget {
  final Widget child;

  const _AccountDetailsPageBodyTabMediaProvider({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);

    return AccountStatusesMediaOnlyCachedListBloc.provideToContext(
      context,
      account: accountBloc.account,
      child: StatusCachedPaginationBloc.provideToContext(
        context,
        child: StatusCachedPaginationListWithNewItemsBloc.provideToContext(
          context,
          mergeNewItemsImmediately: true,
          child: child,
          mergeOwnStatusesImmediately: false,
        ),
      ),
    );
  }
}

class _AccountDetailsPageBodyTabPinnedProvider extends StatelessWidget {
  final Widget child;

  const _AccountDetailsPageBodyTabPinnedProvider({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);
    return AccountStatusesPinnedOnlyNetworkOnlyListBloc.provideToContext(
      context,
      account: accountBloc.account,
      child: StatusNetworkOnlyPaginationBloc.provideToContext(
        context,
        child: DisposableProvider<
            IPaginationListBloc<PaginationPage<IStatus>, IStatus>>(
          create: (context) =>
              PaginationListBloc<PaginationPage<IStatus>, IStatus>(
            paginationBloc:
                Provider.of<IPaginationBloc<PaginationPage<IStatus>, IStatus>>(
                    context,
                    listen: false),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _AccountDetailsNestedScrollViewHeader extends StatelessWidget {
  const _AccountDetailsNestedScrollViewHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FediDarkStatusBarStyleArea(
        child: ClipRRect(
          borderRadius: FediBorderRadius.topOnlyBigBorderRadius,
          child: Container(
            color: IFediUiColorTheme.of(context).offWhite,
            child: const FediListTile(
              isFirstInList: true,
              child: AccountWidget(
                onStatusesTapCallback: _onStatusesTapCallback,
                footer: _AccountDetailsPageTabIndicatorWidget(),
              ),
              // special hack to avoid 1px horizontal line on some devices
              oneSidePadding: FediSizes.bigPadding - 1,
//                    oneSidePadding: FediSizes.smallPadding - 1,
            ),
          ),
        ),
      );
}

void _onStatusesTapCallback(BuildContext context) {
  var scrollControllerBloc = IScrollControllerBloc.of(context, listen: false);
  scrollControllerBloc.scrollController.animateTo(
    MediaQuery.of(context).size.height / 2,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeOut,
  );
}

class _AccountDetailsPageTabIndicatorWidget extends StatelessWidget {
  const _AccountDetailsPageTabIndicatorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding:  EdgeInsets.only(top: 3.0, right: FediSizes.bigPadding),
      child: AccountTabTextTabIndicatorItemWidget(
        accountTabs: _tabs,
      ),
    );
  }
}

void goToAccountDetailsPage(BuildContext context, IAccount account) {
  Navigator.push(
    context,
    createAccountDetailsPageRoute(account),
  );
}

MaterialPageRoute createAccountDetailsPageRoute(IAccount account) {
  return MaterialPageRoute(
      builder: (context) => DisposableProvider<IAccountDetailsBloc>(
            create: (context) => AccountDetailsBloc(),
            child: DisposableProvider<IAccountBloc>(
              create: (context) => AccountBloc.createFromContext(context,
                  isNeedWatchLocalRepositoryForUpdates: true,
                  account: account,
                  isNeedRefreshFromNetworkOnInit: false,
                  isNeedWatchWebSocketsEvents: false,
                  isNeedPreFetchRelationship: true),
              child: const AccountDetailsPage(),
            ),
          ));
}
