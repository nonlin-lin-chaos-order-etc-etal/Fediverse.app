import 'dart:async';

import 'package:fedi/generated/l10n.dart';
import 'package:fedi/app/form/form_bool_field_form_row_widget.dart';
import 'package:fedi/app/push/subscription_settings/push_subscription_settings_bloc.dart';
import 'package:fedi/app/ui/notification_overlay/error_fedi_notification_overlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PushSubscriptionSettingsWidget extends StatefulWidget {
  @override
  _PushSubscriptionSettingsWidgetState createState() =>
      _PushSubscriptionSettingsWidgetState();

  const PushSubscriptionSettingsWidget();
}

class _PushSubscriptionSettingsWidgetState
    extends State<PushSubscriptionSettingsWidget> {
  StreamSubscription failedToUpdateSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var settingsBloc = IPushSubscriptionSettingsBloc.of(context, listen: false);

    failedToUpdateSubscription = settingsBloc.failedToUpdateStream.listen((_) {
      showErrorFediNotificationOverlay(
          context: context,
          contentText: "Failed to change subscription settings",
          titleText: null);
    });
  }

  @override
  void dispose() {
    super.dispose();

    failedToUpdateSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var settingsBloc = IPushSubscriptionSettingsBloc.of(context, listen: true);

    return ListView(
      children: [
        FormBoolFieldFormRowWidget(
          label: S.of(context).app_notification_push_settings_field_favourites_label,
          field: settingsBloc.favouriteFieldBloc,
        ),
        FormBoolFieldFormRowWidget(
          label: S.of(context).app_notification_push_settings_field_follows_label,
          field: settingsBloc.followFieldBloc,
        ),
        FormBoolFieldFormRowWidget(
          label: S.of(context).app_notification_push_settings_field_mentions_label,
          field: settingsBloc.mentionFieldBloc,
        ),
        FormBoolFieldFormRowWidget(
          label: S.of(context).app_notification_push_settings_field_reblogs_label,
          field: settingsBloc.reblogFieldBloc,
        ),
        FormBoolFieldFormRowWidget(
          label: S.of(context).app_notification_push_settings_field_polls_label,
          field: settingsBloc.pollFieldBloc,
        ),
        FormBoolFieldFormRowWidget(
          label: S.of(context).app_notification_push_settings_field_chat_label,
          field: settingsBloc.chatFieldBloc,
        ),
      ],
    );
  }
}
