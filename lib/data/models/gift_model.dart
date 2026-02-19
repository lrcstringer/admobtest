import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/gift.dart';
import '../../domain/enums/gift_status.dart';
import '../../domain/enums/gift_style.dart';

part 'gift_model.freezed.dart';

@freezed
class GiftModel with _$GiftModel {
  const factory GiftModel({
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
    required String style,
    required String status,
    required DateTime createdAt,
    DateTime? openedAt,
    DateTime? claimedAt,
    required DateTime expiresAt,
    String? debitTransactionId,
    String? creditTransactionId,
  }) = _GiftModel;

  const GiftModel._();

  factory GiftModel.fromJson(Map<String, dynamic> json) {
    return GiftModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      senderName: json['senderName'] as String? ?? 'Unknown',
      recipientId: json['recipientId'] as String,
      recipientName: json['recipientName'] as String? ?? 'Unknown',
      amount: json['amount'] as int? ?? 0,
      conversationId: json['conversationId'] as String?,
      communityId: json['communityId'] as String?,
      messageId: json['messageId'] as String? ?? '',
      message: json['message'] as String? ?? '',
      style: json['style'] as String? ?? 'celebration',
      status: json['status'] as String? ?? 'pending',
      createdAt: _parseDateTimeRequired(json['createdAt']),
      openedAt: _parseDateTime(json['openedAt']),
      claimedAt: _parseDateTime(json['claimedAt']),
      expiresAt: _parseDateTimeRequired(json['expiresAt']),
      debitTransactionId: json['debitTransactionId'] as String?,
      creditTransactionId: json['creditTransactionId'] as String?,
    );
  }

  factory GiftModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return GiftModel.fromJson({...data, 'id': doc.id});
  }

  Gift toEntity() {
    return Gift(
      id: id,
      senderId: senderId,
      senderName: senderName,
      recipientId: recipientId,
      recipientName: recipientName,
      amount: amount,
      conversationId: conversationId,
      communityId: communityId,
      messageId: messageId,
      message: message,
      style: _parseGiftStyle(style),
      status: _parseGiftStatus(status),
      createdAt: createdAt,
      openedAt: openedAt,
      claimedAt: claimedAt,
      expiresAt: expiresAt,
      debitTransactionId: debitTransactionId,
      creditTransactionId: creditTransactionId,
    );
  }

  // =========================================================================
  // PARSE HELPERS
  // =========================================================================

  static GiftStyle _parseGiftStyle(String value) {
    switch (value) {
      case 'ndlovukazi':
        return GiftStyle.ndlovukazi;
      case 'celebration':
        return GiftStyle.celebration;
      case 'love':
        return GiftStyle.love;
      case 'birthday':
        return GiftStyle.birthday;
      case 'professional':
        return GiftStyle.professional;
      default:
        return GiftStyle.celebration;
    }
  }

  static GiftStatus _parseGiftStatus(String value) {
    switch (value) {
      case 'pending':
        return GiftStatus.pending;
      case 'opened':
        return GiftStatus.opened;
      case 'claimed':
        return GiftStatus.claimed;
      case 'expired':
        return GiftStatus.expired;
      default:
        return GiftStatus.pending;
    }
  }

  static DateTime _parseDateTimeRequired(dynamic raw) {
    if (raw is Timestamp) return raw.toDate();
    if (raw is String) return DateTime.parse(raw);
    if (raw is DateTime) return raw;
    return DateTime.now();
  }

  static DateTime? _parseDateTime(dynamic raw) {
    if (raw == null) return null;
    if (raw is Timestamp) return raw.toDate();
    if (raw is String) return DateTime.parse(raw);
    if (raw is DateTime) return raw;
    return null;
  }
}

@freezed
class GiftStatsModel with _$GiftStatsModel {
  const factory GiftStatsModel({
    @Default(0) int totalSent,
    @Default(0) int totalReceived,
    @Default(0) int totalAmountSent,
    @Default(0) int totalAmountReceived,
  }) = _GiftStatsModel;

  const GiftStatsModel._();

  factory GiftStatsModel.fromJson(Map<String, dynamic> json) {
    return GiftStatsModel(
      totalSent: json['totalSent'] as int? ?? 0,
      totalReceived: json['totalReceived'] as int? ?? 0,
      totalAmountSent: json['totalAmountSent'] as int? ?? 0,
      totalAmountReceived: json['totalAmountReceived'] as int? ?? 0,
    );
  }

  GiftStats toEntity() {
    return GiftStats(
      totalSent: totalSent,
      totalReceived: totalReceived,
      totalAmountSent: totalAmountSent,
      totalAmountReceived: totalAmountReceived,
    );
  }
}
