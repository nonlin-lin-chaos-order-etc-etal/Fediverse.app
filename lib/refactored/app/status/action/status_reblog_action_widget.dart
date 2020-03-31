import 'package:easy_localization/easy_localization.dart';
import 'package:fedi/refactored/app/async/async_button_widget.dart';
import 'package:fedi/refactored/app/status/reblog/status_reblog_account_list_page.dart';
import 'package:fedi/refactored/app/status/status_bloc.dart';
import 'package:fedi/refactored/stream_builder/initial_data_stream_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatusReblogActionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var statusBloc = IStatusBloc.of(context, listen: true);

    return Row(
      children: <Widget>[
        InitialDataStreamBuilder<bool>(
            stream: statusBloc.rebloggedStream,
            initialData: statusBloc.reblogged,
            builder: (context, snapshot) {
              var reblogged = snapshot.data;

              return AsyncButtonWidget(
                  builder: (context, onPressed) => IconButton(
                        color: reblogged ? Colors.blue : Colors.black,
//                        icon: Image(
//                          height: 20,
//                          width: 20,
//                          color: Colors.black,
//                          image: AssetImage("assets/images/repost.png"),
//                        ),
                        icon: Icon(Icons.repeat),
                        tooltip: AppLocalizations.of(context)
                            .tr("timeline.status.cell.tooltip.repost"),
                        onPressed: onPressed,
                      ),
                  asyncButtonAction: statusBloc.requestToggleReblog);
            }),
        InitialDataStreamBuilder<int>(
            stream: statusBloc.reblogsReblogPlusOriginalCountStream,
            initialData: statusBloc.reblogsReblogPlusOriginalCount,
            builder: (context, snapshot) {
              var reblogsCount = snapshot.data;

              return GestureDetector(
                  onTap: () {
                    goToStatusReblogAccountListPage(context, statusBloc.status);
                  },
                  child: Text("$reblogsCount"));
            }),
      ],
    );
  }
}
