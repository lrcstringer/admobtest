import 'package:freezed_annotation/freezed_annotation.dart';

import 'inbox_thread.dart';

part 'inbox_client.freezed.dart';
part 'inbox_client.g.dart';

/// Client group in the earn inbox, containing its eligible threads
@freezed
abstract class InboxClient with _$InboxClient {
  const factory InboxClient({
    required String clientId,
    required String clientName,
    String? clientAvatarImage,
    String? clientAvatarColor,
    required bool isPinned,
    required bool isFeatured,
    required int activeThreadCount,
    required List<InboxThread> threads,
  }) = _InboxClient;

  const InboxClient._();

  factory InboxClient.fromJson(Map<String, dynamic> json) =>
      _$InboxClientFromJson(json);

  /// Total tokens available across all threads
  int get totalTokens =>
      threads.fold(0, (sum, t) => sum + t.totalTokenReward);

  /// Get client initials for avatar fallback
  String get clientInitials {
    if (clientName.isEmpty) return '??';
    final words = clientName.split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    return clientName
        .substring(0, clientName.length.clamp(0, 2))
        .toUpperCase();
  }
}
