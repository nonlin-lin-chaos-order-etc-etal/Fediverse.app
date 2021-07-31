import 'package:fedi/collection/collection_hash_utils.dart';
import 'package:pleroma_fediverse_api/pleroma_fediverse_api.dart';
import 'package:flutter/foundation.dart';

class EmojiText {
  final String text;
  final List<IPleromaApiEmoji>? emojis;

  EmojiText({
    required this.text,
    required this.emojis,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmojiText &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          listEquals(emojis, other.emojis);

  @override
  int get hashCode => text.hashCode ^ listHash(emojis);

  @override
  String toString() => 'EmojiText{'
      'text: $text, '
      'emojis: $emojis'
      '}';
}
