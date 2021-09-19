import 'package:collection/collection.dart';
import 'package:fedi/app/account/my/domain_block/list/network_only/my_account_domain_block_network_only_pagination_bloc.dart';
import 'package:fedi/app/account/my/domain_block/my_account_domain_block_model.dart';
import 'package:fedi/app/list/network_only/network_only_list_bloc.dart';
import 'package:fedi/app/pagination/network_only/network_only_pleroma_pagination_bloc_impl.dart';
import 'package:fedi/app/pagination/settings/pagination_settings_bloc.dart';
import 'package:fedi/connection/connection_service.dart';
import 'package:fedi/pagination/pagination_model.dart';
import 'package:unifedi_api/unifedi_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class MyAccountDomainBlockNetworkOnlyPaginationBloc
    extends NetworkOnlyPleromaPaginationBloc<DomainBlock>
    implements IMyAccountDomainBlockNetworkOnlyPaginationBloc {
  final INetworkOnlyListBloc<DomainBlock> listBloc;

  MyAccountDomainBlockNetworkOnlyPaginationBloc({
    required this.listBloc,
    required IPaginationSettingsBloc paginationSettingsBloc,
    required int? maximumCachedPagesCount,
    required IConnectionService connectionService,
  }) : super(
          connectionService: connectionService,
          maximumCachedPagesCount: maximumCachedPagesCount,
          paginationSettingsBloc: paginationSettingsBloc,
        );

  @override
  IUnifediApiService get unifediApi => listBloc.unifediApi;

  static MyAccountDomainBlockNetworkOnlyPaginationBloc createFromContext(
    BuildContext context, {
    int? maximumCachedPagesCount,
  }) =>
      MyAccountDomainBlockNetworkOnlyPaginationBloc(
        connectionService: Provider.of<IConnectionService>(
          context,
          listen: false,
        ),
        maximumCachedPagesCount: maximumCachedPagesCount,
        listBloc: Provider.of<INetworkOnlyListBloc<DomainBlock>>(
          context,
          listen: false,
        ),
        paginationSettingsBloc: IPaginationSettingsBloc.of(
          context,
          listen: false,
        ),
      );

  @override
  Future<List<DomainBlock>> loadItemsFromRemoteForPage({
    required int pageIndex,
    required int? itemsCountPerPage,
    required PaginationPage<DomainBlock>? olderPage,
    required PaginationPage<DomainBlock>? newerPage,
  }) {
    return listBloc.loadItemsFromRemoteForPage(
      itemsCountPerPage: itemsCountPerPage,
      maxId: newerPage?.items.lastOrNull?.domain,
      minId: olderPage?.items.firstOrNull?.domain,
      pageIndex: pageIndex,
    );
  }
}
