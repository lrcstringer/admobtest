import 'package:freezed_annotation/freezed_annotation.dart';
import '../enums/gift_style.dart';
import '../enums/gift_status.dart';

part 'gift.freezed.dart';
part 'gift.g.dart';

@freezed
abstract class Gift with _$Gift {
  const factory Gift({
    required String id,
    required String senderId,
    required String senderName,
    required String recipientId,
    required String recipientName,
    required int amount,
    String? conversationId,
    String? communityId,
    required String messageId,
    required String message,
    required GiftStyle style,
    required GiftStatus status,
    required DateTime createdAt,
    DateTime? openedAt,
    DateTime? claimedAt,
    required DateTime expiresAt,
    String? debitTransactionId,
    String? creditTransactionId,
  }) = _Gift;

  const Gift._();

  factory Gift.fromJson(Map<String, dynamic> json) => _$GiftFromJson(json);

  bool get isPending => status == GiftStatus.pending;
  bool get isOpened => status == GiftStatus.opened;
  bool get isClaimed => status == GiftStatus.claimed;
  bool get isExpired =>
      status == GiftStatus.expired || DateTime.now().isAfter(expiresAt);
  bool get isInConversation => conversationId != null;
  bool get isInCommunity => communityId != null;
  double get amountZar => amount / 100;

  /// Display name for the gift style
  String get styleDisplayName => style.displayName;
}

@freezed
abstract class GiftStats with _$GiftStats {
  const factory GiftStats({
    required int totalSent,
    required int totalReceived,
    required int totalAmountSent,
    required int totalAmountReceived,
  }) = _GiftStats;

  factory GiftStats.fromJson(Map<String, dynamic> json) =>
      _$GiftStatsFromJson(json);
}
