import 'package:freezed_annotation/freezed_annotation.dart';

part 'starred_message.freezed.dart';
part 'starred_message.g.dart';

/// A lightweight reference to a starred/bookmarked message.
///
/// Stored in `users/{userId}/starredMessages/{conversationId}_{messageId}`.
/// Per-user, private — other users don't see your stars.
@freezed
class StarredMessage with _$StarredMessage {
  const factory StarredMessage({
    required String messageId,
    required String conversationId,
    required DateTime starredAt,
    required String senderName,
    required String messageType,
    String? messagePreview,
  }) = _StarredMessage;

  factory StarredMessage.fromJson(Map<String, dynamic> json) =>
      _$StarredMessageFromJson(json);
}
