// DEPRECATED: Use MessageModel instead. Will be removed in a future cleanup PR.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/chat_card.dart';
import '../../domain/enums/chat_card_status.dart';
import '../../domain/enums/chat_card_type.dart';

part 'chat_card_model.freezed.dart';

@freezed
class ChatCardModel with _$ChatCardModel {
  const factory ChatCardModel({
    required String id,
    required String threadId,
    required String senderId,
    required String type,
    required String status,
    String? textContent,
    int? tokenAmount,
    String? mediaUrl,
    String? mediaType,
    String? actionData,
    DateTime? expiresAt,
    required DateTime createdAt,
    DateTime? readAt,
    DateTime? actionedAt,
    String? recipientId,
  }) = _ChatCardModel;

  const ChatCardModel._();

  factory ChatCardModel.fromJson(Map<String, dynamic> json) {
    final createdAt = json['createdAt'];
    final expiresAt = json['expiresAt'];
    final readAt = json['readAt'];
    final actionedAt = json['actionedAt'];

    return ChatCardModel(
      id: json['id'] as String,
      threadId: json['threadId'] as String,
      senderId: json['senderId'] as String,
      type: json['type'] as String? ?? 'text',
      status: json['status'] as String? ?? 'pending',
      textContent: json['textContent'] as String?,
      tokenAmount: json['tokenAmount'] as int?,
      mediaUrl: json['mediaUrl'] as String?,
      mediaType: json['mediaType'] as String?,
      actionData: json['actionData'] as String?,
      expiresAt: expiresAt == null
          ? null
          : expiresAt is Timestamp
              ? expiresAt.toDate()
              : DateTime.parse(expiresAt as String),
      createdAt: createdAt is Timestamp
          ? createdAt.toDate()
          : DateTime.parse(createdAt as String),
      readAt: readAt == null
          ? null
          : readAt is Timestamp
              ? readAt.toDate()
              : DateTime.parse(readAt as String),
      actionedAt: actionedAt == null
          ? null
          : actionedAt is Timestamp
              ? actionedAt.toDate()
              : DateTime.parse(actionedAt as String),
      recipientId: json['recipientId'] as String?,
    );
  }

  Map<String, dynamic> toFirestoreJson() {
    return {
      'threadId': threadId,
      'senderId': senderId,
      'type': type,
      'status': status,
      'textContent': textContent,
      'tokenAmount': tokenAmount,
      'mediaUrl': mediaUrl,
      'mediaType': mediaType,
      'actionData': actionData,
      'expiresAt': expiresAt != null ? Timestamp.fromDate(expiresAt!) : null,
      'createdAt': Timestamp.fromDate(createdAt),
      'readAt': readAt != null ? Timestamp.fromDate(readAt!) : null,
      'actionedAt': actionedAt != null ? Timestamp.fromDate(actionedAt!) : null,
      'recipientId': recipientId,
    };
  }

  ChatCard toEntity() {
    return ChatCard(
      id: id,
      threadId: threadId,
      senderId: senderId,
      type: _parseCardType(type),
      status: _parseCardStatus(status),
      textContent: textContent,
      tokenAmount: tokenAmount,
      mediaUrl: mediaUrl,
      mediaType: mediaType,
      actionData: actionData,
      expiresAt: expiresAt,
      createdAt: createdAt,
      readAt: readAt,
      actionedAt: actionedAt,
      recipientId: recipientId,
    );
  }

  factory ChatCardModel.fromEntity(ChatCard entity) {
    return ChatCardModel(
      id: entity.id,
      threadId: entity.threadId,
      senderId: entity.senderId,
      type: entity.type.name,
      status: entity.status.name,
      textContent: entity.textContent,
      tokenAmount: entity.tokenAmount,
      mediaUrl: entity.mediaUrl,
      mediaType: entity.mediaType,
      actionData: entity.actionData,
      expiresAt: entity.expiresAt,
      createdAt: entity.createdAt,
      readAt: entity.readAt,
      actionedAt: entity.actionedAt,
      recipientId: entity.recipientId,
    );
  }

  static ChatCardType _parseCardType(String type) {
    switch (type) {
      case 'text':
        return ChatCardType.text;
      case 'tokenSend':
        return ChatCardType.tokenSend;
      case 'tokenRequest':
        return ChatCardType.tokenRequest;
      case 'tokenReceived':
        return ChatCardType.tokenReceived;
      case 'system':
        return ChatCardType.system;
      case 'image':
        return ChatCardType.image;
      default:
        return ChatCardType.text;
    }
  }

  static ChatCardStatus _parseCardStatus(String status) {
    switch (status) {
      case 'pending':
        return ChatCardStatus.pending;
      case 'paid':
        return ChatCardStatus.paid;
      case 'declined':
        return ChatCardStatus.declined;
      case 'expired':
        return ChatCardStatus.expired;
      case 'cancelled':
        return ChatCardStatus.cancelled;
      default:
        return ChatCardStatus.pending;
    }
  }
}
