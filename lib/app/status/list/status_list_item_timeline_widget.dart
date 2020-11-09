import 'package:fedi/app/status/account/status_account_widget.dart';
import 'package:fedi/app/status/action/status_actions_list_widget.dart';
import 'package:fedi/app/status/action/status_show_this_thread_action_widget.dart';
import 'package:fedi/app/status/body/status_body_bloc.dart';
import 'package:fedi/app/status/body/status_body_bloc_impl.dart';
import 'package:fedi/app/status/body/status_body_widget.dart';
import 'package:fedi/app/status/created_at/status_created_at_widget.dart';
import 'package:fedi/app/status/deleted/status_deleted_overlay_widget.dart';
import 'package:fedi/app/status/emoji_reaction/status_emoji_reaction_list_widget.dart';
import 'package:fedi/app/status/list/status_list_item_timeline_bloc.dart';
import 'package:fedi/app/status/reblog/status_reblog_header_widget.dart';
import 'package:fedi/app/status/reply/status_reply_loader_bloc.dart';
import 'package:fedi/app/status/reply/status_reply_loader_bloc_impl.dart';
import 'package:fedi/app/status/reply/status_reply_sub_header_widget.dart';
import 'package:fedi/app/status/reply/status_reply_widget.dart';
import 'package:fedi/app/status/status_bloc.dart';
import 'package:fedi/app/status/status_bloc_impl.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/status/visibility/status_visibility_icon_widget.dart';
import 'package:fedi/app/ui/divider/fedi_ultra_light_grey_divider.dart';
import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:fedi/app/ui/theme/fedi_ui_theme_model.dart';
import 'package:fedi/collapsible/collapsible_bloc.dart';
import 'package:fedi/disposable/disposable.dart';
import 'package:fedi/disposable/disposable_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

var _logger = Logger("status_list_item_timeline_widget.dart");

class StatusListItemTimelineWidget extends StatelessWidget {
  const StatusListItemTimelineWidget();

  @override
  Widget build(BuildContext context) {
    var statusListItemTimelineBloc = IStatusListItemTimelineBloc.of(context);

    var status = statusListItemTimelineBloc.status;

    if (status == null) {
      _logger.warning(() => "status is null");
      return const SizedBox.shrink();
    }

    _logger.finest(() => "build status?.remoteId ${status.remoteId}");

    Widget child;
    if (statusListItemTimelineBloc
        .isReplyAndIsFirstReplyAndDisplayReplyToStatus) {
      child = Column(
        children: [
          const _StatusListItemTimelineReplyToStatusWidget(),
          const FediUltraLightGreyDivider(),
          const _StatusListItemTimelineOriginalWidget(),
        ],
      );
    } else {
      child = const _StatusListItemTimelineOriginalWidget();
    }
    return child;
  }
}

class _StatusListItemTimelineOriginalWidget extends StatelessWidget {
  const _StatusListItemTimelineOriginalWidget();

  @override
  Widget build(BuildContext context) {
    return DisposableProxyProvider<IStatusListItemTimelineBloc, IStatusBloc>(
      update: (context, statusListItemTimelineBloc, oldValue) =>
          _createStatusBloc(
        context: context,
        status: statusListItemTimelineBloc.status,
        collapsible: statusListItemTimelineBloc.collapsible,
      ),
      child: Builder(
        builder: (context) {
          var statusBloc = IStatusBloc.of(context);
          return buildDeletedStreamBuilderOverlay(
            statusBloc: statusBloc,
            child: _StatusListItemTimelineOriginalBodyWidget(),
          );
        },
      ),
    );
  }

  Widget buildDeletedStreamBuilderOverlay({
    @required Widget child,
    @required IStatusBloc statusBloc,
  }) {
    return StreamBuilder<bool>(
      stream: statusBloc.deletedStream.distinct(),
      builder: (context, snapshot) {
        var deleted = snapshot.data ?? false;

        if (deleted == true) {
          return Stack(
            children: [
              Positioned.fill(
                child: const StatusDeletedOverlayWidget(),
              ),
              child,
            ],
          );
        } else {
          return child;
        }
      },
    );
  }
}

class _StatusListItemTimelineOriginalBodyWidget extends StatelessWidget {
  const _StatusListItemTimelineOriginalBodyWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statusListItemTimelineBloc = IStatusListItemTimelineBloc.of(context);
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _onStatusListItemClick(context);
          },
          child: Column(
            children: [
              if (statusListItemTimelineBloc.isHaveReblog)
                const StatusReblogHeaderWidget(),
              if (statusListItemTimelineBloc.displayAccountHeader)
                const _StatusListItemTimelineStatusHeaderWidget(),
              if (statusListItemTimelineBloc.isReply)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      FediSizes.bigPadding + 52.0,
                      FediSizes.smallPadding,
                      FediSizes.bigPadding,
                      0.0),
                  child:
                      _StatusListItemTimelineOriginalBodyReplySubHeaderWidget(),
                ),
              buildBody(context),
              const StatusEmojiReactionListWidget(),
            ],
          ),
        ),
        if (statusListItemTimelineBloc.isDisplayActionsAndNotFirstReply)
          const StatusActionsListWidget(),
        if (statusListItemTimelineBloc.isReplyAndFirstReplyOrDisplayAllReplies)
          Column(
            children: [
              const FediUltraLightGreyDivider(),
              const StatusShowThisThreadActionWidget(),
            ],
          ),
      ],
    );
  }
}

class _StatusListItemTimelineOriginalBodyReplySubHeaderWidget
    extends StatelessWidget {
  const _StatusListItemTimelineOriginalBodyReplySubHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statusListItemTimelineBloc = IStatusListItemTimelineBloc.of(context);
    return StatusReplySubHeaderWidget(
      accountCallback: statusListItemTimelineBloc.accountMentionCallback,
    );
  }
}

class _StatusListItemTimelineReplyToStatusWidget extends StatelessWidget {
  const _StatusListItemTimelineReplyToStatusWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var statusListItemTimelineBloc = IStatusListItemTimelineBloc.of(context);
    return DisposableProxyProvider<IStatus, IStatusReplyLoaderBloc>(
      update: (context, value, previous) {
        var statusReplyLoaderBloc =
            StatusReplyLoaderBloc.createFromContext(context, value);
        // don't await
        statusReplyLoaderBloc.performAsyncInit();
        return statusReplyLoaderBloc;
      },
      child: StatusReplyWidget(
        collapsible: statusListItemTimelineBloc.collapsible,
      ),
    );
  }
}

class _StatusListItemTimelineStatusHeaderWidget extends StatelessWidget {
  const _StatusListItemTimelineStatusHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var status = Provider.of<IStatus>(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(FediSizes.bigPadding,
          FediSizes.bigPadding, FediSizes.bigPadding, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Flexible(
            child: StatusAccountWidget(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                StatusVisibilityIconWidget.mapVisibilityToIconData(
                  status.visibility,
                ),
                size: FediSizes.mediumIconSize,
                color: IFediUiColorTheme.of(context).darkGrey,
              ),
              const Padding(
                padding: EdgeInsets.only(left: FediSizes.smallPadding),
                child: StatusCreatedAtWidget(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

StatusBloc _createStatusBloc({
  @required BuildContext context,
  @required IStatus status,
  @required bool collapsible,
}) {
  var statusBloc = StatusBloc.createFromContext(context, status);

  if (collapsible) {
    var collapsibleBloc = ICollapsibleBloc.of(context, listen: false);
    collapsibleBloc.addVisibleItem(statusBloc);
    statusBloc.addDisposable(disposable: CustomDisposable(() async {
      await collapsibleBloc.removeVisibleItem(statusBloc);
    }));
  }

  return statusBloc;
}

Widget buildBody(BuildContext context) {
  var statusListItemTimelineBloc = IStatusListItemTimelineBloc.of(context);
  if (statusListItemTimelineBloc.isReplyAndNotDisplayReplyOrFirstReply) {
    return Padding(
      padding: EdgeInsets.fromLTRB(68.0 - FediSizes.bigPadding,
          FediSizes.smallPadding, 0.0, FediSizes.bigPadding),
      child: const _StatusListItemTimelineOriginalBodyContentWidget(),
    );
  } else {
    return Padding(
      padding: EdgeInsets.only(top: FediSizes.smallPadding),
      child: const _StatusListItemTimelineOriginalBodyContentWidget(),
    );
  }
}

class _StatusListItemTimelineOriginalBodyContentWidget extends StatelessWidget {
  const _StatusListItemTimelineOriginalBodyContentWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      DisposableProxyProvider<IStatusListItemTimelineBloc, IStatusBodyBloc>(
        update: (context, value, previous) => StatusBodyBloc(
          collapsible: value.collapsible,
          initialMediaAttachment: value.initialMediaAttachment,
        ),
        child: const StatusBodyWidget(),
      );
}

void _onStatusListItemClick(BuildContext context) {
  var statusListItemTimelineBloc =
      IStatusListItemTimelineBloc.of(context, listen: false);

  if (statusListItemTimelineBloc.statusCallback != null) {
    statusListItemTimelineBloc.statusCallback(
        context, statusListItemTimelineBloc.status);
  }
}
