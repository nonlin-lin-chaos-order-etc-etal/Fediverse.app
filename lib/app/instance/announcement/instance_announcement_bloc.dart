import 'package:fedi/app/instance/announcement/instance_announcement_model.dart';
import 'package:easy_dispose/easy_dispose.dart';
import 'package:unifedi_api/unifedi_api.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

abstract class IInstanceAnnouncementBloc implements IDisposable {
  static IInstanceAnnouncementBloc of(
    BuildContext context, {
    bool listen = true,
  }) =>
      Provider.of<IInstanceAnnouncementBloc>(context, listen: listen);

  IInstanceAnnouncement get instanceAnnouncement;

  Stream<IInstanceAnnouncement> get instanceAnnouncementStream;

  int? get localId;

  String get remoteId;

  String get content;

  List<IUnifediApiStatus>? get statuses;

  List<IUnifediApiMention>? get mentions;

  List<IUnifediApiTag>? get tags;

  bool get allDay;

  DateTime get publishedAt;

  DateTime get updatedAt;

  Stream<DateTime> get updatedAtStream;

  bool get read;

  Stream<bool> get readStream;

  List<IUnifediApiEmojiReaction>? get reactions;

  Stream<List<IUnifediApiEmojiReaction>?> get reactionsStream;

  DateTime? get scheduledAt;

  DateTime? get startsAt;

  DateTime? get endsAt;

  Future toggleEmojiReaction({
    required String emojiName,
  });

  Future addEmojiReaction({
    required String emojiName,
  });

  Future removeEmojiReaction({
    required String emojiName,
  });

  Future dismiss();
}
