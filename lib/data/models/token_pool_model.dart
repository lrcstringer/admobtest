import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/token_pool.dart';
import '../../domain/enums/gift_style.dart';
import '../../domain/enums/pool_mode.dart';
import '../../domain/enums/pool_status.dart';

part 'token_pool_model.freezed.dart';

@freezed
abstract class TokenPoolModel with _$TokenPoolModel {
  const factory TokenPoolModel({
    required String id,
    required String mode,
    required String status,

    // Organizer
    required String organizerId,
    required String organizerName,

    // Recipient (sasaza only)
    String? recipientId,
    String? recipientName,

    // Conversation link
    required String conversationId,

    // Pool content
    required String title,
    @Default('') String purpose,
    @Default('') String message,
    required String style,

    // Financial
    @Default(0) int totalAmount,
    @Default(0) int totalDistributed,
    @Default(0) int contributionCount,
    @Default(0) int contributorCount,

    // Per-user contributions (raw maps)
    @Default({}) Map<String, Map<String, dynamic>> contributions,

    // Payout records (raw maps)
    @Default([]) List<Map<String, dynamic>> payouts,

    // Gift delivery references
    String? giftMessageId,
    String? giftConversationId,

    // Invitees
    @Default([]) List<String> inviteeIds,

    // Expiry
    DateTime? expiresAt,

    // Timestamps
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? sentAt,
    DateTime? openedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,

    // Ledger reference
    required String groupAccountId,

    // Notification state
    @Default(false) bool reminderSent,
  }) = _TokenPoolModel;

  const TokenPoolModel._();

  factory TokenPoolModel.fromJson(Map<String, dynamic> json) {
    return TokenPoolModel(
      id: json['id'] as String,
      mode: json['mode'] as String? ?? 'sasaza',
      status: json['status'] as String? ?? 'collecting',
      organizerId: json['organizerId'] as String,
      organizerName: json['organizerName'] as String? ?? 'Unknown',
      recipientId: json['recipientId'] as String?,
      recipientName: json['recipientName'] as String?,
      conversationId: json['conversationId'] as String? ?? '',
      title: json['title'] as String? ?? '',
      purpose: json['purpose'] as String? ?? '',
      message: json['message'] as String? ?? '',
      style: json['style'] as String? ?? 'celebration',
      totalAmount: json['totalAmount'] as int? ?? 0,
      totalDistributed: json['totalDistributed'] as int? ?? 0,
      contributionCount: json['contributionCount'] as int? ?? 0,
      contributorCount: json['contributorCount'] as int? ?? 0,
      contributions: _parseContributionsRaw(json['contributions']),
      payouts: _parsePayoutsRaw(json['payouts']),
      giftMessageId: json['giftMessageId'] as String?,
      giftConversationId: json['giftConversationId'] as String?,
      inviteeIds: json['inviteeIds'] is List
          ? List<String>.from(json['inviteeIds'] as List)
          : [],
      expiresAt: _parseDateTime(json['expiresAt']),
      createdAt: _parseDateTimeRequired(json['createdAt']),
      updatedAt: _parseDateTimeRequired(json['updatedAt']),
      sentAt: _parseDateTime(json['sentAt']),
      openedAt: _parseDateTime(json['openedAt']),
      completedAt: _parseDateTime(json['completedAt']),
      cancelledAt: _parseDateTime(json['cancelledAt']),
      groupAccountId: json['groupAccountId'] as String? ?? '',
      reminderSent: json['reminderSent'] as bool? ?? false,
    );
  }

  factory TokenPoolModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TokenPoolModel.fromJson({...data, 'id': doc.id});
  }

  TokenPool toEntity() {
    return TokenPool(
      id: id,
      mode: _parsePoolMode(mode),
      status: _parsePoolStatus(status),
      organizerId: organizerId,
      organizerName: organizerName,
      recipientId: recipientId,
      recipientName: recipientName,
      conversationId: conversationId,
      title: title,
      purpose: purpose,
      message: message,
      style: _parseGiftStyle(style),
      totalAmount: totalAmount,
      totalDistributed: totalDistributed,
      contributionCount: contributionCount,
      contributorCount: contributorCount,
      contributions: _parseContributions(contributions),
      payouts: _parsePayouts(payouts),
      giftMessageId: giftMessageId,
      giftConversationId: giftConversationId,
      inviteeIds: inviteeIds,
      expiresAt: expiresAt,
      createdAt: createdAt,
      updatedAt: updatedAt,
      sentAt: sentAt,
      openedAt: openedAt,
      completedAt: completedAt,
      cancelledAt: cancelledAt,
      groupAccountId: groupAccountId,
      reminderSent: reminderSent,
    );
  }

  // =========================================================================
  // PARSE HELPERS
  // =========================================================================

  static PoolMode _parsePoolMode(String value) {
    switch (value) {
      case 'sasaza':
        return PoolMode.sasaza;
      case 'save':
        return PoolMode.save;
      default:
        return PoolMode.sasaza;
    }
  }

  static PoolStatus _parsePoolStatus(String value) {
    switch (value) {
      case 'collecting':
        return PoolStatus.collecting;
      case 'sent':
        return PoolStatus.sent;
      case 'completed':
        return PoolStatus.completed;
      case 'cancelled':
        return PoolStatus.cancelled;
      case 'expired':
        return PoolStatus.expired;
      default:
        return PoolStatus.collecting;
    }
  }

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

  /// Parse raw Firestore contributions map into typed raw maps.
  static Map<String, Map<String, dynamic>> _parseContributionsRaw(
      dynamic raw) {
    if (raw == null || raw is! Map) return {};
    return raw.map((key, value) {
      if (value is Map) {
        return MapEntry(
          key.toString(),
          Map<String, dynamic>.from(value),
        );
      }
      return MapEntry(key.toString(), <String, dynamic>{});
    });
  }

  /// Parse raw Firestore payouts list into typed raw maps.
  static List<Map<String, dynamic>> _parsePayoutsRaw(dynamic raw) {
    if (raw == null || raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList();
  }

  /// Convert raw contribution maps to domain PoolContribution objects.
  static Map<String, PoolContribution> _parseContributions(
      Map<String, Map<String, dynamic>> raw) {
    return raw.map((key, value) {
      return MapEntry(
        key,
        PoolContribution(
          userId: value['userId'] as String? ?? key,
          displayName: value['displayName'] as String? ?? 'Unknown',
          totalAmount: value['totalAmount'] as int? ?? 0,
          contributionCount: value['contributionCount'] as int? ?? 0,
          anonymous: value['anonymous'] as bool? ?? false,
          lastContributedAt:
              _parseDateTimeRequired(value['lastContributedAt']),
        ),
      );
    });
  }

  /// Convert raw payout maps to domain PoolPayout objects.
  static List<PoolPayout> _parsePayouts(List<Map<String, dynamic>> raw) {
    return raw.map((item) {
      return PoolPayout(
        userId: item['userId'] as String? ?? '',
        displayName: item['displayName'] as String? ?? 'Unknown',
        amount: item['amount'] as int? ?? 0,
      );
    }).toList();
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
