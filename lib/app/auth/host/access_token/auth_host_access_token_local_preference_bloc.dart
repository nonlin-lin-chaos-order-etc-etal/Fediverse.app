import 'package:fedi/local_preferences/local_preference_bloc_impl.dart';
import 'package:pleroma_fediverse_api/pleroma_fediverse_api.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IAuthHostAccessTokenLocalPreferenceBloc
    implements LocalPreferenceBloc<PleromaApiOAuthToken?> {
  static IAuthHostAccessTokenLocalPreferenceBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IAuthHostAccessTokenLocalPreferenceBloc>(
        context,
        listen: listen,
      );
}
