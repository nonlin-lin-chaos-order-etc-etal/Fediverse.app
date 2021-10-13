import 'package:fedi/app/account/account_model.dart';
import 'package:fedi/app/account/my/endorsement/account_list/network_only/my_account_endorsement_account_list_network_only_list_bloc.dart';
import 'package:fedi/app/account/pagination/list/account_pagination_list_bloc_proxy_provider.dart';
import 'package:fedi/app/list/network_only/network_only_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MyAccountEndorsementAccountListNetworkOnlyListBlocProxyProvider
    extends StatelessWidget {
  final Widget child;

  MyAccountEndorsementAccountListNetworkOnlyListBlocProxyProvider({
    required this.child,
  });

  @override
  Widget build(BuildContext context) => ProxyProvider<
          IMyAccountEndorsementAccountListNetworkOnlyListBloc,
          INetworkOnlyListBloc<IAccount>>(
        update: (context, value, previous) => value,
        child: AccountPaginationListBlocProxyProvider(
          child: child,
        ),
      );
}
