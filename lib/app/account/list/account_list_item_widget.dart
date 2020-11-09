import 'package:fedi/app/account/account_bloc.dart';
import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/acct/account_acct_widget.dart';
import 'package:fedi/app/account/avatar/account_avatar_widget.dart';
import 'package:fedi/app/account/display_name/account_display_name_widget.dart';
import 'package:fedi/app/ui/fedi_padding.dart';
import 'package:fedi/app/ui/fedi_sizes.dart';
import 'package:fedi/app/ui/theme/fedi_ui_theme_model.dart';
import 'package:fedi/app/ui/spacer/fedi_small_horizontal_spacer.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

var _logger = Logger("account_list_item_widget.dart");

class AccountListItemWidget extends StatelessWidget {
  final AccountCallback accountSelectedCallback;
  final List<Widget> accountActions;

  const AccountListItemWidget({
    @required this.accountSelectedCallback,
    this.accountActions,
  });

  @override
  Widget build(BuildContext context) {
    var accountBloc = IAccountBloc.of(context);
    _logger.finest(() => "build ${accountBloc.acct}");

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (accountSelectedCallback != null) {
          accountSelectedCallback(context, accountBloc.account);
        }
      },
      child: Padding(
        padding: FediPadding.allBigPadding,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const Expanded(
              child: _AccountListItemBodyWidget(),
            ),
            if (accountActions?.isNotEmpty == true) ...accountActions
          ],
        ),
      ),
    );
  }
}

class _AccountListItemBodyWidget extends StatelessWidget {
  const _AccountListItemBodyWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const AccountAvatarWidget(
          imageSize: FediSizes.accountAvatarDefaultSize,
          progressSize: FediSizes.accountAvatarProgressDefaultSize,
        ),
        const FediSmallHorizontalSpacer(),
        Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AccountDisplayNameWidget(
                  textStyle: IFediUiTextTheme
                      .of(context)
                      .bigShortBoldDarkGrey
                      .copyWith(height: 1),
                ),
                AccountAcctWidget(
                  textStyle: IFediUiTextTheme
                      .of(context)
                      .mediumShortDarkGrey,
                ),
              ],
            ))
      ],
    );
  }
}
