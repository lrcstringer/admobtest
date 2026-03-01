import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/message.dart';
import '../../domain/enums/gift_status.dart';
import '../../domain/enums/gift_style.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/enums/message_type.dart';
import '../../domain/enums/spray_status.dart';
import '../datasources/local/app_database.dart';

/// Maps between [Message] domain entities and [LocalFullMessages] DB rows.
class LocalMessageMapper {
  /// Convert a [Message] entity to a [LocalFullMessagesCompanion] for DB insert.
  static LocalFullMessagesCompanion toCompanion(
    Message msg,
    String conversationId, {
    bool isDecrypted = true,
  }) {
    return LocalFullMessagesCompanion(
      id: Value(msg.id),
      conversationId: Value(conversationId),
      senderId: Value(msg.senderId),
      senderName: Value(msg.senderName),
      senderAvatarUrl: Value(msg.senderAvatarUrl),
      type: Value(msg.type.name),
      status: Value(msg.status.name),
      textContent: Value(msg.textContent),
      tokenAmount: Value(msg.tokenAmount),
      recipientId: Value(msg.recipientId),
      ledgerJournalId: Value(msg.ledgerJournalId),
      mediaJson: Value(msg.media != null ? jsonEncode(msg.media!.toJson()) : null),
      reactionsJson: Value(msg.reactions.isNotEmpty ? jsonEncode(msg.reactions) : null),
      replyToJson: Value(msg.replyTo != null ? jsonEncode(msg.replyTo!.toJson()) : null),
      giftJson: Value(msg.gift != null ? jsonEncode(msg.gift!.toJson()) : null),
      tokenSprayJson:
          Value(msg.tokenSpray != null ? jsonEncode(msg.tokenSpray!.toJson()) : null),
      communityId: Value(msg.communityId),
      systemEventType: Value(msg.systemEventType),
      systemEventDataJson:
          Value(msg.systemEventData != null ? jsonEncode(msg.systemEventData) : null),
      createdAt: Value(msg.createdAt),
      expiresAt: Value(msg.expiresAt),
      actionedAt: Value(msg.actionedAt),
      deletedAt: Value(msg.deletedAt),
      deletedForJson: Value(jsonEncode(msg.deletedFor)),
      deletedForEveryone: Value(msg.deletedForEveryone),
      isDecrypted: Value(isDecrypted),
      readByJson: Value(jsonEncode(
        msg.readBy.map((k, v) => MapEntry(k, v.toIso8601String())),
      )),
      forwardedFromJson: Value(
        msg.forwardedFrom != null
            ? jsonEncode(msg.forwardedFrom!.toJson())
            : null,
      ),
    );
  }

  /// Convert a [LocalFullMessage] DB row to a [Message] domain entity.
  static Message toEntity(LocalFullMessage row) {
    return Message(
      id: row.id,
      senderId: row.senderId,
      senderName: row.senderName,
      senderAvatarUrl: row.senderAvatarUrl,
      type: _parseMessageType(row.type),
      status: _parseMessageStatus(row.status),
      textContent: row.textContent,
      tokenAmount: row.tokenAmount,
      recipientId: row.recipientId,
      ledgerJournalId: row.ledgerJournalId,
      media: _parseMedia(row.mediaJson),
      reactions: _parseReactions(row.reactionsJson),
      replyTo: _parseReplyTo(row.replyToJson),
      gift: _parseGift(row.giftJson),
      tokenSpray: _parseTokenSpray(row.tokenSprayJson),
      communityId: row.communityId,
      systemEventType: row.systemEventType,
      systemEventData: _parseJsonMap(row.systemEventDataJson),
      createdAt: row.createdAt,
      expiresAt: row.expiresAt,
      actionedAt: row.actionedAt,
      deletedAt: row.deletedAt,
      deletedFor: _parseDeletedFor(row.deletedForJson),
      deletedForEveryone: row.deletedForEveryone,
      readBy: _parseReadBy(row.readByJson),
      forwardedFrom: _parseForwardedFrom(row.forwardedFromJson),
    );
  }

  static MessageType _parseMessageType(String value) {
    return MessageType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MessageType.text,
    );
  }

  static MessageStatus _parseMessageStatus(String value) {
    return MessageStatus.values.firstWhere(
      (e) => e.name == value,
      orElse: () => MessageStatus.sent,
    );
  }

  static MessageMedia? _parseMedia(String? json) {
    if (json == null) return null;
    try {
      return MessageMedia.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static Map<String, List<String>> _parseReactions(String? json) {
    if (json == null) return {};
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map(
        (k, v) => MapEntry(k, List<String>.from(v as List)),
      );
    } catch (_) {
      return {};
    }
  }

  static MessageReply? _parseReplyTo(String? json) {
    if (json == null) return null;
    try {
      return MessageReply.fromJson(jsonDecode(json) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  static GiftMessageData? _parseGift(String? json) {
    if (json == null) return null;
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      // Ensure enum fields parse correctly
      if (map['style'] is String) {
        map['style'] = GiftStyle.values
            .firstWhere((e) => e.name == map['style'], orElse: () => GiftStyle.celebration)
            .name;
      }
      if (map['status'] is String) {
        map['status'] = GiftStatus.values
            .firstWhere((e) => e.name == map['status'], orElse: () => GiftStatus.pending)
            .name;
      }
      return GiftMessageData.fromJson(map);
    } catch (e, st) {
      debugPrint('LocalMessageMapper._parseGift failed: $e\n$st');
      return null;
    }
  }

  static TokenSprayMessageData? _parseTokenSpray(String? json) {
    if (json == null) return null;
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      if (map['status'] is String) {
        map['status'] = SprayStatus.values
            .firstWhere((e) => e.name == map['status'],
                orElse: () => SprayStatus.active)
            .name;
      }
      return TokenSprayMessageData.fromJson(map);
    } catch (e, st) {
      debugPrint('LocalMessageMapper._parseTokenSpray failed: $e\n$st');
      return null;
    }
  }

  static Map<String, dynamic>? _parseJsonMap(String? json) {
    if (json == null) return null;
    try {
      return jsonDecode(json) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static List<String> _parseDeletedFor(String json) {
    try {
      return List<String>.from(jsonDecode(json) as List);
    } catch (_) {
      return [];
    }
  }

  static Map<String, DateTime> _parseReadBy(String json) {
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map(
        (k, v) => MapEntry(k, DateTime.parse(v as String)),
      );
    } catch (_) {
      return {};
    }
  }

  static ForwardedFrom? _parseForwardedFrom(String? json) {
    if (json == null) return null;
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return ForwardedFrom(
        messageId: map['messageId'] as String? ?? '',
        conversationId: map['conversationId'] as String? ?? '',
        senderName: map['senderName'] as String? ?? 'Unknown',
      );
    } catch (_) {
      return null;
    }
  }
}
