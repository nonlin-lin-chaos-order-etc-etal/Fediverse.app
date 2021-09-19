import 'package:fedi/app/filter/filter_model.dart';
import 'package:fedi/app/instance/location/instance_location_model.dart';
import 'package:fedi/app/instance/remote/remote_instance_bloc.dart';
import 'package:fedi/app/status/status_model.dart';
import 'package:fedi/app/status/thread/status_thread_bloc_impl.dart';
import 'package:unifedi_api/unifedi_api.dart';
import 'package:flutter/widgets.dart';

class RemoteStatusThreadBloc extends StatusThreadBloc {
  final Uri instanceUri;

  RemoteStatusThreadBloc({
    required IStatus initialStatusToFetchThread,
    required IUnifediApiMediaAttachment? initialMediaAttachment,
    required IUnifediApiStatusService unifediApiStatusService,
    required this.instanceUri,
  }) : super(
          unifediApiStatusService: unifediApiStatusService,
          initialStatusToFetchThread: initialStatusToFetchThread,
          initialMediaAttachment: initialMediaAttachment,
        );

  static RemoteStatusThreadBloc createFromContext(
    BuildContext context, {
    required IStatus initialStatusToFetchThread,
    required IUnifediApiMediaAttachment? initialMediaAttachment,
  }) {
    var remoteInstanceBloc = IRemoteInstanceBloc.of(context, listen: false);

    var unifediApiStatusService =
        remoteInstanceBloc.unifediApiManager.createStatusService();

    var remoteStatusThreadBloc = RemoteStatusThreadBloc(
      initialStatusToFetchThread: initialStatusToFetchThread,
      initialMediaAttachment: initialMediaAttachment,
      unifediApiStatusService: unifediApiStatusService,
      instanceUri: remoteInstanceBloc.instanceUri,
    );

    remoteStatusThreadBloc.addDisposable(unifediApiStatusService);

    return remoteStatusThreadBloc;
  }

  @override
  Future<List<IFilter>> loadFilters() async => [];

  @override
  Stream<List<IFilter>> watchFilters() => Stream.value([]);

  @override
  // ignore: no-empty-block
  Future<void> onInitialStatusUpdated(
    IUnifediApiStatus updatedStartRemoteStatus,
    // ignore: no-empty-block
  ) async {
    // nothing
  }

  @override
  InstanceLocation get instanceLocation => InstanceLocation.remote;

  @override
  Uri get remoteInstanceUriOrNull => instanceUri;
}
