import 'package:fedi/app/account/my/settings/my_account_settings_local_preference_bloc.dart';
import 'package:fedi/app/ui/media/player/audio/fedi_audio_player_widget.dart';
import 'package:fedi/disposable/disposable_provider.dart';
import 'package:fedi/media/player/audio/audio_media_player_bloc.dart';
import 'package:fedi/media/player/audio/audio_media_player_bloc_impl.dart';
import 'package:fedi/media/player/media_player_model.dart';
import 'package:fedi/pleroma/media/attachment/pleroma_media_attachment_model.dart';
import 'package:flutter/material.dart';

class MediaAttachmentAudioWidget extends StatelessWidget {
  const MediaAttachmentAudioWidget();

  @override
  Widget build(BuildContext context) {
    var settingsLocalPreferenceBloc =
        IMyAccountSettingsLocalPreferenceBloc.of(context);
    return DisposableProxyProvider<IPleromaMediaAttachment,
        IAudioMediaPlayerBloc>(
      update: (context, mediaAttachment, _) =>
          AudioMediaPlayerBloc.createFromContext(
        context,
        autoInit: settingsLocalPreferenceBloc.value?.mediaAutoInit == true,
        autoPlay: settingsLocalPreferenceBloc.value?.mediaAutoPlay == true,
        mediaPlayerSource:
            MediaPlayerSource.network(networkUrl: mediaAttachment.url),
      ),
      child: const FediAudioPlayerWidget(),
    );
  }
}
