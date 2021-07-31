import 'package:fedi/collection/collection_hash_utils.dart';
import 'package:fedi/duration/duration_extension.dart';
import 'package:pleroma_fediverse_api/pleroma_fediverse_api.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_status_poll_model.g.dart';

abstract class IPostStatusPoll {
  Duration? get durationLength;

  bool get hideTotals;

  bool get multiple;

  List<String> get options;
}

@JsonSerializable()
class PostStatusPoll implements IPostStatusPoll {
  @override
  @JsonKey(name: 'duration_length')
  final Duration? durationLength;

  @override
  @JsonKey(name: 'hide_totals')
  final bool hideTotals;

  @override
  final bool multiple;

  @override
  final List<String> options;

  PostStatusPoll({
    required this.durationLength,
    required this.hideTotals,
    required this.multiple,
    required this.options,
  });

  @override
  String toString() {
    return 'PostStatusPoll{'
        'durationLength: $durationLength, '
        'hideTotals: $hideTotals, '
        'multiple: $multiple, '
        'options: $options'
        '}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostStatusPoll &&
          runtimeType == other.runtimeType &&
          durationLength == other.durationLength &&
          hideTotals == other.hideTotals &&
          multiple == other.multiple &&
          listEquals(options, other.options);

  @override
  int get hashCode =>
      durationLength.hashCode ^
      hideTotals.hashCode ^
      multiple.hashCode ^
      listHash(options);

  static PostStatusPoll fromJson(Map<String, dynamic> json) =>
      _$PostStatusPollFromJson(json);

  Map<String, dynamic> toJson() => _$PostStatusPollToJson(this);
}

extension IPostStatusPollExtension on IPostStatusPoll {
  PleromaApiPostStatusPoll toPleromaPostStatusPoll() =>
      PleromaApiPostStatusPoll(
        options: options,
        multiple: multiple,
        expiresInSeconds: durationLength!.totalSeconds,
        hideTotals: hideTotals,
      );

  PostStatusPoll toPostStatusPoll() {
    if (this is PostStatusPoll) {
      return this as PostStatusPoll;
    } else {
      return PostStatusPoll(
        options: options,
        multiple: multiple,
        durationLength: durationLength,
        hideTotals: hideTotals,
      );
    }
  }

  PleromaApiPoll toPleromaPoll() {
    return PleromaApiPoll(
      id: null,
      expired: false,
      voted: true,
      multiple: multiple,
      options: options.toPleromaApiPollOptions(),
      ownVotes: [],
      votersCount: 0,
      votesCount: 0,
      expiresAt:
          durationLength != null ? DateTime.now().add(durationLength!) : null,
    );
  }
}

extension PleromaPostStatusPollExtension on IPleromaApiPostStatusPoll {
  PostStatusPoll toPostStatusPoll() {
    return PostStatusPoll(
      durationLength: expiresInSeconds.toDuration(),
      hideTotals: hideTotals,
      multiple: multiple,
      options: options,
    );
  }

  PleromaApiPostStatusPoll toPleromaApiPostStatusPoll() {
    if (this is PleromaApiPostStatusPoll) {
      return this as PleromaApiPostStatusPoll;
    } else {
      return PleromaApiPostStatusPoll(
        expiresInSeconds: expiresInSeconds,
        hideTotals: hideTotals,
        multiple: multiple,
        options: options,
      );
    }
  }
}

extension IPleromaApiPollExtension on IPleromaApiPoll {
  PleromaApiPoll toPleromaApiPoll({bool forceNewObject = false}) {
    if (this is PleromaApiPoll && !forceNewObject) {
      return this as PleromaApiPoll;
    } else {
      return PleromaApiPoll(
        expired: expired,
        expiresAt: expiresAt,
        id: id,
        multiple: multiple,
        options:
            options.toPleromaApiPollOptions(forceNewObject: forceNewObject),
        ownVotes: ownVotes,
        voted: voted,
        votesCount: votesCount,
        votersCount: votersCount,
      );
    }
  }

  PostStatusPoll toPostStatusPoll({
    required PleromaApiInstancePollLimits limits,
  }) {
    return PostStatusPoll(
      durationLength: expiresAt?.calculatePostDurationLength(
        limits: limits,
      ),
      // todo: implement  hideTotals
      hideTotals: false,
      multiple: multiple,
      options: options.toPleromaApiPollOptionTitles(),
    );
  }
}

extension IPostStatusPollPleromaApiPostStatusPollExtension on IPostStatusPoll {
  PleromaApiPostStatusPoll toPleromaApiPostStatusPoll() =>
      PleromaApiPostStatusPoll(
        options: options,
        multiple: multiple,
        expiresInSeconds: durationLength!.totalSeconds,
        hideTotals: hideTotals,
      );
}