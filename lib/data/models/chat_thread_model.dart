// DEPRECATED: Use ConversationModel instead. Will be removed in a future cleanup PR.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/chat_thread.dart';

part 'chat_thread_model.freezed.dart';

@freezed
class ChatThreadModel with _$ChatThreadModel {
  const factory ChatThreadModel({
    required String id,
    required String type,
    required List<String> participantIds,
    required String displayName,
    String? avatarUrl,
    String? avatarColor,
    String? lastMessagePreview,
    DateTime? lastMessageAt,
    required int unreadCount,
    required bool isPinned,
    required bool isMuted,
    required bool isArchived,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) = _ChatThreadModel;

  const ChatThreadModel._();

  factory ChatThreadModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    final updatedAt = json['updatedAt'];
    final lastMessageAt = json['lastMessageAt'];
    final participantIds = json['participantIds'];

    return ChatThreadModel(
      id: json['id'] as String,
      type: json['type'] as String? ?? 'p2p',
      participantIds: participantIds is List
          ? List<String>.from(participantIds)
          : <String>[],
      displayName: json['displayName'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
      avatarColor: json['avatarColor'] as String?,
      lastMessagePreview: json['lastMessagePreview'] as String?,
      lastMessageAt: lastMessageAt == null
          ? null
          : lastMessageAt is Timestamp
              ? lastMessageAt.toDate()
              : DateTime.parse(lastMessageAt as String),
      unreadCount: json['unreadCount'] as int? ?? 0,
      isPinned: json['isPinned'] as bool? ?? false,
      isMuted: json['isMuted'] as bool? ?? false,
      isArchived: json['isArchived'] as bool? ?? false,
      createdAt: createdAt is Timestamp
          ? createdAt.toDate()
          : DateTime.parse(createdAt as String),
      updatedAt: updatedAt == null
          ? null
          : updatedAt is Timestamp
              ? updatedAt.toDate()
              : DateTime.parse(updatedAt as String),
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'type': type,
      'participantIds': participantIds,
      'displayName': displayName,
      'avatarUrl': avatarUrl,
      'avatarColor': avatarColor,
      'lastMessagePreview': lastMessagePreview,
      'lastMessageAt':
          lastMessageAt != null ? Timestamp.fromDate(lastMessageAt!) : null,
      'unreadCount': unreadCount,
      'isPinned': isPinned,
      'isMuted': isMuted,
      'isArchived': isArchived,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  ChatThread toEntity() {
    return ChatThread(
      id: id,
      type: _parseThreadType(type),
      participantIds: participantIds,
      displayName: displayName,
      avatarUrl: avatarUrl,
      avatarColor: avatarColor,
      lastMessagePreview: lastMessagePreview,
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
      isPinned: isPinned,
      isMuted: isMuted,
      isArchived: isArchived,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory ChatThreadModel.fromEntity(ChatThread entity) {
    return ChatThreadModel(
      id: entity.id,
      type: entity.type.name,
      participantIds: entity.participantIds,
      displayName: entity.displayName,
      avatarUrl: entity.avatarUrl,
      avatarColor: entity.avatarColor,
      lastMessagePreview: entity.lastMessagePreview,
      lastMessageAt: entity.lastMessageAt,
      unreadCount: entity.unreadCount,
      isPinned: entity.isPinned,
      isMuted: entity.isMuted,
      isArchived: entity.isArchived,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  static ChatThreadType _parseThreadType(String type) {
    switch (type) {
      case 'p2p':
        return ChatThreadType.p2p;
      case 'brand':
        return ChatThreadType.brand;
      case 'system':
        return ChatThreadType.system;
      default:
        return ChatThreadType.p2p;
    }
  }
}
