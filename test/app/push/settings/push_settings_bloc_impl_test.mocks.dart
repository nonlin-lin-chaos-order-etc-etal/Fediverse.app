// Mocks generated by Mockito 5.0.10 from annotations
// in fedi/test/app/push/settings/push_settings_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i5;

import 'package:base_fediverse_api/src/rest/rest_service.dart' as _i2;
import 'package:fedi/async/loading/init/async_init_loading_model.dart' as _i10;
import 'package:fedi/push/fcm/fcm_push_service.dart' as _i8;
import 'package:fedi/push/push_model.dart' as _i9;
import 'package:fedi/push/relay/push_relay_service.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pleroma_fediverse_api/src/pleroma/api/pleroma_api_service.dart'
    as _i6;
import 'package:pleroma_fediverse_api/src/pleroma/api/push/pleroma_api_push_model.dart'
    as _i3;
import 'package:pleroma_fediverse_api/src/pleroma/api/push/pleroma_api_push_service.dart'
    as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeIRestService extends _i1.Fake implements _i2.IRestService {}

class _FakeUnifediApiPushSubscription extends _i1.Fake
    implements _i3.UnifediApiPushSubscription {
  @override
  String toString() => super.toString();
}

/// A class which mocks [IUnifediApiPushSubscriptionService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIUnifediApiPushSubscriptionService extends _i1.Mock
    implements _i4.IUnifediApiPushSubscriptionService {
  MockIUnifediApiPushSubscriptionService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
          returnValue: _FakeIRestService()) as _i2.IRestService);
  @override
  _i5.Stream<_i6.UnifediApiState> get unifediApiStateStream =>
      (super.noSuchMethod(Invocation.getter(#unifediApiStateStream),
              returnValue: Stream<_i6.UnifediApiState>.empty())
          as _i5.Stream<_i6.UnifediApiState>);
  @override
  _i6.UnifediApiState get unifediApiState =>
      (super.noSuchMethod(Invocation.getter(#unifediApiState),
          returnValue: _i6.UnifediApiState.validAuth) as _i6.UnifediApiState);
  @override
  _i5.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i5.Stream<bool>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  _i5.Future<_i3.UnifediApiPushSubscription> subscribe(
          {String? endpointCallbackUrl,
          _i3.UnifediApiPushSubscribeData? data}) =>
      (super.noSuchMethod(
              Invocation.method(#subscribe, [],
                  {#endpointCallbackUrl: endpointCallbackUrl, #data: data}),
              returnValue: Future<_i3.UnifediApiPushSubscription>.value(
                  _FakeUnifediApiPushSubscription()))
          as _i5.Future<_i3.UnifediApiPushSubscription>);
  @override
  _i5.Future<_i3.UnifediApiPushSubscription> retrieveCurrentSubscription() =>
      (super.noSuchMethod(Invocation.method(#retrieveCurrentSubscription, []),
              returnValue: Future<_i3.UnifediApiPushSubscription>.value(
                  _FakeUnifediApiPushSubscription()))
          as _i5.Future<_i3.UnifediApiPushSubscription>);
  @override
  _i5.Future<dynamic> unsubscribe() =>
      (super.noSuchMethod(Invocation.method(#unsubscribe, []),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  _i5.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
}

/// A class which mocks [IPushRelayService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIPushRelayService extends _i1.Mock implements _i7.IPushRelayService {
  MockIPushRelayService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get pushRelayBaseUrl =>
      (super.noSuchMethod(Invocation.getter(#pushRelayBaseUrl), returnValue: '')
          as String);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  String createPushRelayEndPointUrl(
          {String? account, Uri? baseServerUrl, String? fcmDeviceToken}) =>
      (super.noSuchMethod(
          Invocation.method(#createPushRelayEndPointUrl, [], {
            #account: account,
            #baseServerUrl: baseServerUrl,
            #fcmDeviceToken: fcmDeviceToken
          }),
          returnValue: '') as String);
  @override
  _i5.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
}

/// A class which mocks [IFcmPushService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIFcmPushService extends _i1.Mock implements _i8.IFcmPushService {
  MockIFcmPushService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Stream<String> get deviceTokenStream =>
      (super.noSuchMethod(Invocation.getter(#deviceTokenStream),
          returnValue: Stream<String>.empty()) as _i5.Stream<String>);
  @override
  _i5.Stream<_i9.PushMessage> get messageStream =>
      (super.noSuchMethod(Invocation.getter(#messageStream),
              returnValue: Stream<_i9.PushMessage>.empty())
          as _i5.Stream<_i9.PushMessage>);
  @override
  _i5.Stream<_i10.AsyncInitLoadingState> get initLoadingStateStream =>
      (super.noSuchMethod(Invocation.getter(#initLoadingStateStream),
              returnValue: Stream<_i10.AsyncInitLoadingState>.empty())
          as _i5.Stream<_i10.AsyncInitLoadingState>);
  @override
  _i5.Stream<bool> get isLoadingStream =>
      (super.noSuchMethod(Invocation.getter(#isLoadingStream),
          returnValue: Stream<bool>.empty()) as _i5.Stream<bool>);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  _i5.Future<bool> askPermissions() =>
      (super.noSuchMethod(Invocation.method(#askPermissions, []),
          returnValue: Future<bool>.value(false)) as _i5.Future<bool>);
  @override
  void clearInitialMessage() =>
      super.noSuchMethod(Invocation.method(#clearInitialMessage, []),
          returnValueForMissingStub: null);
  @override
  _i5.Future<dynamic> performAsyncInit() =>
      (super.noSuchMethod(Invocation.method(#performAsyncInit, []),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
  @override
  _i5.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i5.Future<dynamic>);
}
