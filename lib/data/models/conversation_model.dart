import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/conversation.dart';
import '../../domain/enums/conversation_type.dart';

part 'conversation_model.freezed.dart';

@freezed
class ConversationModel with _$ConversationModel {
  const factory ConversationModel({
    required String id,
    required String type,
    required List<String> participantIds,
    required Map<String, Map<String, dynamic>> participants,

    // Last message preview
    String? lastMessageId,
    String? lastMessageText,
    String? lastMessageSenderId,
    String? lastMessageSenderName,
    String? lastMessageType,
    DateTime? lastMessageAt,

    // Per-user state maps
    required Map<String, int> unreadCounts,
    required Map<String, bool> archived,
    required Map<String, bool> pinned,
    required Map<String, bool> muted,

    // E2EE: per-user encrypted last message previews
    @Default({}) Map<String, String> lastMessageEncryptedPreviews,

    // Per-user chat cleared timestamps
    @Default({}) Map<String, DateTime> chatClearedAt,

    // Per-user acceptance status (message request system)
    @Default({}) Map<String, bool> accepted,

    // Timestamps
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ConversationModel;

  const ConversationModel._();

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    final updatedAt = json['updatedAt'];
    final lastMessageAt = json['lastMessageAt'];
    final participantIds = json['participantIds'];
    final lastMessage = json['lastMessage'] as Map<String, dynamic>?;

    return ConversationModel(
      id: json['id'] as String,
      type: json['type'] as String? ?? 'p2p',
      participantIds: participantIds is List
          ? List<String>.from(participantIds)
          : <String>[],
      participants: _parseParticipants(json['participants']),
      lastMessageId: json['lastMessageId'] as String?,
      lastMessageText: lastMessage?['text'] as String? ??
          json['lastMessageText'] as String?,
      lastMessageSenderId: lastMessage?['senderId'] as String? ??
          json['lastMessageSenderId'] as String?,
      lastMessageSenderName: lastMessage?['senderName'] as String? ??
          json['lastMessageSenderName'] as String?,
      lastMessageType: lastMessage?['type'] as String? ??
          json['lastMessageType'] as String?,
      lastMessageAt: _parseDateTime(
          lastMessage?['timestamp'] ?? lastMessageAt),
      unreadCounts: _parseIntMap(json['unreadCounts']),
      archived: _parseBoolMap(json['archived']),
      pinned: _parseBoolMap(json['pinned']),
      muted: _parseBoolMap(json['muted']),
      lastMessageEncryptedPreviews:
          _parseStringMap(json['lastMessageEncryptedPreviews']),
      chatClearedAt: _parseDateTimeMap(json['chatClearedAt']),
      accepted: _parseBoolMap(json['accepted']),
      createdAt: _parseDateTimeRequired(createdAt),
      updatedAt: _parseDateTime(updatedAt),
    );
  }

  factory ConversationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return ConversationModel.fromJson({...data, 'id': doc.id});
  }

  Conversation toEntity() {
    return Conversation(
      id: id,
      type: _parseConversationType(type),
      participantIds: participantIds,
      participants: participants.map(
        (key, value) => MapEntry(
          key,
          ParticipantInfo(
            displayName: value['displayName'] as String? ?? 'Unknown',
            avatarUrl: value['avatarUrl'] as String?,
          ),
        ),
      ),
      lastMessageId: lastMessageId,
      lastMessageText: lastMessageText,
      lastMessageSenderId: lastMessageSenderId,
      lastMessageSenderName: lastMessageSenderName,
      lastMessageType: lastMessageType,
      lastMessageAt: lastMessageAt,
      unreadCounts: unreadCounts,
      archived: archived,
      pinned: pinned,
      muted: muted,
      lastMessageEncryptedPreviews: lastMessageEncryptedPreviews,
      chatClearedAt: chatClearedAt,
      accepted: accepted,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ConversationModel.fromEntity(Conversation entity) {
    return ConversationModel(
      id: entity.id,
      type: entity.type.name,
      participantIds: entity.participantIds,
      participants: entity.participants.map(
        (key, value) => MapEntry(key, {
          'displayName': value.displayName,
          'avatarUrl': value.avatarUrl,
        }),
      ),
      lastMessageId: entity.lastMessageId,
      lastMessageText: entity.lastMessageText,
      lastMessageSenderId: entity.lastMessageSenderId,
      lastMessageSenderName: entity.lastMessageSenderName,
      lastMessageType: entity.lastMessageType,
      lastMessageAt: entity.lastMessageAt,
      unreadCounts: entity.unreadCounts,
      archived: entity.archived,
      pinned: entity.pinned,
      muted: entity.muted,
      lastMessageEncryptedPreviews: entity.lastMessageEncryptedPreviews,
      chatClearedAt: entity.chatClearedAt,
      accepted: entity.accepted,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // =========================================================================
  // PARSE HELPERS
  // =========================================================================

  static ConversationType _parseConversationType(String type) {
    switch (type) {
      case 'p2p':
        return ConversationType.p2p;
      case 'brand':
        return ConversationType.brand;
      case 'system':
        return ConversationType.system;
      default:
        return ConversationType.p2p;
    }
  }

  static Map<String, Map<String, dynamic>> _parseParticipants(dynamic raw) {
    if (raw == null) return {};
    if (raw is! Map) return {};
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

  static Map<String, String> _parseStringMap(dynamic raw) {
    if (raw == null) return {};
    if (raw is! Map) return {};
    return raw.map((key, value) => MapEntry(
          key.toString(),
          value is String ? value : '',
        ));
  }

  static Map<String, DateTime> _parseDateTimeMap(dynamic raw) {
    if (raw == null) return {};
    if (raw is! Map) return {};
    final result = <String, DateTime>{};
    for (final entry in raw.entries) {
      final dt = _parseDateTime(entry.value);
      if (dt != null) result[entry.key.toString()] = dt;
    }
    return result;
  }

  static Map<String, int> _parseIntMap(dynamic raw) {
    if (raw == null) return {};
    if (raw is! Map) return {};
    return raw.map((key, value) => MapEntry(
          key.toString(),
          value is int ? value : 0,
        ));
  }

  static Map<String, bool> _parseBoolMap(dynamic raw) {
    if (raw == null) return {};
    if (raw is! Map) return {};
    return raw.map((key, value) => MapEntry(
          key.toString(),
          value is bool ? value : false,
        ));
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
