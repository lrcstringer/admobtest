import 'dart:convert';

import 'package:drift/drift.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/enums/conversation_type.dart';
import '../datasources/local/app_database.dart';

/// Maps between [Conversation] domain entities and [LocalFullConversations] DB rows.
class LocalConversationMapper {
  /// Convert a [Conversation] entity to a [LocalFullConversationsCompanion] for DB insert.
  static LocalFullConversationsCompanion toCompanion(Conversation conv) {
    return LocalFullConversationsCompanion(
      id: Value(conv.id),
      type: Value(conv.type.name),
      participantIdsJson: Value(jsonEncode(conv.participantIds)),
      participantsJson: Value(jsonEncode(
        conv.participants.map(
          (k, v) => MapEntry(k, v.toJson()),
        ),
      )),
      lastMessageId: Value(conv.lastMessageId),
      lastMessageText: Value(conv.lastMessageText),
      lastMessageSenderId: Value(conv.lastMessageSenderId),
      lastMessageSenderName: Value(conv.lastMessageSenderName),
      lastMessageType: Value(conv.lastMessageType),
      lastMessageAt: Value(conv.lastMessageAt),
      unreadCountsJson: Value(jsonEncode(conv.unreadCounts)),
      archivedJson: Value(jsonEncode(conv.archived)),
      pinnedJson: Value(jsonEncode(conv.pinned)),
      mutedJson: Value(jsonEncode(conv.muted)),
      chatClearedAtJson: Value(jsonEncode(
        conv.chatClearedAt.map(
          (k, v) => MapEntry(k, v.toIso8601String()),
        ),
      )),
      acceptedJson: Value(jsonEncode(conv.accepted)),
      disappearingMessagesDurationMs:
          Value(conv.disappearingMessagesDuration?.inMilliseconds),
      createdAt: Value(conv.createdAt),
      updatedAt: Value(conv.updatedAt),
    );
  }

  /// Convert a [LocalFullConversation] DB row to a [Conversation] domain entity.
  static Conversation toEntity(LocalFullConversation row) {
    return Conversation(
      id: row.id,
      type: _parseConversationType(row.type),
      participantIds: _parseStringList(row.participantIdsJson),
      participants: _parseParticipants(row.participantsJson),
      lastMessageId: row.lastMessageId,
      lastMessageText: row.lastMessageText,
      lastMessageSenderId: row.lastMessageSenderId,
      lastMessageSenderName: row.lastMessageSenderName,
      lastMessageType: row.lastMessageType,
      lastMessageAt: row.lastMessageAt,
      unreadCounts: _parseIntMap(row.unreadCountsJson),
      archived: _parseBoolMap(row.archivedJson),
      pinned: _parseBoolMap(row.pinnedJson),
      muted: _parseBoolMap(row.mutedJson),
      chatClearedAt: _parseDateTimeMap(row.chatClearedAtJson),
      accepted: _parseBoolMap(row.acceptedJson),
      disappearingMessagesDuration: row.disappearingMessagesDurationMs != null
          ? Duration(milliseconds: row.disappearingMessagesDurationMs!)
          : null,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
    );
  }

  static ConversationType _parseConversationType(String value) {
    return ConversationType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ConversationType.p2p,
    );
  }

  static List<String> _parseStringList(String json) {
    try {
      return List<String>.from(jsonDecode(json) as List);
    } catch (_) {
      return [];
    }
  }

  static Map<String, ParticipantInfo> _parseParticipants(String json) {
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map(
        (k, v) => MapEntry(
          k,
          ParticipantInfo.fromJson(v as Map<String, dynamic>),
        ),
      );
    } catch (_) {
      return {};
    }
  }

  static Map<String, int> _parseIntMap(String json) {
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map((k, v) => MapEntry(k, (v as num).toInt()));
    } catch (_) {
      return {};
    }
  }

  static Map<String, bool> _parseBoolMap(String json) {
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map((k, v) => MapEntry(k, v as bool));
    } catch (_) {
      return {};
    }
  }

  static Map<String, DateTime> _parseDateTimeMap(String json) {
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return decoded.map(
        (k, v) => MapEntry(k, DateTime.parse(v as String)),
      );
    } catch (_) {
      return {};
    }
  }
}
