import 'package:fedi/app/chat/pleroma/repository/pleroma_chat_repository.dart';
import 'package:fedi/app/ui/badge/fedi_bool_badge_widget.dart';
import 'package:flutter/cupertino.dart';

class PleromaChatUnreadBadgeCountWidget extends FediBoolBadgeWidget {
  const PleromaChatUnreadBadgeCountWidget({
    @required Widget child,
    double offset = 2.0,
  }) : super(child: child, offset: offset);

  @override
  Stream<bool> retrieveBoolStream(BuildContext context) {
    var chatRepository = IPleromaChatRepository.of(context, listen: false);
    return chatRepository
        .watchTotalUnreadCount()
        .map((count) => count != null && count > 0);
  }
}
