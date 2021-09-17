// Mocks generated by Mockito 5.0.10 from annotations
// in fedi/test/app/account/account_bloc_impl_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i7;

import 'package:base_fediverse_api/src/rest/rest_service.dart' as _i2;
import 'package:base_fediverse_api/src/web_sockets/channel/web_sockets_channel.dart'
    as _i5;
import 'package:base_fediverse_api/src/web_sockets/web_sockets_model.dart'
    as _i4;
import 'package:easy_dispose/src/composite_disposable.dart' as _i13;
import 'package:easy_dispose/src/disposable.dart' as _i14;
import 'package:mockito/mockito.dart' as _i1;
import 'package:pleroma_fediverse_api/src/pleroma/api/account/auth/pleroma_api_auth_account_service.dart'
    as _i6;
import 'package:pleroma_fediverse_api/src/pleroma/api/account/pleroma_api_account_model.dart'
    as _i3;
import 'package:pleroma_fediverse_api/src/pleroma/api/list/pleroma_api_list_model.dart'
    as _i10;
import 'package:pleroma_fediverse_api/src/pleroma/api/pagination/pleroma_api_pagination_model.dart'
    as _i9;
import 'package:pleroma_fediverse_api/src/pleroma/api/pleroma_api_service.dart'
    as _i8;
import 'package:pleroma_fediverse_api/src/pleroma/api/status/pleroma_api_status_model.dart'
    as _i11;
import 'package:pleroma_fediverse_api/src/pleroma/api/web_sockets/pleroma_api_web_sockets_model.dart'
    as _i15;
import 'package:pleroma_fediverse_api/src/pleroma/api/web_sockets/pleroma_api_web_sockets_service.dart'
    as _i12;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeIRestService extends _i1.Fake implements _i2.IRestService {}

class _FakeIUnifediApiAccountRelationship extends _i1.Fake
    implements _i3.IUnifediApiAccountRelationship {}

class _FakeIUnifediApiAccount extends _i1.Fake
    implements _i3.IUnifediApiAccount {}

class _FakeIWebSocketsChannel<T extends _i4.WebSocketsEvent> extends _i1.Fake
    implements _i5.IWebSocketsChannel<T> {}

/// A class which mocks [IUnifediApiAccountService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIUnifediApiAccountService extends _i1.Mock
    implements _i6.IUnifediApiAccountService {
  MockIUnifediApiAccountService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.IRestService get restService =>
      (super.noSuchMethod(Invocation.getter(#restService),
          returnValue: _FakeIRestService()) as _i2.IRestService);
  @override
  _i7.Stream<_i8.UnifediApiState> get unifediApiStateStream =>
      (super.noSuchMethod(Invocation.getter(#unifediApiStateStream),
              returnValue: Stream<_i8.UnifediApiState>.empty())
          as _i7.Stream<_i8.UnifediApiState>);
  @override
  _i8.UnifediApiState get unifediApiState =>
      (super.noSuchMethod(Invocation.getter(#unifediApiState),
          returnValue: _i8.UnifediApiState.validAuth) as _i8.UnifediApiState);
  @override
  _i7.Stream<bool> get isConnectedStream =>
      (super.noSuchMethod(Invocation.getter(#isConnectedStream),
          returnValue: Stream<bool>.empty()) as _i7.Stream<bool>);
  @override
  bool get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected), returnValue: false)
          as bool);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  bool get isPleroma =>
      (super.noSuchMethod(Invocation.getter(#isPleroma), returnValue: false)
          as bool);
  @override
  bool get isMastodon =>
      (super.noSuchMethod(Invocation.getter(#isMastodon), returnValue: false)
          as bool);
  @override
  _i7.Future<List<_i3.IUnifediApiAccountRelationship>>
      getRelationshipWithAccounts({List<String>? remoteAccountIds}) =>
          (super.noSuchMethod(
                  Invocation.method(#getRelationshipWithAccounts, [],
                      {#remoteAccountIds: remoteAccountIds}),
                  returnValue:
                      Future<List<_i3.IUnifediApiAccountRelationship>>.value(
                          <_i3.IUnifediApiAccountRelationship>[]))
              as _i7.Future<List<_i3.IUnifediApiAccountRelationship>>);
  @override
  _i7.Future<List<_i3.IUnifediApiAccount>> search(
          {String? query,
          bool? resolve,
          bool? following,
          _i9.IUnifediApiPagination? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#search, [], {
                #query: query,
                #resolve: resolve,
                #following: following,
                #pagination: pagination
              }),
              returnValue: Future<List<_i3.IUnifediApiAccount>>.value(
                  <_i3.IUnifediApiAccount>[]))
          as _i7.Future<List<_i3.IUnifediApiAccount>>);
  @override
  _i7.Future<List<_i10.IUnifediApiList>> getListsWithAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #getListsWithAccount, [], {#accountRemoteId: accountRemoteId}),
          returnValue: Future<List<_i10.IUnifediApiList>>.value(
              <_i10.IUnifediApiList>[])) as _i7
          .Future<List<_i10.IUnifediApiList>>);
  @override
  _i7.Future<List<_i3.IUnifediApiAccountIdentityProof>>
      getAccountIdentifyProofs({String? accountRemoteId}) => (super
              .noSuchMethod(
                  Invocation.method(#getAccountIdentifyProofs, [], {
                    #accountRemoteId: accountRemoteId
                  }),
                  returnValue:
                      Future<List<_i3.IUnifediApiAccountIdentityProof>>.value(
                          <_i3.IUnifediApiAccountIdentityProof>[]))
          as _i7.Future<List<_i3.IUnifediApiAccountIdentityProof>>);
  @override
  _i7.Future<_i3.IUnifediApiAccountRelationship> followAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #followAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i3.IUnifediApiAccountRelationship>.value(
                  _FakeIUnifediApiAccountRelationship()))
          as _i7.Future<_i3.IUnifediApiAccountRelationship>);
  @override
  _i7.Future<_i3.IUnifediApiAccountRelationship> unFollowAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unFollowAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i3.IUnifediApiAccountRelationship>.value(
                  _FakeIUnifediApiAccountRelationship()))
          as _i7.Future<_i3.IUnifediApiAccountRelationship>);
  @override
  _i7.Future<_i3.IUnifediApiAccountRelationship> subscribeAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #subscribeAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i3.IUnifediApiAccountRelationship>.value(
                  _FakeIUnifediApiAccountRelationship()))
          as _i7.Future<_i3.IUnifediApiAccountRelationship>);
  @override
  _i7.Future<_i3.IUnifediApiAccountRelationship> unSubscribeAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unSubscribeAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i3.IUnifediApiAccountRelationship>.value(
                  _FakeIUnifediApiAccountRelationship()))
          as _i7.Future<_i3.IUnifediApiAccountRelationship>);
  @override
  _i7.Future<_i3.IUnifediApiAccountRelationship> pinAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #pinAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i3.IUnifediApiAccountRelationship>.value(
                  _FakeIUnifediApiAccountRelationship()))
          as _i7.Future<_i3.IUnifediApiAccountRelationship>);
  @override
  _i7.Future<_i3.IUnifediApiAccountRelationship> unPinAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unPinAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i3.IUnifediApiAccountRelationship>.value(
                  _FakeIUnifediApiAccountRelationship()))
          as _i7.Future<_i3.IUnifediApiAccountRelationship>);
  @override
  _i7.Future<_i3.IUnifediApiAccountRelationship> muteAccount(
          {String? accountRemoteId,
          bool? notifications,
          int? expireDurationInSeconds}) =>
      (super.noSuchMethod(
              Invocation.method(#muteAccount, [], {
                #accountRemoteId: accountRemoteId,
                #notifications: notifications,
                #expireDurationInSeconds: expireDurationInSeconds
              }),
              returnValue: Future<_i3.IUnifediApiAccountRelationship>.value(
                  _FakeIUnifediApiAccountRelationship()))
          as _i7.Future<_i3.IUnifediApiAccountRelationship>);
  @override
  _i7.Future<_i3.IUnifediApiAccountRelationship> unMuteAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unMuteAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i3.IUnifediApiAccountRelationship>.value(
                  _FakeIUnifediApiAccountRelationship()))
          as _i7.Future<_i3.IUnifediApiAccountRelationship>);
  @override
  _i7.Future<_i3.IUnifediApiAccountRelationship> blockAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #blockAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i3.IUnifediApiAccountRelationship>.value(
                  _FakeIUnifediApiAccountRelationship()))
          as _i7.Future<_i3.IUnifediApiAccountRelationship>);
  @override
  _i7.Future<_i3.IUnifediApiAccountRelationship> unBlockAccount(
          {String? accountRemoteId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #unBlockAccount, [], {#accountRemoteId: accountRemoteId}),
              returnValue: Future<_i3.IUnifediApiAccountRelationship>.value(
                  _FakeIUnifediApiAccountRelationship()))
          as _i7.Future<_i3.IUnifediApiAccountRelationship>);
  @override
  _i7.Future<dynamic> blockDomain({String? domain}) => (super.noSuchMethod(
      Invocation.method(#blockDomain, [], {#domain: domain}),
      returnValue: Future<dynamic>.value()) as _i7.Future<dynamic>);
  @override
  _i7.Future<dynamic> unBlockDomain({String? domain}) => (super.noSuchMethod(
      Invocation.method(#unBlockDomain, [], {#domain: domain}),
      returnValue: Future<dynamic>.value()) as _i7.Future<dynamic>);
  @override
  _i7.Future<dynamic> reportAccount(
          {_i3.IUnifediApiAccountReportRequest? reportRequest}) =>
      (super.noSuchMethod(
          Invocation.method(
              #reportAccount, [], {#reportRequest: reportRequest}),
          returnValue: Future<dynamic>.value()) as _i7.Future<dynamic>);
  @override
  _i7.Future<List<_i3.IUnifediApiAccount>> getAccountFollowings(
          {String? accountRemoteId,
          bool? withRelationship,
          _i9.IUnifediApiPagination? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountFollowings, [], {
                #accountRemoteId: accountRemoteId,
                #withRelationship: withRelationship,
                #pagination: pagination
              }),
              returnValue: Future<List<_i3.IUnifediApiAccount>>.value(
                  <_i3.IUnifediApiAccount>[]))
          as _i7.Future<List<_i3.IUnifediApiAccount>>);
  @override
  _i7.Future<List<_i3.IUnifediApiAccount>> getAccountFollowers(
          {String? accountRemoteId,
          bool? withRelationship,
          _i9.IUnifediApiPagination? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountFollowers, [], {
                #accountRemoteId: accountRemoteId,
                #withRelationship: withRelationship,
                #pagination: pagination
              }),
              returnValue: Future<List<_i3.IUnifediApiAccount>>.value(
                  <_i3.IUnifediApiAccount>[]))
          as _i7.Future<List<_i3.IUnifediApiAccount>>);
  @override
  _i7.Future<List<_i11.IUnifediApiStatus>> getAccountStatuses(
          {String? accountRemoteId,
          String? tagged,
          bool? pinned,
          bool? excludeReplies,
          bool? excludeReblogs,
          List<String>? excludeVisibilities,
          bool? withMuted,
          bool? onlyWithMedia,
          _i9.IUnifediApiPagination? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountStatuses, [], {
                #accountRemoteId: accountRemoteId,
                #tagged: tagged,
                #pinned: pinned,
                #excludeReplies: excludeReplies,
                #excludeReblogs: excludeReblogs,
                #excludeVisibilities: excludeVisibilities,
                #withMuted: withMuted,
                #onlyWithMedia: onlyWithMedia,
                #pagination: pagination
              }),
              returnValue: Future<List<_i11.IUnifediApiStatus>>.value(
                  <_i11.IUnifediApiStatus>[]))
          as _i7.Future<List<_i11.IUnifediApiStatus>>);
  @override
  _i7.Future<List<_i11.IUnifediApiStatus>> getAccountFavouritedStatuses(
          {String? accountRemoteId,
          _i9.IUnifediApiPagination? pagination}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountFavouritedStatuses, [],
                  {#accountRemoteId: accountRemoteId, #pagination: pagination}),
              returnValue: Future<List<_i11.IUnifediApiStatus>>.value(
                  <_i11.IUnifediApiStatus>[]))
          as _i7.Future<List<_i11.IUnifediApiStatus>>);
  @override
  _i7.Future<_i3.IUnifediApiAccount> getAccount(
          {String? accountRemoteId, bool? withRelationship}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccount, [], {
                #accountRemoteId: accountRemoteId,
                #withRelationship: withRelationship
              }),
              returnValue: Future<_i3.IUnifediApiAccount>.value(
                  _FakeIUnifediApiAccount()))
          as _i7.Future<_i3.IUnifediApiAccount>);
  @override
  _i7.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i7.Future<dynamic>);
}

/// A class which mocks [IUnifediApiWebSocketsService].
///
/// See the documentation for Mockito's code generation for more information.
class MockIUnifediApiWebSocketsService extends _i1.Mock
    implements _i12.IUnifediApiWebSocketsService {
  MockIUnifediApiWebSocketsService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i13.DisposeOrder get disposeOrder =>
      (super.noSuchMethod(Invocation.getter(#disposeOrder),
          returnValue: _i13.DisposeOrder.lifo) as _i13.DisposeOrder);
  @override
  bool get catchExceptions => (super
          .noSuchMethod(Invocation.getter(#catchExceptions), returnValue: false)
      as bool);
  @override
  List<_i14.IDisposable> get disposables =>
      (super.noSuchMethod(Invocation.getter(#disposables),
          returnValue: <_i14.IDisposable>[]) as List<_i14.IDisposable>);
  @override
  bool get isDisposed =>
      (super.noSuchMethod(Invocation.getter(#isDisposed), returnValue: false)
          as bool);
  @override
  set isDisposed(bool? _isDisposed) =>
      super.noSuchMethod(Invocation.setter(#isDisposed, _isDisposed),
          returnValueForMissingStub: null);
  @override
  _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent> getMyAccountChannel(
          {bool? notification, bool? chat}) =>
      (super.noSuchMethod(
              Invocation.method(#getMyAccountChannel, [],
                  {#notification: notification, #chat: chat}),
              returnValue:
                  _FakeIWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>())
          as _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>);
  @override
  _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent> getAccountChannel(
          {String? accountId, bool? notification}) =>
      (super.noSuchMethod(
              Invocation.method(#getAccountChannel, [],
                  {#accountId: accountId, #notification: notification}),
              returnValue:
                  _FakeIWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>())
          as _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>);
  @override
  _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent> getDirectChannel(
          {String? accountId}) =>
      (super.noSuchMethod(
              Invocation.method(#getDirectChannel, [], {#accountId: accountId}),
              returnValue:
                  _FakeIWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>())
          as _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>);
  @override
  _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent> getPublicChannel(
          {bool? onlyLocal,
          bool? onlyRemote,
          bool? onlyMedia,
          String? onlyFromInstance}) =>
      (super.noSuchMethod(
              Invocation.method(#getPublicChannel, [], {
                #onlyLocal: onlyLocal,
                #onlyRemote: onlyRemote,
                #onlyMedia: onlyMedia,
                #onlyFromInstance: onlyFromInstance
              }),
              returnValue:
                  _FakeIWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>())
          as _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>);
  @override
  _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent> getHashtagChannel(
          {String? hashtag, bool? local}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getHashtagChannel, [], {#hashtag: hashtag, #local: local}),
              returnValue:
                  _FakeIWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>())
          as _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>);
  @override
  _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent> getListChannel(
          {String? listId}) =>
      (super.noSuchMethod(
              Invocation.method(#getListChannel, [], {#listId: listId}),
              returnValue:
                  _FakeIWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>())
          as _i5.IWebSocketsChannel<_i15.UnifediApiWebSocketsEvent>);
  @override
  void addDisposable(_i14.IDisposable? disposable) =>
      super.noSuchMethod(Invocation.method(#addDisposable, [disposable]),
          returnValueForMissingStub: null);
  @override
  void addDisposables(Iterable<_i14.IDisposable>? disposables) =>
      super.noSuchMethod(Invocation.method(#addDisposables, [disposables]),
          returnValueForMissingStub: null);
  @override
  _i7.Future<dynamic> performDispose() =>
      (super.noSuchMethod(Invocation.method(#performDispose, []),
          returnValue: Future<dynamic>.value()) as _i7.Future<dynamic>);
  @override
  _i7.Future<dynamic> dispose() =>
      (super.noSuchMethod(Invocation.method(#dispose, []),
          returnValue: Future<dynamic>.value()) as _i7.Future<dynamic>);
}
