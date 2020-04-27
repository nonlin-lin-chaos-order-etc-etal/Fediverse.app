import 'package:fedi/refactored/app/account/my/my_account_bloc.dart';
import 'package:fedi/refactored/app/account/repository/account_repository.dart';
import 'package:fedi/refactored/app/auth/instance/current/current_auth_instance_bloc.dart';
import 'package:fedi/refactored/app/status/list/cached/status_cached_list_service.dart';
import 'package:fedi/refactored/app/status/repository/status_repository.dart';
import 'package:fedi/refactored/app/timeline/home/home_timeline_service_impl.dart';
import 'package:fedi/refactored/app/timeline/home/home_timeline_tab_bloc.dart';
import 'package:fedi/refactored/app/timeline/local_preferences/timeline_local_preferences_bloc.dart';
import 'package:fedi/refactored/app/timeline/tab/timeline_tab_bloc_impl.dart';
import 'package:fedi/refactored/app/timeline/tab/timeline_tab_model.dart';
import 'package:fedi/refactored/pleroma/account/pleroma_account_service.dart';

import 'package:fedi/refactored/pleroma/timeline/pleroma_timeline_service.dart';
import 'package:fedi/refactored/pleroma/websockets/pleroma_websockets_service.dart';
import 'package:flutter/widgets.dart';

import 'home_timeline_websockets_handler_impl.dart';

class HomeTimelineTabBloc extends TimelineTabBloc
    implements IHomeTimelineTabBloc {
  final IPleromaTimelineService pleromaTimelineService;
  final IPleromaAccountService pleromaAccountService;
  final IStatusRepository statusRepository;
  final IAccountRepository accountRepository;
  final ICurrentAuthInstanceBloc currentInstanceBloc;
  final ITimelineLocalPreferencesBloc timelineLocalPreferencesBloc;
  final IMyAccountBloc myAccountBloc;
  final IPleromaWebSocketsService
  pleromaWebSocketsService;

  HomeTimelineTabBloc(
      {@required this.pleromaTimelineService,
      @required this.pleromaAccountService,
      @required this.statusRepository,
      @required this.accountRepository,
      @required this.currentInstanceBloc,
      @required this.myAccountBloc,
      @required this.timelineLocalPreferencesBloc,
      @required this.pleromaWebSocketsService})
      : super(tab: TimelineTab.home) {
    addDisposable(
        disposable: HomeTimelineStatusWebSocketsHandler(
            pleromaWebSocketsService:
                pleromaWebSocketsService,
            statusRepository: statusRepository));
  }

  @override
  IStatusCachedListService createListService() => HomeTimelineService(
      pleromaTimelineService: pleromaTimelineService,
      statusRepository: statusRepository,
      timelineLocalPreferencesBloc: timelineLocalPreferencesBloc,
      currentInstanceBloc: currentInstanceBloc,
      homeAccount: myAccountBloc.account,
      accountRepository: accountRepository,
      pleromaAccountService: pleromaAccountService);
}
