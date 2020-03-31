import 'package:fedi/refactored/pleroma/api/pleroma_api_service.dart';
import 'package:fedi/refactored/pleroma/rest/auth/pleroma_auth_rest_service.dart';
import 'package:fedi/refactored/pleroma/search/pleroma_search_exception.dart';
import 'package:fedi/refactored/pleroma/search/pleroma_search_model.dart';
import 'package:fedi/refactored/pleroma/search/pleroma_search_service.dart';
import 'package:fedi/refactored/rest/rest_request_model.dart';
import 'package:flutter/widgets.dart';

class PleromaSearchService implements IPleromaSearchService {
  final IPleromaAuthRestService restService;

  PleromaSearchService({@required this.restService});

  @override
  Stream<PleromaApiState> get pleromaStateStream =>
      restService.pleromaStateStream;

  @override
  PleromaApiState get pleromaState => restService.pleromaState;

  @override
  Stream<bool> get isApiReadyToUseStream => restService.isApiReadyToUseStream;
  @override
  bool get isApiReadyToUse => restService.isApiReadyToUse;

  @override
  bool get isConnected => restService.isConnected;

  @override
  Stream<bool> get isConnectedStream => restService.isConnectedStream;

  @override
  void dispose() {
    // nothing
  }

  @override
  Future<IPleromaSearchResult> search(
      {@required IPleromaSearchRequest request}) async {
    if (request.limit != null) {
      assert(request.limit <= 40, "Server-side limit");
    }

    var queryArgs = request
        .toJson()
        .entries
        .where((entry) => entry.value != null)
        .map((entry) => RestRequestQueryArg(entry.key, entry.value.toString()))
        .toList();

    var httpResponse = await restService.sendHttpRequest(
        RestRequest.get(relativePath: "/api/v2/search", queryArgs: queryArgs));

    if (httpResponse.statusCode == 200) {
      return PleromaSearchResult.fromJsonString(httpResponse.body);
    } else {
      throw PleromaSearchException(
          statusCode: httpResponse.statusCode, body: httpResponse.body);
    }
  }
}
